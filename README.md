# Indigo Plateau Conference

A mod for [gen1recomp](https://github.com/bryanthaboi/gen1recomp).
**Pokémon Gold only.**

Upstairs in every Pokémon Center there's a battle room nobody uses. The
Colosseum circuit fills it. Climb the stairs in Violet and you've walked
into the Violet Qualifier; do it in Blackthorn and it's the Masters. Four
rounds, one challenger each, a different field every time — ending at the
Indigo Plateau Conference itself.

> **Not released yet.** This repository is private and under active
> development. There is no public release to install, and the version here
> changes often.

## Status

**v0.1.1 — probe build.** The venue, the host and the badge gate are in.
The tournament is not: whether a mod can start a trainer battle on Gold is
an open question this build exists to answer. See
[CHANGELOG.md](CHANGELOG.md).

## The circuit

| Venue | Climb the stairs in | Gated on |
| --- | --- | --- |
| Violet Qualifier | Violet City | Zephyr Badge |
| Goldenrod Open | Goldenrod City | Plain Badge |
| Ecruteak Invitational | Ecruteak City | Fog Badge |
| Blackthorn Masters | Blackthorn City | Rising Badge |
| Indigo Plateau Conference | Indigo Plateau | Rising Badge |

## Compatibility

Ships no maps, tilesets or warps, and modifies no vanilla NPC, script or
trainer. Everything it places in the Colosseum is a runtime object, which
is never serialized and never enters the map-data merge — so no other
mod's `maps` patch can clobber it, and it clobbers nobody.

## Credits

By **Mister Miracle**
([@mistermiracle3036](https://github.com/mistermiracle3036)).

- Built on the [gen1recomp](https://github.com/bryanthaboi/gen1recomp)
  engine, with reference to the [pret](https://github.com/pret)
  disassembly research.
- The owned-NPC pattern this mod uses on Gold was proven first in **Court
  of Noctowl**.
- Character art, as and when it arrives, is credited in
  [CREDITS.md](CREDITS.md).

Pokémon and Pokémon character names are trademarks of Nintendo, Creatures
Inc. and GAME FREAK inc. This is an unofficial fan project, not affiliated
with or endorsed by any of them. See
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
