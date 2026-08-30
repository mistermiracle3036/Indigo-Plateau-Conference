# Third-party notices

## Scope of the licence

The MIT licence in [LICENSE](LICENSE) covers this mod’s own code. It does not
relicense Pokémon characters, ROM-derived material, or Nintendo trademarks.

## Included custom artwork

This private test build includes 118 converted runtime assets: 58 six-frame
overworld sheets and 60 56×56 battle portraits. Ninety-eight assets cover the
50 release-cleared or previously documented custom-art characters. A.J.'s
custom battle and overworld set is by **TheBrawlUnit**, used with direct
express approval confirmed by the user. Larry, Ash, Yellow, Nate, Eusine,
Juliana, Leaf, Lear, Lillie, Looker and Chef use battle-and-overworld sets by **Bani**,
cleared by the user for use with Bani credit. Their complete presentation
sheets are not redistributed. Eleven individual source sheets plus one miscellaneous grid are
by **MOLLY**; the individual
sheets state **“Credit is nice, but not required.”** and the grid states
**“Credit would be nice, but is not required.”** Bea is by
**KIRB/YOSHI** with **“GIVE CREDIT IF USED.”** Mina is by **Santiago
Speedpaints a.k.a. Rojimenez** with **“Please, give credit if used.”** Barry is
by **NolanKrawczak**. Bill, Colress, Hugh, Maxie and Wally are by
**RoyalGuard**. Gloria, Officer Jenny and Ruin Maniac are by
**TeamHistoryWaffles**. The user confirmed that visible creator-name credit
satisfies the terms for those folders. Volkner and the developer-only Armored
Mewtwo exception are by **KiravelSoul** under the same confirmed creator-folder
terms. Lorelei and Agatha use SirWhibbles' public GSC Kanto
sheet. Giovanni, the original GSC Rocket Executive, Archer, Ariana, Proton,
Petrel, and both Rocket Grunts use his public Team Rocket sheet. Both source
pages state **“Free to use, with credits please!”** Roxie uses a commissioned
battle-and-overworld set by **tharkka**, commissioned through Fiverr and
confirmed by the user for total use. Piers uses a commissioned battle and
overworld set by **Yogurcomics**. The 31 original cleared-source images are retained in
`docs/sprite-sources/`, and the character-to-file mapping is recorded in
[CREDITS.md](CREDITS.md).

The remaining 20 runtime assets are ten additional developer-selector visual probes.
Their battle portraits are by **JustinNuggets** (also credited as
**Substitube**) and are free to use with credit. Their overworld sprites are
from the Gen 2 Additional NPCs Pack by **FrenchOrange** and **Catwithnojob**,
free to use and edit with credit: seven are derived from Pokémon Trading Card
Game sprites, two from Robopon and one from Monster Race. The pack's resource
page asks projects to link there instead of redistributing the pack, so the
original archive and source sheets are not included in this mod. Source links
and terms are recorded in [SPRITE_PERMISSIONS.md](SPRITE_PERMISSIONS.md).

The cleared-art conversion only clips the selected source frames, removes the presentation
background, rearranges the six walking frames where supplied, and maps source
colors to Gold’s four palette indices. Roxie's commissioned sheets are exact
5× pixel enlargements: the full-color front is recovered and cleaned without
resizing, while the 15–16-pixel walking drawings are centered and bottom-
aligned on 16×16 canvases without clipping or interpolation. Piers' commissioned
assets are already native Gold dimensions: his portrait is not resized, and
his 16×16 overworld frames are only rearranged and palette-mapped. Jessie
& James and the provisional Oak portrait are battle-only and use vanilla
Gold-cache overworld art.
A.J.'s exact 2× source enlargement is reduced with nearest-neighbour sampling,
then its already-native 56×56 front and six 16×16 walking cells are extracted without interpolation.
The Bani sheets provide native runtime regions at x 153–208, y 93–148 for
the fronts and x 375–390, y 53–148 for the walking strips. The NolanKrawczak,
RoyalGuard, TeamHistoryWaffles and KiravelSoul sheets use the same native
injector regions.
Those regions are cropped exactly, without resampling. The earlier DracoZ
Nate sheet remains credited historical conversion evidence only and does not
supply a current runtime asset.

Chef is available only through the first-round developer selector and carries
one Raticate for a short visual test. It does not enter normal random draws.
Armored Mewtwo is likewise developer-selector-only, fields one Mewtwo, and is
an explicit user-approved exception to the usual trainer-only rule.

For the private probes, the RPGXP-style 16×20 cells hold all opaque pixels in
their top 16 rows; only the four transparent rows are omitted. Six Gold frames
are rearranged without resizing. Portraits are centered and bottom-aligned;
detached 7×16 palette-reference swatches are removed from Pajamas, Vest +
Glasses, Gymnast and Green-Hair Girl. The cleaned art fits without clipping or
resizing. No probe is included in ordinary random tournament draws.

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
