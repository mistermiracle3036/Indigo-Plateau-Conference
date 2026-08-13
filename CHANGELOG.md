# Changelog

All notable changes to Indigo Plateau Conference are documented here.
Format follows [keep a changelog](https://keepachangelog.com/); the top
heading always equals the version in `manifest.json`.

## 0.8.0

The Announcer gets his own face: original 16×16 pixel art (black hair,
the shades), designed by Mister Miracle. One forward-facing frame for
now — he never turns — with the walking frames to follow. First art
asset in the repo; credited in CREDITS.md.

## 0.7.1

The Announcer's build-up line now escalates by round — buzzing crowd,
packed stands, the shades, "THE FINAL, folks!" — instead of repeating
one line four times. Giselle now cites ECRUTEAK UNIVERSITY, and a
19-column line of hers that had overflowed the text box since 0.2.0 is
fixed.

## 0.7.0

**The ANNOUNCER, embodied.** A suited MC now stands in the arena and
starts the rounds — talk to him to call the battle. Challengers spawn
unarmed and give a new per-character flavour line until the round is
called, so every character now has three overworld dialogue moments.

## 0.6.2

Talking to the just-fought challenger now gets a line from THEM
(new per-character after-win/after-loss lines); the announcer only
takes over once you move.

## 0.6.1

Brock's losing line: "Sunk like a stone. Train harder."

## 0.6.0

No more instant rebattles: after any result the challenger stands down,
and an announcer voice escorts you out on your next step — "let us set
up for the next round" on a win, "you're out of the running" on a loss.
Challengers each got their own win/lose lines. The room re-stages only
after you leave.

## 0.5.1

Fixed the loss path never triggering the escort (the engine skips the
map reload on a CANLOSE loss — a combination vanilla never produces),
and a beaten challenger re-fought before leaving no longer fields his
carrier's vanilla team.

## 0.5.0

**Losing eliminates you** — back to round 1, the answer to the design
doc's oldest open question. Losses no longer black out: the battles use
the engine's own CANLOSE mechanism (the Cherrygrove rival's), your
party is healed where you stand, and the tournament escorts you out
through the game's own leaving-the-Colosseum cutscene.

## 0.4.5

**The stairs-void bug, solved for real.** Entering the Colosseum arms a
vanilla escort scene on the Pokémon Center 2F that script-walks the
player from the door; leaving any way other than the door left it armed
in the save, and the next stairs trip marched you into the void. Losses
no longer black out (see 0.5.0), and any other door-skipping exit
disarms the scene. The earlier flag-repair theory (0.4.3) was wrong and
its code is deleted.

## 0.4.4

The two link-room placeholder figures (wearing the player's own sprite)
become spectators: reskinned and moved to the room's edges through
runtime-only mechanisms — no persistent save writes.

## 0.4.3

Withdrew the placeholder hiding entirely after the mods-off test proved
the stairs bug was ours; restored what earlier versions wrote.

## 0.4.2

Hide the link pair by sprite rather than name (their names read back
empty), in reverse index order.

## 0.4.1

All dialogue reflowed to Gold's two-line text box; the attendant now
steps aside on every lobby visit rather than only the first.

## 0.4.0

**Real team comps** (A.J., Giselle, Brock, Wes — Wes finally fields
ESPEON and UMBREON), and **levels anchored to the town's gym leader**
rather than the player's party, so each venue has a fixed, knowable
difficulty a step above the badge that let you in.

## 0.3.3

Diagnostics mirrored to the desktop log; the door-blocking attendant is
found by radius rather than an exact cell.

## 0.3.2

The attendant walks down, then left, then faces the room — she was
walled in on both sides at the doorway.

## 0.3.1

The 2F attendant steps aside so the player can walk through the real
Colosseum door. (Her dialogue is the cart's and cannot be changed; Gold
mods also have no choice-box, so no link/single-player menu is
possible.)

## 0.3.0

**Walk through the real door.** The Pokémon Center 2F carries an actual
warp to the COLOSSEUM at (9,0); the mod no longer warps anyone, which
also removes the cause of the stairs bug as then understood. BROCK
joins the card as round 3 — a real Gold trainer class, so he battles
under his own name and portrait.

## 0.2.3

Fire-weak test teams for bracket testing (marked TEST, never intended
to ship); warp tables printed to diagnostics.

## 0.2.2

Round progression moved to the battle-end event; the two link-room
placeholder figures hidden (later found harmful and reverted).

## 0.2.1

Challenger levels scale to the player's strongest Pokémon (0.2.0's
fixed curve made Violet's round 1 unbeatable); a census of the arena's
vanilla objects.

## 0.2.0

**A full four-round tournament, inside the actual Colosseum.**

The host now stands in the Pokémon Center's upstairs lobby and sends you
*through* — into `COLOSSEUM`, the link-battle room single player never
gets to see. The attendant who normally guards that door is not touched:
`warpTo` only checks that the map exists and never consults the script
that gates it. Hiding or moving her would break vanilla and collide with
any other mod on that map; going around her costs nothing.

The card, escalating across four rounds: **A.J.**, **Giselle**,
**Ritchie**, **Wes** — each with their own pre-battle line and their own
team. Beat one and the next is waiting; clear all four and the host hands
you the title and resets the card, so it can be run again.

Wes fields **Espeon and Umbreon**. That is the point of him being here on
Gold rather than Gen 1: his Kanto team had to be Jolteon/Flareon/Vaporeon
because the other two did not exist yet.

Arrival uses one of the arena's **own** warp tiles rather than a cell
picked by hand — guaranteed walkable, and where the game itself puts a
player. An attendant inside leads back out, and the lobby cell you left
from is remembered before you go, so a save made in the arena is not a
soft-lock.

Known and deliberate, for the next build:

- Challengers wear a **vanilla trainer's name** ("SCHOOLBOY JACK"), not
  their own. The Gen 2 trainers registry takes members carrying their own
  name and party, which would fix this properly — but appending to a
  class needs `__append` to survive the Gen 2 write path and that is
  unverified. This build rides only mechanisms already proven on device.
- The win is **inferred**, not read: the cart owns the battle outcome and
  does not hand it back. A loss whites you out to a Pokémon Center, so
  still standing in the arena afterwards counts as a win.

## 0.1.7

**The probe is complete. The design works.** A mod can stage a trainer
battle on Gold, with its own opponent and its own dialogue. Everything
still missing is content, not feasibility.

This build fixes the last symptom: the opponent arrived at 0 HP with a
blank bar because the hook was handing back roster **rows** rather than
finished battle mons. Gen 1's battle built the party after the hook; Gen
2 does not — `Battle.lua:258` says nothing downstream rewrites what the
hook returned. The party is now built through the engine's own
`Trainers.party`, so the opponent is constructed exactly like a vanilla
trainer's: level-up movesets, and the cart's fixed trainer DVs of
9/8/8/8/8 that make a trainer's Rattata always the same Rattata.

If the party ever fails to build, the hook now returns nil and keeps the
vanilla team. A real battle beats a broken one, and a substitution that
cannot be built must never become an opponent with no stats.

## 0.1.6

**The trainer struct is numeric on both fields.** 0.1.5 showed the line
and then nothing, because the mod was handing it names.

`Trainers.lookup` does `classIndex(data)[class]` and then
`entry.trainers[member]` — a numeric class constant and an array
position. A name misses both, so the lookup returned nil, `startbattle`
yielded with no trainer, and the script simply ran out. Both are now
resolved from the live trainer data at spawn time rather than hardcoded:
the class constant is a ROM index, and writing the number in here is
exactly the kind of guessed constant that fails quietly later.

Fixed a second bug behind it that had not surfaced yet. What reaches the
`trainer.party` hook is not what the struct carried — the battle passes
`classId or class` and `memberId or index or 1`, and the record the
lookup builds sets `classId` to the class **name** while carrying no
member index at all. So the hook sees a name and a member of 1. It now
accepts either spelling instead of betting on one.

Confirmed working in 0.1.5 and unchanged here: **mod-registered text
reaches the ROM's own text pool.** The opponent speaks a line this mod
wrote, through the cart's script. That was the riskier of the two
unknowns and it is now settled.

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
