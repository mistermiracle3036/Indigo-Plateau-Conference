# Changelog

All notable changes to Indigo Plateau Conference are documented here.
Format follows [keep a changelog](https://keepachangelog.com/); the top
heading always equals the version in `manifest.json`.

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
