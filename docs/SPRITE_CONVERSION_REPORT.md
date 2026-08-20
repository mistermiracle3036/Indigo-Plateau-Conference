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

## Bea, Mina and Nate frame mapping

The newer sheets use different layouts. All coordinates below are inclusive.

- **Bea:** the SGB battle portrait is x 68–123, y 8–63. Her eight walking
  frames are a three-down / three-up / two-side grid. Standing down, up and
  side use source frames 2, 5 and 7; mid-step down, up and side use frames 1,
  4 and 8. The unused down/up alternates are preserved in the source sheet.
- **Mina:** the battle portrait is x 8–63, y 48–103. Her eight walking frames
  are four directions across by two animation phases. Front, back and right
  are selected from each phase; the engine mirrors the right-side frame.
- **Nate:** the battle portrait is x 1–56, y 1–56. The first walking row at
  y 60–75 already contains stand down/up/side followed by step down/up/side.
  The extra lower rows remain only in the preserved source sheet.

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
- `piers_overworld_by_cyberstryke7.png`: 256×384 (uniform 4× enlargement of a 64×96 native sheet)
- `gym_leaders_portraits_by_drawnamu.png`: 947×121
- The other MOLLY sheets: 128×194 (one variant)

## Roxie Gen III-to-Gen II overworld adaptation

The UlithiumDragon source is a pixel-perfect 2× enlargement of a four-column,
four-row Gen III grid. It is first reduced without interpolation to native
16×24 cells. Rows are down, left, right and up; columns alternate step and
standing frames. The runtime sheet uses column 2 for standing and column 1 for
the matching step, selecting down, up and left-side rows in Gold's order. Gold
mirrors the side frame in-engine.

Each selected 16×24 frame preserves its first eight occupied native hair/face
rows pixel-for-pixel, then selects eight endpoint-preserving torso/leg rows.
No image resize or interpolation is applied. Transparent pixels become 255;
dark outline becomes 0; colored and middle tones become 85; and light
hair/skin becomes 170. This row selection needs device confirmation. The
Piacarrot front is the exact 56×56 region x 20–75, y 11–66;
its presentation whites are normalized and its purple, skin and outline map
to a four-color RGB front.

## Piers source adaptation

`piers_overworld_by_cyberstryke7.png` is a perfectly uniform 4× enlargement
of a native 64×96 Gen III walking sheet. It is restored without interpolation
to sixteen 16×24 cells. The same down/up/left selection used for Roxie is
stacked in Gold's stand-down, stand-up, stand-side, step-down, step-up,
step-side order. Like Roxie, each frame preserves eight native hair/face rows
and selects eight endpoint-preserving body rows rather than resizing the full
figure. The source's black/dark outline maps to 0, middle gray and magenta
to 85, light hair/skin to 170, and transparency to 255.

Piers is zero-based figure 9 in `gym_leaders_portraits_by_drawnamu.png`. The
runtime front uses the tighter 64×64 upper-body region x 509–572 and y 18–81,
reduced to 56×56 with nearest-neighbor sampling and mapped to black, magenta,
light and white. No adjacent leader pixels are included. The resulting face,
hair, arm and microphone readability require device confirmation.

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
Twenty-one fronts are pre-colored RGB images—the previous twelve plus the
Rocket Executive, Archer, Ariana, Proton, Petrel, both Rocket Grunts, Roxie and
Piers—while the other seven retain the four-value `L` format. The build
therefore contains 26 overworld files and 28 fronts (54 runtime PNGs total).
The build audit re-runs
these checks before packaging.

## 1.1.22 — Roxie and Piers rebuilt after device rejection

The 1.1.21 conversions were rejected on device. Root causes, and what
replaced them (scripts: `sprite-sources/convert_roxie_piers_ow.py` and
`convert_roxie_piers_fronts.py`, both rerunnable):

- **Overworlds** (both): any 24-to-16 squeeze — uniform or "first 8 rows
  plus selected body rows" — blends or cuts the face. Now: crop each
  frame to content, protect a hand-identified face band, and greedily
  drop the rows most similar to their upper neighbour until 16 remain.
  Silhouette-defining transition rows survive because they differ from
  their neighbours. The stand frame's row map is reused verbatim on its
  step frame so the walk cycle cannot jitter. Side frames use source row
  2, which natively faces left as the engine expects.
- **Roxie overworld quantization**: saturation-aware. Colored clothing
  (navy dress, bow) goes to 85; low-saturation white-hair shading
  flattens into 170 so the head reads as flat light with black features
  — which is how Gen 2 itself draws white hair.
- **Roxie front**: Piacarrot's sheet contains a pure 2x of a NATIVE
  56x56 GSC sprite (verified: every 2x2 block uniform). Descaled and
  snapped 49 stray pixels to the four target colors. No resampling.
- **Piers front**: 1.1.21 used hot pink as the only dark hue, so his
  grey jacket and mane quantized to pink-or-white speckle. The dark hue
  is now grey-purple (96,80,112), absorbing jacket mids, hair shading
  and the pink accents. The FULL Drawnamu figure (mic stand included)
  is fitted at 89/56 scale by area-weighted majority vote over
  already-quantized colors with black-outline priority — replacing the
  rejected upper-body crop. His white face is canon (palest character
  in Galar), so it maps to white, not skin.

## 1.1.23 — second device round

Three findings from the 1.1.22 device test, folded into the same two
scripts (rerunnable):

- **Side frames faced right on device**; both sheets now mirror the
  side stand/step frames (defaults `ROX_MIRROR=1`, `PIE_MIRROR=1`).
- **The pink OW palette renders 85 as saturated red.** Judging the
  sheets in neutral grey missed this — the 1.1.23 preview pass renders
  through a simulated palette instead. 85 is now an accent tone only:
  Roxie's navy tights/dark stripes moved to 0 and her dress lights to
  170; Piers' mane fill returned to 0 (canon black mane, white spikes
  at 170) with jacket shadow darks at 0.
- **Piers front** crops at the boot tops (rows 0-74) so the figure
  scales 3/4 instead of 5/8, plus a lone-pixel despeckle pass.

## 1.1.24 — faces framed by hand; portrait framing settled

- **Face edits** (`sprite-sources/edit_roxie_piers_faces.py`, runs after
  the OW converter): black face frame, hairline, one-row 2px eyes and
  mouth, hand-placed per frame — the convention vanilla's white-haired
  Granny uses. Conversion alone cannot produce this: the sources' faces
  are too small for their features to survive any mapping.
- **Piers portrait**: native upper-body crop, final. Three candidates
  compared; his ~9px face survives no rescale in either direction. The
  1.1.21 crop was rejected wearing the pink-speckle palette — framing
  was never the problem.
