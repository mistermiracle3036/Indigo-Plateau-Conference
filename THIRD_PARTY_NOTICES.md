# Third-party notices

## Private 1.1.50 custom-character test

Art from **Polished Crystal**, with per-asset attribution retained:

| Artist | Assets used |
|---|---|
| Kuroko Aizawa | Artist, Engineer and Cheryl: overworld and battle sprites |
| Kuroko Aizawa / JaceDeane | Professor Ivy: overworld and battle sprites |
| bloodless (BloodlessNS) | Buck, Maylene and Veteran (M): overworld and battle sprites |
| isamuakai01 | Cynthia and Steven: overworld and battle sprites |
| SCMidna / Freeline | Riley, Marley and Mira: overworld sprites |
| Rangi42 / Polished Crystal | Riley, Marley and Mira: battle sprites |
| Kage | Walker: overworld and battle sprites |
| Pyro | Tamer: overworld and battle sprites |
| FrenchOrange | Boarder: overworld sprite only |
| mauvesea | DJ Mary: overworld sprite only |
| EeVeeEe1999 | Captain, Exterminator and Slot Maniac: overworld sprites only, free to use with credit |

This uses art from Polished Crystal, not an attribution to vanilla pokecrystal.
The supplied color-test conversions are copied without additional editing.
Steven's supplied battle portrait includes the prepared light-blue hair treatment.
No unprovided battle art is included: five guests use an existing vanilla
Gentleman portrait as a temporary stand-in.

Private testing only. Public release remains blocked pending the portfolio's
in-game credits screen. Shared registry and canonical assets are unchanged.


## Scope of the licence

The MIT licence in [LICENSE](LICENSE) covers this mod’s own code. It does not
relicense Pokémon characters, ROM-derived material, or Nintendo trademarks.

## Included custom artwork

Fantina's battle and overworld art is commissioned from Blaklyte, supplied by
the developer on 2026-09-08. Only the runtime crops are bundled. This commission
is recorded separately from the artist's free-to-use library.

This private test build includes 118 converted character assets: 58 six-frame
overworld sheets and 60 56×56 battle portraits. Every one of them is referenced
by the current runtime, and together they cover 58 release-cleared or
previously documented custom-art characters. The assets directory also
contains one non-character arena tilesheet and nothing else. The dormant
Nemona conversion files are retained unchanged under `docs/sprite-sources/`,
which is excluded from the distributed archive. A.J.'s
custom battle and overworld set is by **TheBrawlUnit**, used with direct
express approval confirmed by the user. Larry, Ash, Yellow, Nate, Eusine,
Juliana, Leaf, Lear, Lillie, Looker, Chef, Ranger, Santa and Modern Red use battle-and-overworld
sets by **Bani**. Bani expressly approved use of their sprites and requested
credit in the project's staff credits and/or wherever the project is
distributed. Bani's `Lass` sheet is used as a visual substitute for Duplica,
`White Haired Girl` as a visual substitute for Giselle, and `Lass (RBY)` as a
visual substitute for Suzie. These sheets are not presented as bespoke artwork
of those three characters. Their complete presentation sheets are not
redistributed. Ball Guy uses a matching injector sheet by **CyUzi**, under
direct artist confirmation with credit required. N, Ingo and Nurse Joy are by
**Blaklyte**, and Pokémon Breeder is by **ArtsyAlraune**, under the confirmed
creator-folder visible-credit terms. Eleven individual source sheets plus one miscellaneous grid are
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
and Petrel use his public Team Rocket sheet. The Rocket Grunts use
Gold's own art from the player's cache -- no custom sprite is bundled
for them. Both source
pages state **“Free to use, with credits please!”** Roxie uses a commissioned
battle-and-overworld set by **tharkka**, commissioned through Fiverr and
confirmed by the user for total use. Piers uses a commissioned battle and
overworld set by **Yogurcomics**. The 31 original cleared-source images are retained in
`docs/sprite-sources/`, and the character-to-file mapping is recorded in
[CREDITS.md](CREDITS.md).

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
The Bani and CyUzi sheets provide native runtime regions at x 153–208, y 93–148
for the fronts and x 375–390, y 53–148 for the walking strips. Bani's Ranger
walking cell was normalized by a direct four-color luminance substitution;
CyUzi's Ball Guy walking cell was already normalized and was cropped without
remapping. The six Duplica, Giselle, and Suzie runtime files were copied
byte-for-byte from Johto Quest Pack's already-converted assets. The NolanKrawczak,
RoyalGuard, TeamHistoryWaffles and KiravelSoul sheets use the same native
injector regions.
Those regions are cropped exactly, without resampling. The earlier DracoZ
Nate sheet remains credited historical conversion evidence only and does not
supply a current runtime asset.

Chef is available only through the first-round developer selector and carries
one Raticate for a short visual test. It does not enter normal random draws.
Armored Mewtwo is likewise developer-selector-only, fields one Mewtwo, and is
an explicit user-approved exception to the usual trainer-only rule.

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
# Art cleanup in 1.1.59

The seven flagged Nintendo-derived PNGs and two executive portrait PNGs
have been removed. No edited replacements are distributed. Chef now uses
the player's ROM Gentleman walker; Jenny uses Officer. Petrel and Rocket
Executive use ROM Rocket walkers with explicit green/red palettes and the
ROM male Executive portrait. Duplica/Suzie portraits use ROM Lass; Oak uses
ROM Professor. These ROM graphics are referenced at runtime, not shipped.
Historical attribution below does not license or describe these removed
assets in the current build. Retained Chef/Jenny custom battle portraits
remain credited to Bani/TeamHistoryWaffles respectively. Generated registry
credits are to be refreshed by the owning agent AFTER intake registry rebuild.

# Approved Ciara assets and commissioned Miror B (private build 1.1.58)

Rina and Rui battle/overworld art: Ciara.
Chobin battle/overworld art: Ciara and gecko557 jointly.
The developer confirmed permission on 2026-09-10 and retained these three.
Rejected Ciara Lillie/Michael/Wes alternatives are not included.
Original existing versions retain their previous attribution.

Miror B battle and overworld art: commissioned from Blaklyte.
The native front and six-frame walker are cropped without scaling or
redrawing. Walker skin uses the approved vanilla skin shade; red remains
as supplied. The light hair and skin share one source color, so both use
that skin shade. No region-specific repaint has been applied. Front colors
are unchanged. White exterior background is transparent in the walker.

Native labelled walking and front cells were cropped without resizing or
redrawing. Walkers use the source main-color swatch, vanilla skin, black,
and transparency; battle fronts retain the sheet's supplied colors.
New guests are dev-only pending team design.
These permissions do not imply blanket approval for unrelated art.
