# Third-party notices

## Scope of the licence

The MIT licence in [LICENSE](LICENSE) covers this mod’s own code. It does not
relicense Pokémon characters, ROM-derived material, or Nintendo trademarks.

## Included custom artwork

This build includes 54 converted runtime assets: 26 six-frame overworld sheets
and 28 56×56 battle portraits for 28 custom-art characters. Eleven individual
source sheets plus one miscellaneous grid are by **MOLLY**; the individual
sheets state **“Credit is nice, but not required.”** and the grid states
**“Credit would be nice, but is not required.”** Bea is by
**KIRB/YOSHI** with **“GIVE CREDIT IF USED.”** Mina is by **Santiago
Speedpaints a.k.a. Rojimenez** with **“Please, give credit if used.”** Nate is
by **DracoZ** with **“credit me pls”** and the sheet's special thanks to Molly
for the inspiration. Lorelei and Agatha use SirWhibbles' public GSC Kanto
sheet. Giovanni, the original GSC Rocket Executive, Archer, Ariana, Proton,
Petrel, and both Rocket Grunts use his public Team Rocket sheet. Both source
pages state **“Free to use, with credits please!”** Roxie's battle portrait is
credited to **Piacarrot**, and her user-confirmed editable overworld sheet is
credited to **UlithiumDragon**. Piers' portrait is credited to **Drawnamu**
and his overworld sheet to **CyberStryke7**. The 21 original source images are retained in
`docs/sprite-sources/`, and the character-to-file mapping is recorded in
[CREDITS.md](CREDITS.md).

The conversion only clips the selected source frames, removes the presentation
background, rearranges the six walking frames where supplied, and maps source
colors to Gold’s four palette indices. Roxie and Piers keep their native
hair/face rows while selected torso and leg rows are omitted to fit Gold; no
interpolation is used. Piers' portrait uses a tighter upper-body crop and a
nearest-neighbor reduction to preserve his face and microphone. Jessie
& James and the provisional Oak portrait are battle-only and use vanilla
Gold-cache overworld art.

No artwork from the earlier Crystal Clear Sprite Injector proof-of-concept is
included. The announcer and all remaining characters use art already present
in the player’s imported Pokémon Gold cache.

## Built on

- **[gen1recomp](https://github.com/bryanthaboi/gen1recomp)** — the engine
  this mod runs on.
- **[pret/pokecrystal](https://github.com/pret/pokecrystal)** and
  **[pret/pokered](https://github.com/pret/pokered)** — disassembly research
  used as reference; no code or ROM data copied.

## Trademarks

Pokémon and Pokémon character names are trademarks of Nintendo, Creatures Inc.
and GAME FREAK inc. This mod is an unofficial fan project, is not affiliated
with or endorsed by them, and claims no rights to their material.
