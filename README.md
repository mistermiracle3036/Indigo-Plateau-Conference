# Indigo Plateau Conference

A tournament circuit for **Pokémon Gold, Silver and Crystal**, built on
[gen1recomp](https://github.com/bryanthaboi/gen1recomp).

Upstairs in every Pokémon Center there's a battle room nobody uses — the
link-battle room single player never sees. The Colosseum circuit fills it.
Climb the stairs in Violet and you've walked into the Violet Qualifier; do
it in Blackthorn and it's the Masters. Four rounds, one challenger each, a
different field every time, ending at the Indigo Plateau Conference itself.

> **Playable end to end.** All five events run, and the roster is complete.
> Bug reports and ideas are welcome in [GitHub Issues](../../issues) —
> please include the version from the load banner and which other mods you
> had enabled.

> **Six-new-challenger test.** Version 1.1.39 adds N, Ingo, Pokémon Breeder,
> Santa, Nurse Joy and Modern Red to the normal tournament draw with credited
> custom battle and overworld art. All six can be forced into round one through
> **DEV: First-round guest** for quick phone testing.

> **KiravelSoul test.** Version 1.1.37 adds Volkner to the normal roster and
> adds Armored Mewtwo only to **DEV: First-round guest**. Armored Mewtwo is an
> explicit exception to the trainer-only rule and can never enter a random draw.

> **Creator-folder roster test.** Version 1.1.35 adds Barry, Bill, Colress,
> Hugh, Maxie, Wally, Gloria, Officer Jenny and Ruin Maniac using credited
> sheets from NolanKrawczak, RoyalGuard and TeamHistoryWaffles. Nate now uses
> Bani's sheet. Pokémon-only sheets, native Gen 2 trainers and duplicate May,
> Lorelei and Lance sheets remain excluded.

> **Chef test.** Version 1.1.36 adds Bani's Chef only to the first-round
> developer selector. Chef fields one Raticate as a short Ratatouille-style
> visual test and does not enter the normal 81-challenger draw.

> **Bani roster test.** Version 1.1.34 added Eusine, Juliana, Leaf, Lear,
> Lillie and Looker with credited Bani battle and overworld art. Each is in
> the normal draw and can also be forced into round one through
> **DEV: First-round guest**.

> **Roxie revision test.** The build keeps tharkka's approved battle
> front and changes only the commissioned overworld hair to the light Gold
> palette value. Select **Roxie** under **DEV: First-round guest** to force her
> into round one and review both sprites on device.

> **Sandalwood Villa integration.** Defeat Roxie in any Conference draw with
> Sandalwood Town 0.2.0 installed. After buying the Villa's Music System, its
> steward can host Roxie and her band for a one-night show. Sandalwood remains
> optional and can reconstruct the unlock after a late install.

Want to know who's in the pool, or how the levels are decided? Open the
**[FAQ and spoiler guide](FAQ.md)** — every answer is collapsed, so you
only reveal what you want to know.

| | |
| --- | --- |
| ![A challenger's battle intro: LEADER BLUE wants to battle!](docs/challenger-blue.png) | ![The announcer sends the new champion off: That's ALL! We'll see you next time!](docs/announcer-sendoff.png) |
| Challengers fight under their own names. | The announcer sees you out after the final round. |

## The circuit

Five events, one per town. Which one you get is decided by whose stairs you
climbed — the mod adds no maps, no warps and no new buildings.

| Event | Climb the stairs in | To enter |
| --- | --- | --- |
| Violet Qualifier | Violet City | the Zephyr Badge |
| Goldenrod Open | Goldenrod City | 3 Johto badges |
| Ecruteak Invitational | Ecruteak City | 4 Johto badges |
| Blackthorn Masters | Blackthorn City | 8 Johto badges |
| Indigo Plateau Conference | Indigo Plateau | beat the Elite Four |

Only **Johto** badges count. The host tells you what's missing, and being
turned away costs nothing — a tournament you have running somewhere else is
left alone.

**Difficulty is fixed per venue, not scaled to you.** Each event is
anchored to that town's own gym leader — a step above the gym, climbing
again with every round. So the Violet Qualifier is an early-game
tournament no matter when you walk into it, and clearing the Blackthorn
Masters means something specific. The anchor is read from the game's own
trainer data rather than written down in the mod, so it stays honest if
anything rebalances.

## How a run works

- **Four rounds**, one challenger each.
- **Rounds 1–3 use only party slots 1–3.** Reorder your party before
  entering; Pokémon in slots 4–6 are benched and do not appear in the
  battle switch menu. All six return for the final.
- **Win all four** and the title is yours, with a send-off from the
  announcer.
- **Lose any round and you're eliminated** — back to round one with a
  brand-new field of challengers. Losing here is not a blackout: you don't
  lose money and you aren't sent to a Pokémon Center. Your team is patched
  up where it stands. PP is *not* restored, so a fresh run is never free.
- **It's repeatable.** Take a title and you can enter again; the announcer
  draws a new card.
- **A run in progress survives quitting.** The bracket travels with your
  in-game save, so loading an older save rewinds the tournament with it.

**Every run fields a different card.** The roster is 88 challengers across
four escalating tiers, and each run draws one per tier. A new draw never
repeats the previous run's pick in a tier, so back-to-back tournaments
always look different. Challengers speak for themselves — an introduction
on the way in, a parting line on the way out — and they battle under their
own names.

## Options

Two options appear on the mod's own options screen in this test build.

| Option | Default | What it does |
| --- | --- | --- |
| Diagnostic rows | **Off** | Prints what the mod is doing to the mod manager's `[ERRS]` screen |
| DEV: First-round guest | **Random** | Forces one of the 59 cleared guests or 2 private art probes into round one so each sprite can be tested directly; the probes never enter a random draw |

Leave it off for normal play. **Turn it on if you're reporting a bug** —
it's the only way to see what happened, since there's no console on a
phone. See the [FAQ](FAQ.md) for what to send.

> There is an engine-wide bug (not specific to this mod) where an option
> changed during a Gold game may not be remembered on restart. If a toggle
> doesn't stick, that's why.

## Installation

1. Download the zip from the
   [latest release](../../releases/latest).
2. In the launcher: **MODS → Import mod .zip**. On iOS, delete any older
   copy of the zip from Files first.
3. Fully quit and relaunch.

Requires gen1recomp **0.2.22 or newer**. No engine changes or companion mods
are required; Sandalwood Town is optional for the Villa show.

After installing an update, **fully quit and relaunch**. The load banner
prints the running version, so you can confirm what's actually live.

## Compatibility

**All Gen 2 editions:** Pokémon Gold, Silver and Crystal. The mod does not
load in Red, Blue or Yellow.

- **It sits quietly beside other mods.** It ships no maps, tilesets or
  warps, and changes no vanilla NPC, script or trainer. Everything it
  places in the Colosseum is a runtime object, which never enters the
  map-data merge — so no other mod's map patch can clobber it, and it
  clobbers nothing.
- **Ordinary trainers out in Johto are unaffected.** Tournament teams
  apply only inside the tournament.
- **Sandalwood Town 0.2.0** — optional. A saved victory over Roxie unlocks
  her one-night Villa show through the public Villa API. Neither mod reads
  the other's private save bucket.
- **[Ribbons](https://github.com/mistermiracle3036/Ribbons)** — optional,
  and **planned rather than working today**. Winning a title is already
  recorded on every Pokémon in your party, whether or not you have Ribbons
  installed. A Conference ribbon in that mod will read the record when it
  ships. Because the record lives on the Pokémon, it applies backwards:
  tournaments you've already won will count, and you can install Ribbons
  later without redoing anything.

## Credits

By **Mister Miracle**
([@mistermiracle3036](https://github.com/mistermiracle3036)).

- Custom roster art by **MOLLY**, **SirWhibbles**, **KIRB/YOSHI**, **Santiago
  Speedpaints a.k.a. Rojimenez**, **Bani**, **NolanKrawczak**,
  **RoyalGuard**, **TeamHistoryWaffles**, **KiravelSoul**, and **Yogurcomics** is individually listed in
  [CREDITS.md](CREDITS.md), with their exact permission statement recorded in
  [SPRITE_PERMISSIONS.md](SPRITE_PERMISSIONS.md). The announcer uses Gen 2's own
  Link Receptionist sprite. Every custom sprite and battle front is private to
  this mod and does not replace a shared vanilla trainer class.
- The owned-NPC pattern this mod uses was proven on Gold first in **Court
  of Noctowl**.
- Built on the [gen1recomp](https://github.com/bryanthaboi/gen1recomp)
  engine, with reference to the [pret](https://github.com/pret)
  disassembly research.
- No artwork from the earlier Crystal Clear proof-of-concept is included.
- A.J.'s directly approved custom battle and overworld art is by
  **TheBrawlUnit**.
- Larry, Ash, Yellow, Nate, Eusine, Juliana, Leaf, Lear, Lillie, Looker, Chef and
  Ranger battle and overworld art is by **Bani**, cleared for use with Bani
  credit. Duplica, Giselle and Suzie use Bani sheets as documented visual
  substitutes rather than bespoke art of those characters.
- Ball Guy's battle and overworld art is by **CyUzi**, used with the artist's
  direct confirmation and required credit.
- Volkner and the developer-only Armored Mewtwo exception use battle and
  overworld art by **KiravelSoul**, under the same user-confirmed visible-credit
  terms as the other approved creator folders.
Pokémon and Pokémon character names are trademarks of Nintendo, Creatures
Inc. and GAME FREAK inc. This is an unofficial fan project, not affiliated
with or endorsed by any of them.

Licensed under [MIT](LICENSE) — the licence covers this mod's own code, not
the credited artists' character art, ROM-derived material, or the trademarks above. See
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
