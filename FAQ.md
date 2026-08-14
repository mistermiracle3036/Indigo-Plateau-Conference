# Indigo Plateau Conference — FAQ and spoiler guide

Every answer is collapsed. Tap only what you want revealed — the later
sections name challengers.

## Basics

<details>
<summary>Where do I find it?</summary>

Go **upstairs in a Pokémon Center** and talk to the host in the lobby. He
lets you into the Colosseum, the battle room single player normally can't
reach.

Five towns host an event: Violet, Goldenrod, Ecruteak, Blackthorn and
Indigo Plateau. Whose stairs you climbed decides which tournament you've
entered.
</details>

<details>
<summary>Do I need badges to enter?</summary>

Yes. Each event asks for the badges you'd reasonably have by the time
you reach that town:

| Event | To enter |
| --- | --- |
| Violet Qualifier | the Zephyr Badge |
| Goldenrod Open | 3 Johto badges |
| Ecruteak Invitational | 4 Johto badges |
| Blackthorn Masters | 8 Johto badges |
| Indigo Plateau Conference | beat the Elite Four |

Only **Johto** badges count. The host will tell you what's missing, and
being turned away costs you nothing — a tournament you have running
somewhere else is untouched.
</details>

<details>
<summary>Can I do it more than once?</summary>

Yes, as many times as you like. Win a title and the announcer invites you
back and draws a fresh card. Every run fields a different set of
challengers.
</details>

<details>
<summary>What happens if I lose?</summary>

You're **eliminated**, not wiped out. There's no blackout: you keep your
money, you aren't dumped back at a Pokémon Center, and your team is healed
where it stands.

Your **PP is not restored**, though, so starting another run immediately
isn't free.

Elimination sends you back to round one with a **completely new field** —
even if you lost in round one. Retrying never means grinding the same face
twice.
</details>

<details>
<summary>Can I quit in the middle of a tournament?</summary>

Yes. The bracket is stored with your in-game save, so a run in progress
survives quitting and reloading.

It also means loading an *older* save rewinds the tournament along with
everything else — the mod won't think you're still in round three of a run
your save doesn't remember.
</details>

## Difficulty

<details>
<summary>How are challenger levels decided?</summary>

Each venue is anchored to **that town's own gym leader**. The circuit sits
a couple of levels above the gym, and climbs again with every round.

So the Violet Qualifier is an early-game tournament whenever you enter it,
and the Blackthorn Masters is a late one. Nothing scales to your party —
an earlier version did that, and it meant winning proved nothing, because
the circuit could never be too hard or too easy.

The anchor is read from the game's own trainer data rather than written
into the mod, so it stays correct if anything ever rebalances the gyms.
</details>

<details>
<summary>I walked into a venue far too strong for me. Is that a bug?</summary>

Probably not. The badge requirements keep you out of the events built for
a much later team, but they're a floor, not a promise — a tournament is
meant to be a step above the gym you just cleared, and the last round is
a step above that.

If a venue feels wrong for where you are, the fastest check is which town
you climbed the stairs in: the event is anchored to *that* town's gym
leader, not to your team.
</details>

## The pool (spoilers)

<details>
<summary>Who is in the roster?</summary>

**39 challengers across four tiers**, and each run draws one from each —
so a card is four opponents, escalating.

Broadly: anime one-offs and rookies in tier 1; rivals and specialists in
tier 2; the Orre cast and manga trainers in tier 3; and a legacy tier of
Kanto gym leaders, the Elite Four, and a couple of names you'll recognise
immediately.
</details>

<details>
<summary>Do challengers use their real names?</summary>

Yes. A challenger is announced under their own name — **COOLTRAINER WES**,
**CAMPER TODD**, **MEDIUM HELENA**. The class title in front stays generic,
because that's what carries their portrait, but the name is theirs.

No vanilla trainer anywhere in Johto is altered to do this.
</details>

<details>
<summary>Will I see the same challengers every time?</summary>

No. Each run draws one challenger per tier at random, and a new draw never
repeats the previous run's pick in that tier. Back-to-back tournaments
always look different.
</details>

## Other mods

<details>
<summary>Does it work alongside my other mods?</summary>

It's built to. The mod adds no maps, no tilesets and no warps, and changes
no vanilla NPC, script or trainer. Everything it puts in the Colosseum
exists only while you're standing there, so it never collides with another
mod's changes to the same map.

Ordinary trainers out in Johto are unaffected — tournament teams apply
only inside the tournament.
</details>

<details>
<summary>Is there a ribbon for winning?</summary>

**Planned, not working yet.**

Winning a title is already recorded on **every Pokémon in your party** at
the moment you take it — that happens whether or not you have
[Ribbons](https://github.com/mistermiracle3036/Ribbons) installed. A
Conference ribbon in that mod will read the record once it ships.

Because the record lives on the Pokémon rather than in a list somewhere,
it works backwards: tournaments you've already won will count, and you can
install Ribbons later without redoing a thing. It survives boxing,
evolution and trading, like anything else stored on a Pokémon.
</details>

<details>
<summary>Does it work on Red, Blue, Yellow or Crystal?</summary>

No — **Gold only**. The circuit is built on Gold's own trainer data and
Johto's towns. On other games the mod doesn't load.
</details>

## Diagnostics

<details>
<summary>What is the "Diagnostic rows" option?</summary>

It prints what the mod is doing to the mod manager's `[ERRS]` screen —
which round you're on, which challengers were drawn, what happened when a
battle ended.

It's **off by default** and normal play doesn't need it. Turn it on when
you're reporting a bug: on a phone there's no console, so `[ERRS]` is the
only place the mod can tell you anything.
</details>

<details>
<summary>I turned an option on and it forgot after a restart.</summary>

That's an engine-wide bug affecting every mod with options, not this mod
specifically: a setting changed during a Gold game may not be saved.

If a toggle won't stick, that's the cause. It's worth mentioning in a bug
report so nobody hunts for it here.
</details>

## Troubleshooting

<details>
<summary>The host turns to face me and nothing happens.</summary>

That's the signature of a swallowed script error — the mod tried to do
something and failed silently.

Please open an issue with: the version from the load banner, which town
you were in, which round you were on, and which other mods were enabled.
**Turn on Diagnostic rows**, reproduce it, and send what `[ERRS]` shows —
that's the single most useful thing you can include.
</details>

<details>
<summary>I updated the mod but it's behaving like the old version.</summary>

Fully quit and relaunch the game. Hot-reloading can leave stale code in
memory.

Check the version on the load banner against the release you installed.
On iOS, also delete any older copy of the zip from Files — importing it
again can quietly reinstall the old one.
</details>

<details>
<summary>A challenger sent out a Pokémon I didn't expect, or a trainer out
on the routes used a tournament team.</summary>

The second one was a real bug and is fixed — tournament teams now apply
only inside the tournament. Nothing was permanently changed in anyone's
save; affected trainers went back to their proper teams as soon as the fix
was installed.

If you still see it, that's worth an issue, with the trainer and where you
met them.
</details>
