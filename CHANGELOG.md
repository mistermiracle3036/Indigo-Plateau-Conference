# Changelog

All notable changes to Indigo Plateau Conference are documented here.
Format follows [keep a changelog](https://keepachangelog.com/); the top
heading always equals the version in `manifest.json`.


## 1.1.38

**Five more challengers get faces of their own.** Duplica, Giselle, Suzie,
Ranger and Ball Guy stop borrowing generic trainer-class sprites. Duplica was
one of three women sharing the vanilla LASS sprite; Ball Guy was a SUPER NERD;
Ranger was a YOUNGSTER. All five now have their own overworld art and battle
portrait, and all five are selectable from the first-round developer option so
each one can be checked directly.

Duplica, Giselle and Suzie use Bani sheets as documented visual substitutes
rather than bespoke art of those characters — the runtime files are copied
byte-for-byte from Johto Quest Pack's existing conversions, so the two mods
show the same faces. Ranger is Bani's matching Ranger sheet, and Ball Guy is
CyUzi's BallGuy sheet, used with the artist's direct confirmation and credit.

**The ten generic art probes are gone.** The waitress, pajamas, hoodie, vest,
gymnast, muscle man, delivery boy, green-hair girl, old man and blue-hair kid
were placeholders for evaluating sprite rendering, never real challengers.
They have served their purpose and their assets, credits and selector rows are
all removed. Armored Mewtwo and Chef remain as the two developer-only entries.

No roster keys, tiers, classes, carrier members, names, dialogue or parties
changed in this build. The normal pool remains 82 challengers.


## 1.1.37

**KiravelSoul's Volkner joins the normal tournament roster.** His tier-three
team is Jolteon, Raichu and Electabuzz; Electabuzz is the Gen 2 stand-in for
Electivire. His native 56×56 portrait keeps its source colors and his six
walking frames use Gold's closest brown overworld palette.

**Armored Mewtwo is an explicit developer-selector exception.** It fields one
Mewtwo for a short visual test and is marked `devOnly`, so it never enters a
random tournament draw. Its native portrait keeps KiravelSoul's violet armor
colors and its walking frames use Gold's closest pink palette.

Both characters use private `SPRITE_IPC_*` records, additive trainer members,
and the existing positively gated Conference-only portrait and party paths.
The complete 800×300 source sheets are not redistributed. No vanilla trainer
party, portrait, member or overworld sprite is replaced.


## 1.1.36

**Bani's Chef joins the first-round developer selector.** Chef is deliberately
`devOnly`: the sprite never enters the normal 81-challenger tournament draw
until a permanent identity and full team are chosen. The test party contains
one Raticate as a short Ratatouille-style joke and quick device art check.

The exact standard injector regions become one private 56×56 true-color
battle front and one six-frame 16×96 walking strip using the closest blue Gold
palette. The complete Bani source sheet is not redistributed. Chef uses a
private `SPRITE_IPC_CHEF` record, an additive private trainer member and the
existing positively gated Conference-only portrait and party paths. No
vanilla trainer party, portrait, member or overworld sprite is replaced.


## 1.1.35

**Nine credited, non-native trainers join the normal roster:** Barry, Bill,
Colress, Hugh, Maxie, Wally, Gloria, Officer Jenny and Ruin Maniac. Barry's
sheet is by **NolanKrawczak**; Bill, Colress, Hugh, Maxie and Wally are by
**RoyalGuard**; and Gloria, Officer Jenny and Ruin Maniac are by
**TeamHistoryWaffles**. Bill is intentionally included because Gen 2 has no
native Bill battle-trainer portrait. Each new challenger is also selectable
through **DEV: First-round guest**.

Nate's existing roster entry now uses **Bani** art instead of the earlier
DracoZ runtime pair. His tier, dialogue and Fearow/Typhlosion/Dragonite party
are unchanged; only his private battle and overworld assets and closest Gold
overworld palette changed. The supplied May and Lorelei alternatives remain
excluded to avoid duplicate identities, and native Gen 2 trainers and
Pokémon-only sheets remain outside the runtime.

The normal roster now contains 81 challengers. The recovered Bill, Barry,
Colress, Hugh and Maxie teams are retained from the earlier concept test;
Wally, Gloria, Officer Jenny and Ruin Maniac use explicit Gen 2
interpretations documented beside their roster entries. Every new sheet is
reduced to the established exact 56×56 battle-front and 16×96 six-frame
walking crops. Complete creator sheets are not redistributed.

All additions use private `SPRITE_IPC_*` ids, additive `__append` trainer
members and the positively identified Conference-only portrait and party
paths. No vanilla trainer party, portrait, member or overworld sprite is
replaced.


## 1.1.34

**Six non-duplicate Bani trainers join the normal roster:** Eusine, Juliana,
Leaf, Lear, Lillie and Looker. Juliana uses the Violet sheet, Leaf uses her
standard sheet, and Lillie uses the ponytail sheet. Alternate versions are
deliberately collapsed into a single character entry. The supplied Pokémon
species sheets, Santa Claus, existing roster characters, and unidentified or
generic Chef/Lass/White Haired Girl sheets are not imported.

The three supplied Johto gym-leader sheets are also left out. Bugsy, Falkner
and Whitney already have native Gen 2 trainer art; Falkner and Whitney are
already used as venue difficulty anchors. They can be added to the challenger
pool later with their native assets rather than creating custom-art variants.

Eusine keeps his complete Crystal team of Drowzee, Haunter and Electrode.
Juliana and Lillie retain their earlier concept-test Gen 2 teams. Leaf, Lear
and Looker use documented Gen 2 interpretations that can be revised after
device testing. The normal roster now contains 72 challengers, and all six
are directly selectable through **DEV: First-round guest**.

Each new 800×300 injector sheet is cropped at the established native Bani
regions: a 56×56 true-color battle front and a six-frame 16×96 walking strip.
Only the runtime crops are included. All six use private `SPRITE_IPC_*` ids,
private appended trainer-member rows and the existing positively identified
Conference battle portrait/party path. No vanilla trainer member, party,
portrait or overworld sprite is replaced.


## 1.1.33

**Roxie's commissioned battle front is unchanged, while her overworld hair
now uses the light Gold palette value.** The 1.1.32 phone test showed the
battle art correctly but rendered the source hair shade red/pink through
`PAL_OW_PINK`. This build remaps only the commissioned hair pixels in each of
the six walking frames from the theme value to the light value. Her black
outline, face, body, pink clothing accents, frame alignment and animation
order are unchanged.

Only `assets/roxie.png` differs at runtime. The battle portrait, every other
sprite, Roxie's roster and party, the Sandalwood integration, and the
Conference-only trainer-party safety gate are byte-identical to 1.1.32.


## 1.1.32

**Roxie now uses her commissioned sprite set by tharkka.** This revision-test
build selects the lower, full-color 56×56 battle front and six walking poses
from the supplied presentation sheets. Both sheets are exact 5× pixel
enlargements, so the converter first recovers their native pixels. It removes
only the battle presentation border/background, then centers the 15-pixel-wide
walking poses and bottom-aligns the 15-pixel-tall step poses on native 16×16
Gen 2 canvases. No commissioned sprite pixel is resized, interpolated,
redrawn or clipped.

The walking art keeps the existing private `PAL_OW_PINK` Conference mapping,
and the battle front stays full-color through the already-scoped true-color
path. **DEV: Cleared art guest → Roxie** still forces her into round one for
quick phone review. Her roster entry, party, dialogue, Sandalwood victory
unlock and positive Conference-only trainer-party gate are unchanged.


## 1.1.31

**Defeating Roxie can now unlock her Sandalwood Villa show.** The Conference
records a durable, public `ROXIE` victory marker and exports it through API 1.
With Sandalwood Town 0.2.0 installed, Roxie and two bandmates offer a one-night
Villa performance after the player buys the Music System.

The integration is optional and data-only. Indigo Conference registers its
own guest profile through Sandalwood's public Villa API and never reads or
writes Sandalwood save data. Sandalwood is absent by default from the normal
tournament flow, and a late install reconstructs the unlock from the saved
Roxie victory marker.


## 1.1.30

**The Conference now supports every Gen 2 edition: Gold, Silver and
Crystal.** The manifest targets all three games and requires gen1recomp
0.2.22 or newer, the first release line that supports both accepted Crystal
revisions.

The runtime continues to use the shared Gen 2 world, battle, party-menu and
trainer builders. A cross-edition audit confirms that all 34 borrowed trainer
classes, every fallback member, all 125 referenced species, all five venue
maps, the shared Pokemon Center 2F and Colosseum, and every vanilla overworld
sprite exist in Gold, Silver and Crystal. Crystal gives Goldenrod Pokemon
Center a different numeric map index, but the mod already uses the stable
symbolic map id and therefore needs no edition-specific hardcoding.

Trainer safety is unchanged. Private identity rows are still additive
`__append` patches, and party substitution still requires the positive
`world.trainer_engaged` signal from the mod-owned arena challenger. Ordinary
trainers in every edition keep their original parties and portraits.

Gold retains its established device-test history. Gold and Crystal were also
loaded against their local extracted datasets; Silver uses the same GS engine
and passed the complete Silver ROM-manifest reference audit. Silver and
Crystal still need the normal on-device tournament playthrough before this
test build is promoted as a release.


## 1.1.29

**Larry, Ash and Yellow now use fully credited Bani sprite sets.** Each
800×300 injector sheet supplies an exact 56×56 battle front and six-frame
16×96 walking strip. The runtime crops exclude all palette guides, back
portraits, trainer-card portraits, surf strips, labels and presentation
canvas. Battle fronts retain Bani's four source colors; overworld strips use
the closest Gold palette without modifying shared sprite records.

Yellow's existing tier-three entry is upgraded in place, so her
Raticate/Dodrio/Pikachu party, dialogue, tier and order are unchanged. Ash
returns with his previously established Pikachu/Snorlax/Charizard team.
Larry joins tier three with Gen 2 stand-ins for his Paldea Normal team:
Snorlax for Komala, Dunsparce for Dudunsparce and Pidgeot for Staraptor.
The normal roster now contains 66 challengers.

All three use private SPRITE_IPC ids and battle-state-only portraits. Their
trainer identities are appended under private member ids, and the existing
positive Conference battle gate remains unchanged; no vanilla trainer party,
shared portrait or shared overworld sprite is overwritten. The user confirmed
all three sheets are by **Bani** and cleared for use with Bani credit.

## 1.1.28

**A.J. now uses TheBrawlUnit's directly approved custom sprite set.** The
supplied sheet is an exact 2× enlargement, so its 56×56 battle portrait and
six native 16×16 walking frames are extracted without interpolation or
redrawing. The presentation label and canvas are excluded from the runtime
assets.

This upgrades A.J.'s existing tier-one roster entry rather than adding a
duplicate. His Bug Catcher carrier, Sandslash/Butterfree/Primeape party,
dialogue, tier and starting order are unchanged. A.J. is now selectable
directly through the DEV: First-round guest option.

The new walking sprite is registered under the private SPRITE_IPC_AJ id, and
the portrait is installed only after a battle is positively identified as
Conference-owned. No shared trainer class, vanilla portrait, or vanilla
trainer party is overwritten. Credit is recorded to **TheBrawlUnit** with the
user's confirmation of direct express approval.

## 1.1.27

**Detached palette-reference squares are removed from every affected probe
portrait.** Component inspection found the same opaque 7×16 two-swatch block
beside Pajamas, Vest + Glasses, Gymnast and Green-Hair Girl; those four blocks
are removed before the portraits are padded. Waitress, Hoodie, Muscle Man,
Delivery Boy, Old Man and Blue-Hair Kid contain no such block and are unchanged.

After removing the presentation swatches, the actual Gymnast and Green-Hair
Girl art fits inside Gold's 56×56 trainer slot. Neither character is clipped or
resized now, and all ten runtime portraits contain exactly four colors.

The source credits are complete: battle portraits are by **JustinNuggets**
(credit may also be given as **Substitube**) under “free to use with credit”;
the Gen 2 Additional NPCs Pack is by **FrenchOrange** and **Catwithnojob**, free
to use and edit with credit. The original pack is no longer embedded in the mod
because its resource page asks projects to link there instead of redistributing
the pack. The ten entries remain `devOnly` visual tests and are still excluded
from the 64-character random tournament roster. Existing trainer parties,
Piers art and the positive Conference battle gate are unchanged.
## 1.1.26

**Ten generic NPC pairings are available as private first-round art probes.**
Waitress, Pajamas, Hoodie, Vest + Glasses, Gymnast, Muscle Man, Delivery Boy,
Green-Hair Girl, Old Man and Blue-Hair Kid can be forced through the renamed
`DEV: First-round guest` option. They use private overworld sprite records,
battle-state-only portraits and the same neutral three-Pokémon test team.

All ten entries are marked `devOnly`: they are addressable by the developer
selector but are never added to any ordinary tier pool. The shipped Conference
draw remains exactly 64 challengers. Their sources are preserved and clearly
marked as blocked from public release because the original community artist
and pack compiler attribution was lost during file transfer; the TCG,
Monster Race and Robopon rip origins are also recorded.

The 64×80 RPGXP-style walking sheets contain complete 16×16 figures at the top
of each 16×20 cell, so conversion removes only four transparent rows. Gold's
six-frame order is assembled without resizing. Battle portraits are centered
and bottom-aligned on 56×56; the 59-pixel Gymnast and 57-pixel Green-Hair Girl
sources are center-clipped to fit, never resampled. Existing parties, trainer
members, Piers art and the positive Conference battle gate are unchanged.

## 1.1.25

**The three-Pokémon preliminary rule is now explicit and visually honest.**
Before round one, the host says that only party slots 1–3 can fight in
rounds 1–3, tells the player to reorder before entering, and confirms that
all six return for the final.

Gold's voluntary and forced battle-switch menus sometimes omitted the active
battle party and fell back to the full saved party. The Conference now uses
the proven Spell of the Unown menu fix: while an owned preliminary battle is
active, those menus receive the exact same three-member array as the battle.
Benched Pokémon no longer appear as visible but unusable choices.

The saved party is never shortened, reordered, or replaced. The new menu
hook is gated by the existing positive `ourBattle` signal and clears after
every result, so ordinary trainer battles remain untouched. Piers' approved
art and every trainer party are unchanged.

## 1.1.24

**Piers receives a black-heavy custom overworld mapping.** His commissioned
theme pixels now render black. Exterior silhouette and face/skin outlines
remain black, while only enclosed clothing and hair detail lines retain
Gold's dark Brown shade so the 16×16 art remains readable. The light pixels,
frame layout and battle portrait are unchanged.

No roster, team, trainer carrier, party hook, or vanilla trainer record
changed.

## 1.1.23

**Piers' overworld sprite now uses Gold's brown object palette.** Brown is
the darkest normal trainer palette available and replaces the bright
red/pink clothing shade with a much darker neutral accent while preserving
the separate black outline. The commissioned battle portrait and both Piers
runtime image files are byte-for-byte unchanged.

No roster, team, trainer carrier, party hook, or vanilla trainer record
changed.

## 1.1.22

**Piers now uses the commissioned Yogurcomics sprite set.** The new 56×56
battle front is installed at its native size, and the supplied 3×3
overworld grid is rearranged into Gold's six-frame 16×96 walking format
without resizing or interpolation. Piers retains the pink Gold overworld
palette. All commissioned battle-front, battle-back and overworld variants
are preserved with a credit and permission record for future use.

Only Piers' private art files, credit records and the build version changed.
His roster entry, team, trainer carrier, the protected Conference-only party
hook and every vanilla trainer record remain unchanged.

## 1.1.21

**The problem custom sprites receive a device-feedback correction pass.**
Giovanni, Lorelei, Proton and Petrel had narrow side-facing art packed against
the left edge of each 16×16 frame. Both side frames are now centered within
their cells, preventing the mirrored turn from jumping to the opposite edge
or appearing clipped. No standing-front or standing-back pixels changed.

Giovanni and the male and female Rocket Grunts now use Gold's brown object
palette instead of its rock palette. The brown palette retains Gold's standard
peach skin tone while giving their dark clothing a subdued brown accent; the
rock palette's ochre ramp was producing the reported greenish/mustard skin.

Roxie and Piers no longer undergo an all-over 24-to-16-pixel vertical squeeze.
Their converted walking frames preserve the first eight occupied native rows
for hair and face, then select eight endpoint-preserving body rows. Piers'
battle front now uses a tighter upper-body crop focused on his face, hair,
raised arm and microphone rather than shrinking the complete standing figure.
These three replacements were produced through the requested delegated sprite
pass and remain `TODO/CONFIRM` on device. The protected Conference-only party
hook and every trainer record are unchanged.

## 1.1.20

**Piers joins the cleared-art phone-test roster.** His overworld sheet is by
CyberStryke7. Its exact native 16×24 Gen III frames are recovered from the
supplied 4× enlargement, reduced vertically to Gold's 16×16 footprint without
smoothing, and mapped to the closest pink Gold palette. His portrait is the
Piers figure from Drawnamu's complete gym-leader lineup, proportionally fitted
into the 56×56 battle slot with nearest-neighbor sampling. Both originals are
preserved with separate credit records.

Piers is selectable directly under **DEV: Cleared art guest** and uses a
provisional Umbreon, Sneasel and Houndoom team. He rides Janine's class for an
appropriate leader title but receives an additive private member, private
sprite ID and battle-state-only portrait. The roster now has 64 challengers
and 28 selectable custom-art guests. The protected party hook is unchanged
and still declines every non-Conference trainer battle.

## 1.1.19

**Roxie joins the cleared-art phone-test roster.** Her GSC battle portrait is
by Piacarrot. Her editable Gen III overworld sheet is by UlithiumDragon; the
supplied 2× image was restored to its native 16×24 frames, reduced vertically
to Gold's 16×16 footprint without smoothing, and mapped to the closest pink
Gold palette. Both originals are preserved with separate credit records.

Roxie is selectable directly under **DEV: Cleared art guest** and uses a
provisional Koffing, Muk and Crobat team. She rides Janine's trainer class so
the fallback title is appropriate, but receives an additive private member,
private sprite ID and battle-state-only portrait. The roster now has 63
challengers and 27 selectable custom-art guests. The protected party hook is
unchanged and still declines every non-Conference trainer battle.

## 1.1.18

**The complete public Team Rocket sheet joins the phone-test roster.** The
original unnamed GSC Rocket Executive, Archer, Ariana, Proton, Petrel, and the
male and female Rocket Grunts are seven new challengers with private battle
fronts, private six-frame walking sheets, dialogue, provisional three-Pokémon
teams, and direct entries in **DEV: Cleared art guest**. Giovanni's existing
entry now uses the eighth layout from that sheet: his black Team Rocket suit.
The roster now has 62 challengers and 26 selectable custom-art guests.

The new teams are: Rocket Executive—Golbat, Raticate, Houndoom; Archer—
Weezing, Crobat, Houndoom; Ariana—Arbok, Vileplume, Murkrow; Proton—Raticate,
Golbat, Weezing; Petrel—Koffing, Muk, Weezing; male Grunt—Rattata, Zubat,
Koffing; female Grunt—Ekans, Gloom, Murkrow. These are provisional test teams.

All eight layouts come from SirWhibbles' “[Public] Team Rocket's Ready to
Rumble!” sheet, whose page states “Free to use, with credits please!” Their
walking art uses private sprite IDs and their RGB fronts are applied only to
positively identified Conference battle states. Guest names remain additive
`__append` records, and the protected party hook still declines every ordinary
trainer battle.

## 1.1.17

**Jessie & James, Giovanni, Professor Oak, Lorelei and Agatha join the
cleared-art phone-test roster.** All five have private battle fronts,
provisional three-Pokémon teams and entries in **DEV: Cleared art guest**.
Jessie & James appear together with Meowth and use Arbok, Weezing and Meowth;
Giovanni uses Persian, Nidoking and Rhydon; Oak uses Tauros, Exeggutor and
Venusaur; Lorelei uses Dewgong, Cloyster and Lapras; Agatha uses Arbok, Crobat
and Gengar. The roster now has 55 challengers and 19 selectable art guests.

Giovanni, Lorelei and Agatha use complete GSC-style battle and six-frame
overworld sets from SirWhibbles' public Kanto sheet, whose page states “Free
to use, with credits please!” Jessie & James use MOLLY's unambiguous combined
portrait and a vanilla Rocket overworld. Oak uses the Oak-like lab-coat cell
from the same unlabeled MOLLY grid and vanilla Oak overworld; that one portrait
is explicitly marked `TODO/CONFIRM` for device inspection before release.

The five fronts are true-color only on positively identified Conference battle
states. The three new walking sheets use private sprite IDs. Tier-four guest
names are appended to existing carrier classes with `__append`; no vanilla
member, shared portrait or party is replaced. The protected `trainer.party`
hook still declines every battle that is not the mod-owned arena challenger.

## 1.1.16

**Bea, Mina and Nate join the cleared-art phone-test roster.** Each has a
private six-frame walking sheet, private battle front, dialogue, provisional
three-Pokémon party, and an entry in **DEV: Cleared art guest**. Bea uses
Hitmontop, Primeape and Machamp; Mina uses Wigglytuff, Mr. Mime and Clefable;
Nate uses Fearow, Typhlosion and Dragonite. The roster now has 50 challengers
and 14 selectable cleared-art guests.

Bea uses a pink Gold palette, Mina uses pink, and Nate uses red. Michael was
rebuilt from MOLLY's preserved source sheet and now uses red in both the
overworld and battle. All four battle fronts are marked true-color only on
their mod-owned battle states, preventing borrowed trainer classes from
changing their chosen colors.

The original Bea, Mina and Nate sheets are preserved as permission evidence.
Credits record KIRB/YOSHI's “GIVE CREDIT IF USED.”, Santiago Speedpaints a.k.a.
Rojimenez's “Please, give credit if used.”, and DracoZ's “credit me pls” plus
the sheet's special thanks to Molly for the inspiration. No shared trainer
party or class portrait table is modified.

## 1.1.15

**The cleared-art palette pass now matches the requested character colors.**
Hilbert's overworld sprite is red, Lyra is blue in the overworld and battle,
May's battle portrait is red, and Michael's overworld sprite is brown. Wes's
battle portrait now uses the same blue Gold palette as his overworld sprite.

Lyra, May and Wes have pre-colored battle fronts marked as true-color on only
their mod-owned battle states. This prevents their borrowed trainer classes
from recoloring the custom portraits, without changing any shared class art or
party data. The Pokémon Stadium guest is now displayed as **Stadium Trainer**;
its internal key and asset filenames remain stable.

## 1.1.14

**The private proof-of-concept art roster has been replaced with the cleared
MOLLY batch.** The build now contains custom walking sheets and battle fronts
only for Brendan, Dawn, Green, Hilbert, Hilda, Lyra, May, Michael, the Pokémon
Stadium 1 player, Rosa and Wes. All 98 Crystal Clear test assets were removed;
the original core-roster characters that used them are back on vanilla
Gold-cache art, and uncleared roster additions were removed.

Every supplied sheet states “Made by MOLLY” and “Credit is nice, but not
required.” Original sheets are preserved under `docs/sprite-sources/`, with
the terms recorded in `SPRITE_PERMISSIONS.md`. Source-page URLs were not
supplied and remain a public-release documentation item.

The wider sheets are clipped to their leftmost/default variant. Pokémon
Stadium therefore uses the Stadium 1 player rather than the Stadium 2 design.
All 22 runtime images pass the Gold format checks: 16×96 or 56×56, four shade
values only, and no alpha.

The **DEV: Cleared art guest** selector forces any of the 11 characters into
round one. Lyra, Rosa and Stadium Player have provisional test teams; all
party substitution remains gated to the mod-owned arena challenger, and no
vanilla trainer party or class portrait table is modified.

## 1.1.13

**Fifteen more custom-art challengers join the phone-test roster.** Hilbert,
Hilda, Hugh, Hisuian Ingo, James, Jessie, Juliana, Kirby, Luffy, MF DOOM,
Maxie, Goku, Lillie, Lucas and anime May now have private six-frame walking
sprites, private battle fronts, dialogue and three-Pokemon parties. All are
available through **DEV: Round 1 guest**.

The roster now contains 80 challengers. This batch only extends the same
mod-owned sprite records, battle-front map and roster table proven in 1.1.12;
it does not patch shared trainer classes or broaden the `trainer.party` hook.
Party replacement still requires positive engagement with the mod-owned arena
challenger and is cleared when that Conference battle ends.

## 1.1.12

**Twenty-six custom-art challengers join the test roster.** Aipom, Anakin,
Archie, Aroma Girl, Ash, Bardock, Barry, Bill, Black Mage, Black, Bomberman,
Brendan, Crazy Dave, Caveman, Colress, Cynthia, Dawn, Demi-fiend, Dexter,
Earthworm Jim, Edd, Eddy, Emmet, Goh, Gardenia and Giovanni now have private
six-frame walking sprites, private battle fronts, dialogue and three-Pokemon
parties. All are available from **DEV: Round 1 guest** for direct phone tests.

Ash is now a tournament trainer rather than the announcer. The arena announcer
has returned to Gold's vanilla Link Receptionist sprite used before the custom
art tests. No shared sprite, trainer-picture table, trainer record or party is
replaced: battle fronts remain gated to the active Conference battle and the
party hook still requires the mod-owned arena challenger signal.

Ranger now uses TeamHistoryWaffles' replacement layouts and Gold's Red
overworld palette. Guzma uses the grey Rock palette; Duplica and Mr. Two retain
Gold's closest Pink palette. Contributor mappings are recorded in CREDITS.md.

## 1.1.11

**Custom walking sprites now permanently use the closest Gold overworld
palette.** Ball Guy and the announcer remain Red; Wes is Blue; Yellow, Guzma
and Molly are Brown; Duplica, Ranger and Mr. Two are Pink. These are
per-sprite assignments that follow Gold's time-of-day colors without
modifying any shared palette or vanilla sprite record.

The **DEV: Exact OW colors** A/B toggle and its three walking-only variant
assets have been removed following the device test. The round-one guest
selector remains available. Battle portraits, roster tiers, borrowed carriers
and parties are unchanged.

## 1.1.10

**Ball Guy, Wes and Yellow now have an on-device walking-palette A/B test.**
Select one with **DEV: Round 1 guest**, then leave **DEV: Exact OW colors**
off to see Gold's time-of-day-aware palettes (Red, Blue and Brown
respectively), or turn it on to see the exact two-color pair from that
character's Sprite Injector sheet.

The exact variants are private true-color sprite records with real alpha;
they do not modify Gold's shared PAL_OW tables. Changing the toggle causes the
standing Conference challenger to be rebuilt on the next arena refresh. The
battle portraits, roster tiers, borrowed carriers and parties are unchanged.

## 1.1.9

**Yellow, Guzma and Molly now use their supplied six-frame overworld layouts
and matching 56x56 battle-front sprites.** The layouts are credited to
ShockSlayer, GP and Unknown respectively and are extracted directly from the
lossless PNG sheets in Sprite Input.

All three are available through **DEV: Round 1 guest** for immediate testing.
The selector remains a runtime-only presentation override. Yellow stays on
Picnicker/Hope, Guzma on Biker/Zeke, and Molly on Lass/Ellen; their Tier 3
placements and existing parties are unchanged. Their art uses new
Conference-owned sprite ids, and no shared vanilla sprite, trainer record or
party is modified.

## 1.1.8

**Wes's installed sprites are now extracted directly from ciara's original
indexed PNG in Sprite Input.** The original PNG and the 1.1.7 JPEG recovery
produce identical four-shade pixels in both the 56x56 battle front and 16x96
walking strip, but the lossless PNG is now the source of record.

This is an asset-provenance test build only. Wes remains available through
**DEV: Round 1 guest**, and his Tier 3 placement, CooltrainerM/Nick carrier,
Espeon/Umbreon/Persian party, and all shared vanilla records are unchanged.

## 1.1.7

**Wes now uses ciara's supplied six-frame overworld layout and matching
56x56 battle-front sprite.** The phone-converted JPEG retained the original
one-pixel grid and four palette roles; the installable PNGs were recovered by
snapping each pixel to the sheet's own displayed palette, with no resizing or
generative changes.

Wes is available in **DEV: Round 1 guest** for immediate testing. This remains
a runtime-only presentation override: his Tier 3 roster placement, borrowed
CooltrainerM/Nick carrier and Espeon/Umbreon/Persian party are unchanged. No
shared Cooltrainer sprite, trainer record or party is modified.

## 1.1.6

**DEV: Round 1 guest now puts every custom-art guest directly into round
one.** Cycle the choice through Ball Guy, Duplica, Ranger and Mr. Two to test
each overworld layout and battle portrait without playing through the earlier
tiers. Random restores the normal bracket.

The override is runtime-only rather than written into the saved draw. This is
important for Mr. Two: he remains a Tier 2 roster member, and persisting him in
the Tier 1 draw slot would invalidate and repeatedly redraw the bracket. His
normal roster placement, borrowed Psychic/Herman carrier and party are not
changed by the test selector.

## 1.1.5

**Duplica, Ranger and Mr. Two now use their supplied six-frame overworld
layouts and matching 56x56 battle-front sprites.** The layouts are credited to
Limesar, Dragowski and Soulcast respectively. Mr. Two's unusual body shape is
still technically valid: all six walking frames and the complete portrait fit
their required boxes without including the source sheet's gray background.

Use **DEV: Art guest** to select Ball Guy, Duplica, Ranger or Mr. Two. Each
selection stays in its intended tier, so Mr. Two appears in round two and the
others appear in round one. The older **DEV: Ball Guy R1** toggle remains
available and unchanged.

These are presentation-only replacements on Conference-owned NPCs and battle
screens. Duplica remains Lass/Alice, Ranger remains Camper/Dean and Mr. Two
remains Psychic/Herman; their parties and every shared vanilla trainer record
are untouched. A missing custom portrait falls back to that guest's normal
class portrait.

## 1.1.4

**Ball Guy now uses CyUzi's supplied 56x56 front sprite during his battle
intro.** Enable **DEV: Ball Guy R1** to put him in the first round, then enter
the fight to test both his overworld sheet and battle portrait together.

This is a presentation-only swap, positively gated to the Conference's owned
Ball Guy NPC. He remains on the proven Juggler/Fritz carrier with the same
Voltorb, Jigglypuff and Electrode party. The shared Juggler portrait table and
all vanilla trainer and party records are untouched; if the custom image cannot
load, Gold falls back to the normal Juggler portrait.

## 1.1.3

**Ball Guy now uses his custom six-frame overworld art.** The asset is the
source atlas's 16x96 Walking Sprite column by CyUzi and uses Gold's red
overworld palette.

Enable **DEV: Ball Guy R1** in the mod options to force him into round one,
including when the current bracket was drawn before the toggle was enabled.

The test hook changes only the tier-one draw when enabled. Ball Guy's
Juggler/Fritz battle carrier and Voltorb, Jigglypuff and Electrode party are
unchanged, as are all other challenger and player parties.

## 1.1.2

**Corrected announcer-sprite test build.** This uses the source atlas's
16x96 Walking Sprite column. The neighboring 16x96 Surfing Sprite column was
mistakenly packaged in 1.1.1.

No gameplay code changed. Challengers, trainer parties, player party limits,
tournament progression and ordinary battles remain identical to 1.1.0.

## 1.1.1

**Private announcer-sprite test build.** The announcer in the Colosseum now
uses DBZGUY x3's six-frame Ash Ketchum overworld layout, including front,
back and side-facing poses. Gold applies the red overworld palette shown in
the source sheet.

This test changes only the announcer's sprite registration and sprite id. It
does not change challengers, trainer parties, player party limits, tournament
progression or ordinary battles.

## 1.1.0

**You now bring three Pokemon to the preliminaries, and all six to the
final.** The challengers have fought to that rule since 1.0.0 -- three a
side in rounds one to three, six in round four -- but you did not, so a
full team walked through the early rounds six against three. The circuit
was never meant to be that lopsided.

**Your first three party slots are the ones that fight.** There is no
menu to pick them; reorder your party the usual way and the top three go
in. The announcer says so on the way in.

Nothing is taken off you and nothing is moved. The Pokemon left out are
still in your party, in the same order, and the three who fight take the
damage and keep the experience exactly as before.

Ordinary battles everywhere else in Johto are untouched -- gyms, the
Elite Four, route trainers all still use your whole team.

## 1.0.2

**Updating from 1.0.1?** Documentation only -- nothing in the game
changed, so there is no need to rush. The README now lists the badge each
event asks for, which it previously left out entirely; if you walked to
Goldenrod and were turned away without knowing why, that is why.

Everything below is the release itself, unchanged from 1.0.1.

---

**The first public release.** Pokemon Gold only.

Upstairs in a Pokemon Center there is a battle room single player never
gets to use -- the link colosseum. This mod fills it with a tournament.

Talk to the Gentleman in the upstairs lobby and the attendant steps
aside. Through the far door an announcer runs a four-round card: one
challenger per round, drawn from a pool of 39, escalating as you go. Win
all four and the title is yours. Lose any round and you are eliminated
back to round one against a completely new field -- no blackout, no lost
money, your team patched up where it stands.

**Five towns, five different events.** Which one you get depends on whose
stairs you climbed:

| Event | Where | To enter |
| --- | --- | --- |
| Violet Qualifier | Violet City | the Zephyr Badge |
| Goldenrod Open | Goldenrod City | 3 Johto badges |
| Ecruteak Invitational | Ecruteak City | 4 Johto badges |
| Blackthorn Masters | Blackthorn City | 8 Johto badges |
| Indigo Plateau Conference | Indigo Plateau | beat the Elite Four |

**Difficulty is fixed per venue, never scaled to you.** Each event is
anchored to that town's own gym leader, read out of the game's own
trainer data -- so the Violet Qualifier is an early-game tournament
whenever you enter it, and clearing the Blackthorn Masters means
something specific.

**The challengers are people, not filler.** Rookies and anime one-offs
early, rivals and specialists next, then the Orre cast and manga
trainers, and finally a round of Kanto gym leaders, the Elite Four, and
two names you will recognise on sight. They fight under their own names,
with their own teams, and they speak for themselves going in and coming
out. The last round is six-on-six.

**It is repeatable, and it travels with your save.** Take a title and the
announcer draws a fresh card; a new draw never repeats the previous run's
pick in a tier. A run in progress survives quitting, and loading an older
save rewinds the tournament with it.

Winning is also recorded on every Pokemon in your party, ready for a
Conference ribbon in the Ribbons mod -- which is optional, can be
installed later, and will count tournaments you have already won.

Nothing here changes a vanilla map, NPC, script or trainer, and the mod
ships no art of its own, so it sits quietly beside whatever else you run.

*(1.0.0 and 1.0.1 were the same release in preparation; neither was
published.)*

## 1.0.1

Added the README screenshots. Never published -- the README also gained
the per-venue badge requirements before release, which is 1.0.2.

## 1.0.0

Prepared as the first public release but never published.

## 0.9.9

**Each event now asks for badges before it lets you in.** The circuit has
always set its levels a step above the local gym leader, on the
assumption you had beaten that gym -- but nothing checked, so a
two-badge trainer could walk into the Goldenrod Open and meet a Lv28
final round.

| Event | To enter |
| --- | --- |
| Violet Qualifier | the Zephyr Badge |
| Goldenrod Open | 3 Johto badges |
| Ecruteak Invitational | 4 Johto badges |
| Blackthorn Masters | 8 Johto badges |
| Indigo Plateau Conference | beat the Elite Four |

The host tells you what you are missing rather than just refusing, and
being turned away costs nothing: a run you have going at another venue is
left exactly as it was.

## 0.9.8

**Removes a hidden fallback that could quietly scale the tournament to
your own team.** If the mod ever failed to read a town's gym leader, it
used to fall back to your strongest Pokemon's level -- and flatten the
bracket while it was at it, so round four came out no harder than round
one. It never said so anywhere you could see.

The circuit now refuses the round instead, and the announcer tells you.
An event that declines is one you can report; one that silently gets easy
is not.

## 0.9.7

**The announcer turns to face you.** He was a single drawing that always
looked south, no matter where you stood -- fine for judging the design,
wrong for the person running the tournament. He is now the Colosseum's
own link receptionist, which suits the room: you have taken over the
link-battle hall, so the man whose desk it is runs your rounds.

He also no longer dresses like the Gentleman downstairs, so the two are
easy to tell apart.

## 0.9.6

**The host now only stands upstairs where there is actually an event.**
He was appearing in every Pokemon Center in the game, offering a
tournament in towns that host none -- and talking to him there continued
whatever run you had going, which is the same leak 0.9.5 was meant to
close. Cherrygrove, Azalea, Olivine and the rest are ordinary Pokemon
Centers again.

Five towns host events: Violet, Goldenrod, Ecruteak, Blackthorn and
Indigo Plateau. Nowhere else, and now the upstairs lobby says so by
being empty.

## 0.9.5

**Fixes a run leaking across venues.** Winning round 1 in Violet and then
walking into Goldenrod's Pokemon Center put you into round 2 of the
Goldenrod Open -- carrying your progress to a different tournament and
fighting it at Goldenrod's much higher levels. Four rounds could be spread
across four towns.

A run now belongs to the venue it started in. Entering a different one
forfeits it and the announcer draws you a fresh card, and he says so
rather than quietly resetting you. A tournament already in progress when
you update is adopted by its venue, not thrown away.

**Fixes an awkward line break in the announcer's welcome at Goldenrod.**
The town and the event name were split across two boxes at every venue,
which is only needed at the three where they do not fit on one line.

## 0.9.4

**The tournament now runs to the anime's own format: three-on-three
through the preliminaries, six-on-six for the final round.** This half is
the challengers' side of it -- every round-four opponent now fields a
full team of six, and the three round-three challengers who fielded four
are back to three.

The final round is where you will notice it. LANCE brings his three
DRAGONITE, CLAIR her DRAGONAIR line, RED the team he actually keeps on
Mt. Silver. Round four should feel like a different kind of fight now,
not just a higher-levelled one.

Your own three-Pokemon limit is not in yet, so the final round is
currently six against however many you brought.

## 0.9.3

**Winning a tournament is now recorded on your team.** Every Pokemon in
your party when you take a venue's title remembers that it won there.

Nothing shows this yet. It is the groundwork for a Conference ribbon in
Ribbons, and it is written whether or not you have Ribbons installed --
so if you install it later, the runs you have already won still count.

**Fixes the announcer's text running off the box at four of the five
venues.** The welcome and the victory line put the town and the title on
one line, which fits at VIOLET and nowhere else -- "INDIGO PLATEAU
CONFERENCE!" is 26 columns in an 18-column box. Both now break across
pages. The escort's "for the next round." was one column over as well.

## 0.9.2

**Fixes ordinary Johto trainers fighting with tournament teams.** A
Camper out on the routes could send out a challenger's Pokémon instead of
his own — and the same went for most trainer types the roster borrows
from, which is most trainers in the game. Tournament teams are now
applied only inside the tournament.

Nothing was permanently changed in anyone's save; affected trainers go
back to their proper teams as soon as this update is installed.

## 0.9.1

**Challengers battle under their own names.** Until now a challenger was
announced as whichever generic trainer was standing in for them —
"COOLTRAINER NICK" instead of WES. Each one now has a real trainer record
of their own, so the battle says **COOLTRAINER WES**, **CAMPER TODD**,
**MEDIUM HELENA**. The class title stays generic, since that is what
carries their portrait, but the name is theirs. Tier 4 was already
correct: those are real characters in the game's own data, so Brock has
always been "LEADER BROCK".

No vanilla trainer anywhere in Johto is altered — the new records are
appended alongside the existing ones.

## 0.9.0

**The pool.** The fixed four-challenger card becomes a 39-strong roster
across the four tiers, written by the design pass: anime one-offs and
rookies in tier 1, rivals and specialists in tier 2, the Orre cast and
manga trainers in tier 3, and a legacy tier of Kanto leaders, the Elite
Four, LANCE — and RED and BLUE — all battling under their real names and
portraits.

**The draw.** Every run fields one challenger per tier, drawn at random,
persisted with the save so a run survives quit/reload. Clearing the card
or being eliminated draws a fresh field, and a new draw never repeats
the previous run's pick in any tier — so back-to-back tournaments always
look different. The Announcer gained three hype variants per round to
keep pace.

Every class, member, sprite and species verified against the extracted
ROM data. Three characters ride real same-name members found in Gold's
own trainer table (SCHOOLBOY JOE, HIKER ANTHONY, HIKER MICHAEL), and
MR__MIME's two-underscore spelling was caught before it could fail
silently.

## 0.8.1

Winning the final round now gets a proper send-off — "CONGRATULATIONS
TO <you>, folks! That's ALL! We'll see you next time!" — instead of the
announcer promising to set up a round that doesn't exist.

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
