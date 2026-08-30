# Custom sprite conversion report

## Selected variants

The leftmost/default variant was selected from every source sheet. The extra
green and blue variants in `brendan.png` and `may.png`, the second variant in
`dawn.png`, and the Pokémon Stadium 2 character in `pokemon stadium.png` were
clipped out. The latter therefore appears in-game as **Stadium Trainer**, using
the Pokémon Stadium 1 design.

## Frame mapping

The mapping below applies to the eleven MOLLY sheets. Coordinates are
inclusive and refer to the supplied source PNG:

| Output | Source region |
| --- | --- |
| Battle front | Leftmost portrait, x 9–64 and y 3–58 |
| 1. Standing down | Walking-row tile 1, x 12–27 and y 62–77 |
| 2. Standing up | Walking-row tile 2, x 29–44 and y 62–77 |
| 3. Standing side | Walking-row tile 3, x 46–61 and y 62–77 |
| 4. Mid-step down | Walking-row tile 4, x 63–78 and y 62–77 |
| 5. Mid-step up | Walking-row tile 5, x 80–95 and y 62–77 |
| 6. Mid-step side | Walking-row tile 6, x 97–112 and y 62–77 |

The one-pixel gutters between walking frames are excluded. Cyan/white
presentation backgrounds map to grayscale value 255, the source light tone to
170, the source theme color to 85, and the outline to 0. No pixels were
redrawn or interpolated.

## Bea, Mina and legacy Nate frame mapping

The newer sheets use different layouts. All coordinates below are inclusive.

- **Bea:** the SGB battle portrait is x 68–123, y 8–63. Her eight walking
  frames are a three-down / three-up / two-side grid. Standing down, up and
  side use source frames 2, 5 and 7; mid-step down, up and side use frames 1,
  4 and 8. The unused down/up alternates are preserved in the source sheet.
- **Mina:** the battle portrait is x 8–63, y 48–103. Her eight walking frames
  are four directions across by two animation phases. Front, back and right
  are selected from each phase; the engine mirrors the right-side frame.
- **Legacy Nate:** the earlier DracoZ test portrait is x 1–56, y 1–56. Its
  first walking row at y 60–75 contains stand down/up/side followed by step
  down/up/side. Version 1.1.35 no longer uses either runtime crop; the source
  remains only as credited historical conversion evidence.

Michael's runtime files were regenerated from `michael.png` in 1.1.16 rather
than recoloring a previous output.

## MOLLY miscellaneous grid

`many misc characters.png` is an unlabeled 8×9 GBC portrait grid. Its 56×56
cells begin at x 3, y 15 with a 59-pixel pitch on both axes. This build uses:

- **Jessie & James (with Meowth):** zero-based cell 39, grid cell r5c8.
- **Professor Oak candidate:** zero-based cell 37, grid cell r5c6.

The 248-grey presentation background is normalized to white; the remaining
three source colors are preserved exactly. The Jessie & James cell is visually
unambiguous. The source grid does not label the Oak-like lab-coat cell, so Oak
remains `TODO/CONFIRM` on device before public release. Neither cell includes
walking art; those two challengers deliberately use vanilla Gold-cache
overworld sprites.

## SirWhibbles Kanto sheet

`sirwhibbles_kanto.png` supplies complete GSC-style sets for Lorelei and Agatha.
Their 56×56 battle portraits occupy y 121–176 at x 87–142 and x 203–258.
Each overworld set begins at the same x coordinate and contains three 16×16
directions across at y 178–193, with the three matching step frames at
y 195–210. The six frames are stacked into the runtime order: standing
down/up/side, then step down/up/side. The Giovanni crop used in 1.1.17 was
replaced by his black-suit Team Rocket layout in 1.1.18.

Transparent source pixels become palette value 255; skin becomes 170, the
character color becomes 85, and the outline becomes 0. Battle-front colors are
preserved exactly as RGB. No source pixels are redrawn or interpolated.

## SirWhibbles Team Rocket sheet

`sirwhibbles_team_rocket.png` supplies eight complete GSC-style sets:
Giovanni, the original unnamed GSC Rocket Executive, Archer, Ariana, Proton,
Petrel, and the male and female Rocket Grunts.

- Top-row fronts: y 0–55 at x 58–113 and x 116–171; walking frames begin at
  y 58.
- Middle-row fronts: y 97–152 at x 0–55, x 58–113, x 116–171 and x 174–229;
  walking frames begin at y 155.
- Bottom-row fronts: y 194–249 at x 58–113 and x 116–171; walking frames begin
  at y 252.

For each character, three standing directions occupy adjacent 16×16 cells at
the walking-row y coordinate and the three matching step directions begin 17
pixels lower. The sheet's final walking row touches its lower image edge, so
the converter pads the otherwise empty sixteenth row with transparency before
mapping it to white. The teal presentation background and off-white source
tone both normalize to white in the battle fronts; the character, skin and
outline colors are preserved. Walking colors map to Gold's four palette
indices without interpolation.

## Source dimensions

- `brendan.png`, `may.png`: 349×183 (three variants)
- `dawn.png`: 233×194 (two variants)
- `pokemon stadium.png`: 233×218 (two character designs)
- `bea.png`: 239×203
- `mina.png`: 288×248
- `nate.png`: 109×193
- `many misc characters.png`: 954×754
- `sirwhibbles_kanto.png`: 462×214
- `sirwhibbles_team_rocket.png`: 230×285
- `roxie_gsc_style_by_piacarrot_d59kzez.png`: 181×233
- `roxie_gen3_overworld_by_ulithiumdragon_dbj7tlr.png`: 128×192 (uniform 2× enlargement of a 64×96 native sheet)
- `roxie_tharkka_battle_sheet.png`: 1120×975 (uniform 5× enlargement of a 224×195 native presentation sheet)
- `roxie_tharkka_overworld_sheet.png`: 1835×495 (uniform 5× enlargement of a 367×99 native presentation sheet)
- `piers_yogurcomics_battle_front.png` and transparent variant: 56×56
- `piers_yogurcomics_overworld_red.png` / `blue.png` and transparent variants: 48×48
- `piers_yogurcomics_battle_back.png` / `no_hand.png` and transparent variants: 48×48
- The other MOLLY sheets: 128×194 (one variant)

The local TheBrawlUnit A.J. source is 190×132, an exact 2× enlargement of a
95×66 native sheet. It is not bundled because permission to redistribute the
complete source sheet was not separately stated.

The local Bani Larry, Ash, Yellow, Nate, Eusine, Juliana, Leaf, Lear, Lillie,
Looker and Chef sources share the same injector-sheet layout. Only their documented
runtime regions are converted; the complete sheets are not bundled.

## Roxie commissioned source adaptation

tharkka's two commissioned presentation sheets are exact 5× nearest-neighbour
enlargements. The converter verifies every 5×5 block before recovering the
224×195 battle sheet and 367×99 overworld sheet without interpolation. The
runtime front is the lower full-color 56×56 region at x 13–68, y 118–173.
Only its one-pixel black presentation frame and olive canvas are replaced by
battle white; all eight commissioned sprite colors remain intact.

The walking set uses the commissioned first-row standing down, up and left
poses and the matching second-row step poses. Its occupied rectangles are
15–16 pixels wide and 15–16 pixels tall. Each complete drawing is centered
horizontally and bottom-aligned on a native 16×16 canvas, preserving every
commissioned sprite pixel without clipping, resampling or redrawing. Black,
navy and skin pixels map to Gen 2 values 0, 85 and 170; the presentation
background maps to 255. Gold mirrors the side frame in-engine. The older
Piacarrot/UlithiumDragon conversion is retained as historical source evidence
only and is not used by the current runtime.

As of 1.1.33, device feedback confirmed the full-color battle front and asked
for lighter overworld hair. In each frame, only value-85 pixels inside the
commissioned head region are reassigned to value 170. The body pixels below
that per-frame boundary retain value 85, so the clothing remains pink while
the hair resolves through the light Gold palette entry. This changes 320
color assignments without moving, adding, deleting or resizing any source
pixel.

## Piers commissioned source adaptation

Yogurcomics' commissioned overworld art is already a native 48×48 grid of
nine 16×16 frames. Its rows are down, up and side; its columns are first
walk phase, standing and second walk phase. Runtime order is r1c2, r2c2,
r3c2, r1c1, r2c1 and r3c1: stand-down, stand-up, stand-side, step-down,
step-up and step-side. No frame is resized or interpolated. The blue
transparent variant supplies the selected pixels; transparent/edge-removal
alpha below 128 becomes background 255, and opaque outline, blue theme and
skin map to 0, 85 and 170. As of 1.1.23, Gold's `PAL_OW_BROWN` supplies
the display colors so the theme shade is darker and more neutral while the
outline remains black.

As of 1.1.24, the runtime sheet uses a black-heavy custom mapping. Former
theme pixels become value 0. Original outline pixels remain 0 when they touch
the background or define light face/skin shapes; only enclosed lines
surrounded by the former theme shade become value 85 for Brown interior
detail. Values 170 and 255 are unchanged. This changes color assignments
only—no commissioned pixel is moved, added, resized or interpolated.

The commissioned battle front is already exactly 56×56. It is not cropped
or resized. Its transparent variant is reduced deterministically to black,
magenta, gray and white so the existing true-color Conference front path can
render it without borrowing Janine's palette. The supplied battle-back,
no-hand, red-overworld and alternate background variants are retained as
source evidence but are not runtime assets in this opponent-only tournament.

## A.J. directly approved source adaptation

TheBrawlUnit's supplied 190×132 sheet is an exact 2× nearest-neighbour
enlargement; every 2×2 source block is identical. It is reduced without
interpolation to 95×66. The battle portrait is the native region x 0–55,
y 0–55. The six walking cells are 16×16 at x 59 and 76, with row starts
y 3, 20 and 37. Reading the standing column down (down/up/side) and then the
step column down produces Gold's runtime order exactly. White, black, green
and skin pixels map to 255, 0, 85 and 170 for the private overworld sheet.
The portrait remains true-color RGB using the source's black, dark green,
skin and normalized white. The bottom A.J. presentation label is not included.

## Bani injector-sheet source adaptation

All eleven selected 800×300 sheets share the same Crystal Clear injector layout.
The battle front is cropped exactly at x 153–208, y 93–148, producing 56×56.
The complete six-frame walking strip is cropped exactly at x 375–390,
y 53–148, producing 16×96 in Gold's native frame order. Neither region is
resized, interpolated or redrawn. Palette samples, the 48×48 back portrait,
40×56 trainer-card portrait, surf strips, labels and white presentation
canvas remain outside the crops. Each true-color front retains Bani's four
source colors. Walking white, black, theme and skin pixels map to Gold indices
255, 0, 85 and 170. Larry, Yellow, Lear and Looker request PAL_OW_BROWN; Ash,
Nate and Chef request PAL_OW_BLUE; Eusine, Juliana and Lillie request PAL_OW_PINK;
and Leaf requests PAL_OW_GREEN.

Version 1.1.34 intentionally imports only one sheet per character: Juliana's
Violet design and Leaf's standard design. Alternate forms, Pokémon-species
sheets, native Johto gym-leader art, Santa Claus, and generic or unidentified
Chef/Lass/White Haired Girl sheets remain outside the runtime.

Version 1.1.35 replaces the earlier Nate runtime pair with Bani's Nate sheet.
His 56×56 front retains Bani's four source colors, and his six walking frames
use the closest blue Gold overworld palette. The complete source is not
bundled.

Version 1.1.36 adds Chef through the same exact crop path. Chef's front keeps
Bani's four colors, while the walking strip maps to the closest blue Gold
palette. The source sheet is not bundled and Chef remains dev-only.

## 1.1.37 KiravelSoul injector sheets

Volkner and Armored Mewtwo use the same exact 800×300 injector coordinates:
x 153–208, y 93–148 for the native 56×56 battle front and x 375–390,
y 53–148 for the native six-frame 16×96 walking strip. No runtime region is
resized, interpolated or redrawn. Volkner's RGB portrait retains black,
blue, blond and white; his walking values map to Gold's brown overworld
palette. Armored Mewtwo's RGB portrait retains black, dark violet, light
violet and white; its walking values map to Gold's pink overworld palette.
The complete presentation sheets are not bundled.

## 1.1.35 creator-folder injector sheets

Barry by NolanKrawczak; Bill, Colress, Hugh, Maxie and Wally by RoyalGuard;
and Gloria, Officer Jenny and Ruin Maniac by TeamHistoryWaffles use the same
800×300 injector layout and the same exact crop boxes as Bani's sheets. Their
battle fronts are preserved as four-color RGB images. Their walking strips
map source black, theme, light/skin and white to values 0, 85, 170 and 255.
Barry and Bill request PAL_OW_BROWN; Colress, Hugh and Officer Jenny request
PAL_OW_BLUE; Maxie requests PAL_OW_RED; and Wally, Gloria and Ruin Maniac
request PAL_OW_GREEN. No source crop is resized, interpolated or redrawn, and
no complete creator sheet is included in the mod.

## 1.1.21 SirWhibbles side-frame and palette corrections

Giovanni, Lorelei, Proton and Petrel's source side silhouettes occupy only
7–12 pixels and were left-aligned inside 16×16 cells. Runtime side and
side-step frames are now horizontally centered without changing any source
pixel. Their shifts are Giovanni +4/+3, Lorelei +4/+4, Proton +3/+3 and Petrel
+2/+2 pixels. This prevents Gold's mirrored facing direction from moving the
silhouette from one cell edge to the other.

Giovanni and both Rocket Grunts now request `PAL_OW_BROWN` instead of
`PAL_OW_ROCK`. Their grayscale pixels are unchanged; the palette change gives
shade 170 Gold's standard skin entry instead of the rock palette's ochre entry.

## Verification requirement

Every runtime overworld file must be 16×96, mode `L`, with exactly values
`[0, 85, 170, 255]` and no alpha. Battle fronts are 56×56 with no alpha.
Forty-four fronts are pre-colored RGB images, including the eleven Bani portraits and
the nine 1.1.35 creator-folder portraits, while the other seven retain the
four-value `L` format. The assets directory therefore contains 49 overworld
files and 51 fronts (100 character PNGs total); two of those files are the
dormant, unregistered Nemona conversion pair. The 98 files referenced by
`main.lua` comprise 48 overworld sheets and 50 fronts. One additional PNG is
the non-character arena tilesheet.
The build audit re-runs
these checks before packaging.
