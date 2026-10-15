"""Generate IPC's expanded-species data from the approved reviews (A-0080, 1.1.69).

Run from anywhere:  python tools/gen_expanded.py [--check]

Inputs (read-only):
  tools/team_sources/IPC-normal-team-variants-2026-10-11.json   (developer-approved)
  tools/team_sources/IPC-developer-team-review-2026-10-11.json  (developer-approved)
  ../exchange/species/catalog.json, ../exchange/species/definitions/, ../sprites/species/
  ../exchange/species/runtime.json + ../Expanded-Species (git `next`:main.lua)
  %APPDATA%/pokemon-love2d/crystal/data/generated/pokemon.lua    (vanilla species ids)

Outputs (all generated -- never hand-edit):
  weighted_teams.lua   VERIFIED, not written: the Gen 1/2 track rebuilt from the
                       review must equal the shipped file byte-for-byte, which
                       proves this reader agrees with the table already approved.
  expanded_teams.lua   the same 89 trainers, expanded variants (same format)
  dev_teams.lua        the 26 reviewed developer candidates, both tracks
  species_index.lua    what main.lua registers: id, definition file, art paths
  shared_species.json  the gate's declaration (exchange/species_gate.py)
  species/<slug>.lua   catalog definitions, byte copies
  assets/species/*.png catalog battle art, byte copies
  lib/expanded_species_runtime.lua  released runtime, byte copy

--check rebuilds everything in memory and exits non-zero if any output on disk
differs, so a stale generated file cannot ship.
"""
import hashlib
import json
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
MOD = os.path.dirname(HERE)
WORK = os.path.dirname(MOD)
SRC_NORMAL = os.path.join(HERE, "team_sources", "IPC-normal-team-variants-2026-10-11.json")
SRC_DEV = os.path.join(HERE, "team_sources", "IPC-developer-team-review-2026-10-11.json")
# Developer trainers added after the 2026-10-11 review (Scissorman, 1.1.71),
# same shape; appended after the reviewed 26.
SRC_DEV_ADD = os.path.join(HERE, "team_sources", "IPC-developer-team-additions.json")
CATALOG = os.path.join(WORK, "exchange", "species", "catalog.json")
RUNTIMES = os.path.join(WORK, "exchange", "species", "runtime.json")
ES_REPO = os.path.join(WORK, "Expanded-Species")
ROM_POKEMON = os.path.join(os.environ.get("APPDATA", ""), "pokemon-love2d", "crystal",
                           "data", "generated", "pokemon.lua")

STRENGTHS = ("Early", "Middle", "Full")
# Gender is not a form (developer, 2026-10-11): species art serves every gender.
GENDER_FORMS = {"Male", "Female"}


def sha(b):
    return hashlib.sha256(b).hexdigest()


def load_json(p):
    with open(p, encoding="utf-8") as f:
        return json.load(f)


def rom_ids():
    with open(ROM_POKEMON, encoding="utf-8") as f:
        return set(re.findall(r"^  ([A-Z][A-Z0-9_]*) = \{", f.read(), re.M))


def vanilla_id(name):
    # Display name -> pokecrystal constant. MR__MIME has TWO underscores
    # (". " is two characters); FARFETCH_D; NIDORAN_M/_F.
    n = name.upper().replace("♂", "_M").replace("♀", "_F")
    n = n.replace("'", "_").replace(". ", "__").replace(".", "_")
    n = n.replace("-", "_").replace(" ", "_")
    return n


class Resolver:
    def __init__(self, catalog, roms):
        self.roms = roms
        self.active = {}      # (species lower, form) -> entry
        self.held = {}        # species lower -> entry (not activated)
        for e in catalog["entries"]:
            key = (e["species"].lower(), self.form(e["requested_form"]))
            if e.get("activation_allowed"):
                self.active[key] = e
            else:
                self.held[e["species"].lower()] = e
        self.used = {}        # registry_id -> entry

    @staticmethod
    def form(f):
        f = f or ""
        return "" if f in GENDER_FORMS else f

    def __call__(self, name, form=""):
        """-> (species id, expanded entry or None, held entry or None)"""
        m = re.match(r"^(.*) \[(.+)\]$", name)   # dev review spells forms "Gible [Female]"
        if m:
            name, form = m.group(1), m.group(2)
        key =(name.lower(), self.form(form))
        e = self.active.get(key)
        if e is None and key[1] == "":
            # a gendered catalog row ("Rhyperior", "Male") collapses to default
            for (s, f), cand in self.active.items():
                if s == key[0] and f == "":
                    e = cand
        if e is not None:
            self.used[e["registry_id"]] = e
            return e["registry_id"], e, None
        if name.lower() in self.held:
            return None, None, self.held[name.lower()]
        vid = vanilla_id(name)
        if key[1] == "A" and vid == "UNOWN":
            key = (key[0], "")   # Unown's letter is its DVs, not a species
        if key[1]:
            raise SystemExit(f"form {form!r} of {name} is neither a catalog entry nor vanilla")
        if vid not in self.roms:
            raise SystemExit(f"{name!r} -> {vid}: not a Crystal species and not in the catalog")
        return vid, None, None


def rows(resolve, mons, held_out):
    out = []
    for m in mons:
        sid, _, held = resolve(m["species"], m.get("form", ""))
        if held is not None:
            held_out.add(held["species"])
            out.append(None)
            continue
        out.append({"species": sid, "delta": int(m["offset"])})
    return out


def lua_party(party):
    # a held slot (None) only ever appears in a dev track that is then
    # replaced by `false`, so its text never reaches an output
    return "{" + ",".join('{["species"]="%s",["delta"]=%d}' % (m["species"], m["delta"])
                          if m else "HELD" for m in party) + "}"


def lua_sizes(small, six):
    return "{[3]=%s,[6]=%s}" % (lua_party(small), lua_party(six))


def team_table(trainers, resolve, track, header):
    lines = [header, "return {"]
    for t in trainers:
        by = {v["strength"]: v for v in t["variants"]}
        held = set()
        var = ",".join('["%s"]=%s' % (s, lua_sizes(rows(resolve, by[s][track + "_small"], held),
                                                   rows(resolve, by[s][track + "_six"], held)))
                       for s in STRENGTHS)
        if held:
            raise SystemExit(f"normal trainer {t['key']} uses held species {held}")
        body = '["tier"]=%d,["variants"]={%s}' % (t["tier"], var)
        lv = t.get("legendary_variant")
        if lv:
            body += ',["legendary"]=%s' % lua_sizes(rows(resolve, lv[track + "_small"], held),
                                                     rows(resolve, lv[track + "_six"], held))
        lines.append('  ["%s"]={%s},' % (t["key"], body))
    lines[-1] = lines[-1][:-1]
    lines.append("}")
    return "\n".join(lines) + "\n"


def dev_table(trainers, resolve):
    lines = ["-- Generated by tools/gen_expanded.py from the developer-team review",
             "-- (2026-10-11). Developer selection only; never in an ordinary draw.",
             "-- held = expanded species the catalog has not activated: that trainer's",
             "-- expanded track is OFF and shows so; its Gen 1/2 track stays selectable.",
             "return {"]
    report = {}
    for t in trainers:
        by = {v["strength"]: v for v in t["variants"]}
        held = set()
        parts = []
        for track in ("gen12", "expanded"):
            tv = ",".join('["%s"]=%s' % (s, lua_sizes(rows(resolve, by[s][track + "_small"], held),
                                                      rows(resolve, by[s][track + "_six"], held)))
                          for s in STRENGTHS)
            parts.append('["%s"]={%s}' % (track, tv))
        if held:
            # a held slot is None; drop the expanded track entirely rather than
            # ship a party with a hole in it
            parts[1] = '["expanded"]=false'
            parts.append('["held"]={%s}' % ",".join('"%s"' % h for h in sorted(held)))
        lines.append('  ["%s"]={%s},' % (t["key"], ",".join(parts)))
        report[t["key"]] = sorted(held)
    lines[-1] = lines[-1][:-1]
    lines.append("}")
    return "\n".join(lines) + "\n", report


def main(argv):
    check = "--check" in argv
    catalog = load_json(CATALOG)
    resolve = Resolver(catalog, rom_ids())
    normal = load_json(SRC_NORMAL)
    dev = load_json(SRC_DEV)
    assert normal["count"] == len(normal["trainers"]) == 89, "normal count"
    assert len(dev["trainers"]) == 26, "dev candidate count"
    added = load_json(SRC_DEV_ADD)["trainers"]
    clash = {t["key"] for t in added} & {t["key"] for t in dev["trainers"]}
    assert not clash, f"added dev trainers already reviewed: {clash}"
    dev["trainers"] = dev["trainers"] + added

    outputs = {}   # relative path -> bytes
    fails = []

    # 1. Gen 1/2 track must reproduce the shipped table exactly.
    gen12 = team_table(normal["trainers"], resolve, "gen12",
                       "-- Generated from approved Gen 1/2 composition review; no expanded species.")
    shipped = open(os.path.join(MOD, "weighted_teams.lua"), "rb").read().replace(b"\r\n", b"\n")
    if gen12.encode() != shipped:
        fails.append("gen12 track does not reproduce weighted_teams.lua byte-for-byte")
    resolve.used.clear()   # gen12 must not need any added species
    team_table(normal["trainers"], resolve, "gen12", "")
    if resolve.used:
        fails.append(f"gen12 track resolved added species {sorted(resolve.used)}")

    # 2. Expanded track, normal trainers.
    outputs["expanded_teams.lua"] = team_table(
        normal["trainers"], resolve, "expanded",
        "-- Generated by tools/gen_expanded.py from the approved normal-team review\n"
        "-- (2026-10-11). Expanded track; same trainers, tiers and offsets as\n"
        "-- weighted_teams.lua. Used only when IPC registered every species it needs.").encode()
    normal_ids = set(resolve.used)

    # 3. Developer candidates, both tracks.
    dev_lua, held_report = dev_table(dev["trainers"], resolve)
    outputs["dev_teams.lua"] = dev_lua.encode()

    # 4. Cross-check against the catalog's per-slot uses: every use must name a
    #    trainer/strength/size/slot whose generated species is that entry.
    def gen_slot(scope, trainer, strength, size, slot):
        src = normal["trainers"] if scope == "normal" else dev["trainers"]
        t = next((x for x in src if x["key"] == trainer), None)
        if t is None:
            return None
        v = next(x for x in t["variants"] if x["strength"] == strength)
        mons = v["expanded_small" if size == 3 else "expanded_six"]
        if slot > len(mons):
            return None
        m = mons[slot - 1]
        return resolve(m["species"], m.get("form", ""))[0]
    for e in catalog["entries"]:
        if not e.get("activation_allowed"):
            continue
        for u in e["uses"]:
            got = gen_slot(u["scope"], u["trainer"], u["strength"], u["party_size"], u["slot"])
            if got != e["registry_id"]:
                fails.append(f"catalog use {e['registry_id']} @ {u['trainer']} {u['strength']} "
                             f"{u['party_size']} slot {u['slot']}: generated {got}")

    # 5. Species payload: definitions, art, index, gate declaration.
    used = sorted(resolve.used.values(), key=lambda e: e["registry_id"])
    index = ["-- Generated by tools/gen_expanded.py. Species IPC registers in Expanded",
             "-- mode, each the catalog's definition byte-for-byte. back=false: the",
             "-- catalog has no back art (Obstagoon); main.lua points the required",
             "-- spriteBack at the front file -- opponent-only, a back is never drawn.",
             "return {"]
    provides = []
    for e in used:
        cl = e["clearance"]
        dfile = os.path.join(WORK, e["definition"]["file"])
        dbytes = open(dfile, "rb").read()
        if sha(dbytes) != e["definition"]["semantic_sha256"]:
            fails.append(f"{e['registry_id']}: definition file hash != catalog")
        slug = os.path.splitext(os.path.basename(dfile))[0]
        outputs[f"species/{slug}.lua"] = dbytes
        assets = {}
        # "anim" (catalog 2026-10-14.1+): the front-animation sheet, base frame
        # first; main.lua points def.anim.sheet at it (REQUESTS 132)
        for role in ("front", "back", "anim"):
            rel = (cl.get("asset_files") or {}).get(role)
            if not rel:
                continue
            b = open(os.path.join(WORK, rel), "rb").read()
            if sha(b) != cl["asset_hashes"][role]:
                fails.append(f"{e['registry_id']} {role}: art hash != catalog")
            dest = "assets/species/" + os.path.basename(rel)
            outputs[dest] = b
            assets[role] = dest
        index.append('  { id = "%s", file = "species/%s.lua", front = "%s", back = %s, anim = %s, normal = %s },'
                     % (e["registry_id"], slug, assets["front"],
                        '"%s"' % assets["back"] if "back" in assets else "false",
                        '"%s"' % assets["anim"] if "anim" in assets else "false",
                        "true" if e["registry_id"] in normal_ids else "false"))
        provides.append({"entry_key": e["entry_key"], "registry_id": e["registry_id"],
                         "definition_sha256": e["definition"]["semantic_sha256"],
                         "credit": cl["credit"], "assets": assets})
    index.append("}")
    outputs["species_index.lua"] = ("\n".join(index) + "\n").encode()
    decl = {"contract": "shared-pokemon-identity",
            "catalog_revision": catalog["catalog_revision"],
            "generated_by": "tools/gen_expanded.py", "provides": provides, "consumes": []}
    outputs["shared_species.json"] = (json.dumps(decl, indent=2, ensure_ascii=False) + "\n").encode()

    # 6. Runtime: the released bytes only.
    rt = load_json(RUNTIMES)
    want = {r["sha256"] for r in rt["released"]}
    rtb = subprocess.run(["git", "-C", ES_REPO, "show", "next:main.lua"],
                         capture_output=True, check=True).stdout
    if sha(rtb) not in want:
        fails.append("Expanded-Species next:main.lua is not a released runtime")
    outputs[rt["path_in_consumer"]] = rtb

    # write / check
    stale = []
    for rel, data in sorted(outputs.items()):
        p = os.path.join(MOD, rel)
        cur = open(p, "rb").read() if os.path.exists(p) else None
        if cur != data:
            stale.append(rel)
            if not check:
                os.makedirs(os.path.dirname(p), exist_ok=True)
                with open(p, "wb") as f:
                    f.write(data)
    print(f"species registered in Expanded mode: {len(used)} "
          f"({len(normal_ids)} normal-team, {len(used) - len(normal_ids)} developer-only)")
    print("held developer variants:", {k: v for k, v in held_report.items() if v} or "none")
    for f in fails:
        print("FAIL", f)
    if check and stale:
        print("STALE", ", ".join(stale))
    elif not check:
        print(f"wrote {len(stale)} file(s)")
    return 1 if fails or (check and stale) else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
