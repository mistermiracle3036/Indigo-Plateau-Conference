# Handback: Duplica, Giselle, Suzie, Ranger and Ball Guy custom art

## Result

Five existing Conference challengers now use private walking sprites and
battle fronts. Only their `sprite =` roster fields changed; their keys, tiers,
classes, carrier members, names, dialogue and parties are unchanged. Version
remains **1.1.37** in `main.lua`, `manifest.json`, and the top CHANGELOG
heading, as required for reviewer intake.

No level report is included because this order does not change any party,
level delta, tier, or battle rule. The normal pool remains **82 challengers**
with tier counts **13 / 25 / 28 / 16**, plus the two pre-existing dev-only
selectors (Armored Mewtwo and Chef).

## Art and palettes

| Character | Runtime source | Palette | Reason |
| --- | --- | --- | --- |
| Duplica | JQP's byte-identical exports of Bani's `Lass` visual substitute | `PAL_OW_PINK`, id `4` | Preserves the purple/pink performer impression of the true-color front and JQP's established choice. |
| Giselle | JQP's byte-identical exports of Bani's `White Haired Girl` visual substitute | `PAL_OW_BLUE`, id `1` | Matches the academy-blue front and JQP's established choice. |
| Suzie | JQP's byte-identical exports of Bani's `Lass (RBY)` visual substitute | `PAL_OW_BLUE`, id `1` | Matches the blue clothing in the front and JQP's established choice. |
| Ranger | Native crops from Bani's matching `Ranger` injector sheet | `PAL_OW_RED`, id `0` | Tracks the red cap and outfit in the true-color battle front. |
| Ball Guy | Native crops from CyUzi's matching `BallGuy` injector sheet | `PAL_OW_RED`, id `0` | Tracks Ball Guy's red-and-white head and shirt. |

The JQP copies were not reconverted. Ranger's 16x96 crop received a direct
four-to-four luminance substitution onto 0/85/170/255. Ball Guy's 16x96 crop
was already authored in those four grayscale shades, so its colors were
preserved; the palette-indexed source was serialized as mode `L` without
changing any displayed value. Both 56x56 fronts were cropped at native size
and saved in RGB true color without rescaling, interpolation or dithering.

The three substitute mappings are documented explicitly and are not presented
as bespoke art: Bani `Lass` -> Duplica, `White Haired Girl` -> Giselle, and
`Lass (RBY)` -> Suzie.

## Source reachability

Both requested local source sheets were reachable:

- `C:\Users\dwitt\Desktop\sprites for IPC\Bani\Ranger.png` (800x300)
- `C:\Users\dwitt\Desktop\sprites for IPC\CyUzi\BallGuy.png` (800x300)

The six converted JQP assets were reachable under
`C:\Users\dwitt\gen1recomp-work\Johto-Quest-Pack\assets\` and were copied
without modifying Johto Quest Pack. SHA-256 comparison confirms that all six
installed copies are byte-identical to their JQP sources.

## Edit sites in the delivered `main.lua`

Line numbers are the ranges found after the edit; text anchors were used:

1. `mod.exports.owns.sprites`, lines **122-175**: added five private IDs.
2. Existing `registerGuestSprite` call block, lines **212-272**: added the five
   registrations at lines 268-272. The helper itself at lines 205-216 is
   unchanged.
3. `BATTLE_FRONTS`, lines **277-333**: added five front paths at 328-332.
4. `TRUE_COLOR_FRONTS`, lines **338-387**: added five marker rows at 382-386.
5. Existing roster records, lines **458-577**: changed only the `sprite =`
   field for Duplica (459), Ball Guy (493), Ranger (518), Giselle (531), and
   Suzie (570).

Documentation rows were added to `SPRITE_PERMISSIONS.md`, `CREDITS.md`, and
`THIRD_PARTY_NOTICES.md`, including Bani's exact stated terms, CyUzi's direct
confirmation/credit requirement, and the visual-substitute qualification.

## Recomputed asset counts

The count was derived by opening every `assets/*.png` with Pillow, grouping by
dimensions, then independently parsing the PNG filename literals used by
`registerGuestSprite`, `BATTLE_FRONTS`, and the arena loader in `main.lua`:

- **111 PNGs** ship in `assets/` total.
- **110 are character-shaped converted assets:** 54 six-frame 16x96 walking
  sheets and 56 56x56 battle fronts.
- **108 are referenced by the runtime:** 53 walking sheets and 55 fronts,
  covering 55 active custom-art characters.
- The dormant, unregistered `nemona.png` / `nemona_front.png` pair remains
  unchanged.
- The final PNG is the non-character 128x56 `arena_tilesheet.png`.

These are the actual counts in the delivered checkout and replace the older
sample figures quoted in the work order.

## Work-order shape findings

- The separate probe-removal work order had already landed in this checkout
  before this task began. No `probe_*` asset or pairing was removed or edited
  as part of this custom-art change.
- The requested conversion helper exists at
  `docs/sprite-sources/convert_trainer.py`, not at repository-root `tools/`.
  It has no Ranger injector configuration; because these sources are already
  native runtime cells, the work order's exact crop/remap recipe was applied
  directly without changing the helper or preserving/redistributing either
  complete source sheet.
- The supplied checkout has no `.git` directory, so the stated `next` branch
  cannot be independently verified. Its content and version match the
  specified 1.1.37 intake.

## Validation

- All six JQP copies byte-identical: **PASS**.
- Ten new asset dimensions, front color count, and walking grayscale values:
  **PASS**.
- Focused main.lua diff (only five wiring sites and five roster sprite fields):
  **PASS**.
- Non-target file hash audit against the intake snapshot: **PASS**.
- LuaJIT byte compilation: **PASS**.
- `modkit lint`: **PASS**.
- `modkit validate --strict --base fixture`: **PASS**.
- `modkit gen2check --strict` for Gold, Silver and Crystal: **PASS**.
