# NPC pairing private test inventory

Version 1.1.27 exposes these generic concepts only through **DEV: First-round
guest**. They are tagged `devOnly`, excluded from all four random tier pools,
and share a neutral Pidgey/Rattata/Spearow team. That team is a test fixture,
not a roster proposal.

| Selector label | Battle crop | Overworld source recorded in handoff | Runtime palette | Conversion note |
| --- | ---: | --- | --- | --- |
| PROBE: Waitress | 35×56 | TCG `Renna_C` matched | Red | Padded |
| PROBE: Pajamas | 49×55 | TCG `GR_Pappy_B` chosen | Blue | Detached palette swatch removed; padded |
| PROBE: Hoodie | 44×55 | TCG `Team_GR5` chosen | Blue | Padded |
| PROBE: Vest + Glasses | 53×53 | TCG `Ishihara_B` matched | Green | Detached palette swatch removed; padded |
| PROBE: Gymnast | 59×48 | TCG `Jessica_C` matched | Pink | Detached palette swatch removed; art fits without clipping |
| PROBE: Muscle Man | 46×55 | Robopon NPC 8 matched | Blue | Padded |
| PROBE: Delivery Boy | 28×54 | Monster Race NPC 4 matched | Green | Padded |
| PROBE: Green-Hair Girl | 57×53 | TCG `Grace_C` chosen | Green | Detached palette swatch removed; art fits without clipping |
| PROBE: Old Man | 41×54 | TCG `NPC_Pappy_A` chosen | Red | Padded |
| PROBE: Blue-Hair Kid | 41×54 | Robopon NPC 14 matched | Blue | Padded |

The overworld inputs are native 64×80 RPGXP-style sheets: four directions by
four walk frames, with 16×20 cells. Inspection confirmed that every opaque
pixel is in the top 16 rows of each cell. Runtime frames therefore use stand
column 2 and step column 1 in Gold order (down, up, side), cropping only four
transparent rows and never resizing the art.

Battle portraits are credited to JustinNuggets (Substitube). Overworld art is
credited to FrenchOrange and Catwithnojob. The source pack is linked at
https://eeveeexpo.com/resources/1687/ and is not redistributed with the mod.

## Decisions required before promotion

1. Decide which concepts, if any, belong in Indigo Plateau Conference.
2. For every promoted concept, choose a permanent character name, dialogue,
   tier and team. The current names and party are visual-test placeholders.
3. Decide whether Robopon and Monster Race-derived art is acceptable project
   sources. They are third-party commercial-game assets, unlike Pokémon TCG
   art or community-original sprites.

Until those roster decisions are complete, all ten remain `devOnly` and cannot
enter ordinary random tournament draws.
