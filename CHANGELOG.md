# Changelog

All notable changes to Indigo Plateau Conference are documented here.
Format follows [keep a changelog](https://keepachangelog.com/); the top
heading always equals the version in `manifest.json`.

## 0.1.5

**The opponent gets his line.** 0.1.4 made him say "..." — which turned
out to be the engine's own placeholder, not a failure.

Talking to an NPC with `def.trainer` hands the press to the cart's
bytecode, and `TALK_TO_TRAINER_SCRIPT` runs `trainertext index=0`. That
reads `trainerObject.seenText` and looks it up in the VM's decoded text
pool; `Vm:showText` substitutes the literal "..." when the body is
missing. No `seenText` was supplied, so that is what showed.

Two different text paths, which is the part worth remembering: the host's
dialogue is ours (`queueScript` takes a raw string), while a trainer's
pre-battle line is the ROM's (a key lookup in its own pool). The `text`
registry has a Gen 2 target, so this build registers seen/win/loss keys
and points the trainer record at them.

Deliberately **no `event` flag** on the trainer record. With none, the
beaten-check always reads false and the opponent can be fought again —
which is what a repeatable tournament needs. A real flag would retire
each challenger permanently after one win.

## 0.1.4

**Fixes 0.1.3 loading nothing at all.**

The hook was registered with `mod.hooks:on`. The loader builds the
mod-facing hook api as `hooks = { wrap = ... }` and nothing else, so `:on`
was nil — and calling it threw in the **entry chunk**, which rolls the
whole mod back. Nothing spawned, no host, no opponent, while the mod
manager still reported Ready. Now `mod.hooks:wrap`.

Worth recording why it got this far: `engine/mods/spanish_ui` uses
`mod.hooks:on`, and it was taken from there instead of from the loader.
The house rule already covers this — read the source that implements the
API, not a mod that calls it.

## 0.1.3

**The tournament moved to the room you can actually reach.**

0.1.2 put everything in `COLOSSEUM`. On device that room turned out to be
unreachable in single player: the Pokémon Center 2F attendant only opens
it once a link partner is connected. So the tournament now runs in
`POKECENTER_2F` itself — the room at the top of the stairs — and the venue
still keys off which town you climbed from, unchanged.

Getting into the Colosseum is demoted to an **experiment the host offers**,
because `mod.world:warpTo` checks only that the map exists and never
consults the attendant. The door may open for a mod even though it does
not for the player. If it does, a way-back attendant is waiting inside, and
the return cell is remembered before you leave so a save made in there can
still get out.

Deliberately kept independent: the warp experiment cannot block the battle
probe. They are two separate questions and this build answers both.

Also: spawn placement now uses real walkability (`isWalkableCell`,
`npcAt`, `warpAtCell`) and prefers the cell with the most open sides,
rather than the first unoccupied one. The lobby has counters and vanilla
attendants in it, and the old picker would happily have put the host
inside a wall.

## 0.1.2

Diagnostic rows now show **unless** the option is explicitly off, rather
than only when it reads on.

This matters more than it sounds. A mod option toggled on a Gold boot
never round-trips — the manager writes into Gold's own nested options
block while the loader reads the top-level one — so the read can come back
`nil`. The old test would then have silently suppressed every `[ERRS]`
row, on the one platform with no log to fall back to, in the build whose
entire purpose is reporting what happened. Re-checked against engine
0.1.79; the mismatch is still there.

Verified on engine v0.1.79 (not just 0.1.78): `validate --strict` and
`gen2check` both clean, and the three source facts the battle probe rests
on read unchanged.

## 0.1.1

**Reimagined as a Colosseum circuit, and moved to Pokémon Gold.**

The mod is now **Gold only** (`games: ["gold"]`). Gen 1 support is dropped
rather than maintained — nothing was ever released for Red, so no player
loses anything. `game_version` rises to `>=0.1.78` because Gen 2 and the
`games` field do not exist below it.

**The new premise.** Gold's `COLOSSEUM` map — the link-battle room at the
top of every Pokémon Center's stairs — goes unused in single player. The
circuit puts a tournament in it, and which town's stairs you climbed
decides which event you have walked into. Five venues: Violet, Goldenrod,
Ecruteak and Blackthorn, ending at the Indigo Plateau Conference. Each
gated on that region's badge, so the circuit paces itself against the main
game.

This means the mod ships **no maps, no tilesets and no warps** — the whole
lobby-and-arena layer the Route 22 design needed is gone.

**This build is a probe, not content.** Two of the three things the design
rests on are already proven: owned NPCs can talk on Gold, and the
`trainer.party` hook fires there. The third is not — a mod cannot start a
trainer battle through any documented route, and the one path found in
source (an NPC carrying a vanilla trainer as a carrier, with its team
substituted by the hook) has never been run. So this version places the
host and one probe opponent and reports what happens, and **no roster is
written until that answer is in**.

Also in this build:

- `LICENSE` (MIT) and `THIRD_PARTY_NOTICES.md` added.
- Diagnostics go to the `[ERRS]` screen behind a `Diagnostic rows` toggle,
  because the log does not exist on iOS.

## 0.1.0

Scaffold. Loaded, defined a load-banner option, announced its version.
Never released; superseded entirely by 0.1.1.
