"""Draft of the 21 new cup challengers (REQUESTS 372, developer 2026-11-01:
"A all cup challengers"). Writes tools/team_sources/IPC-new-challengers-2026-11-01.json
in the shape of IPC-developer-team-additions.json, plus carrier, overworld
colour and dialogue, and validates it:

  * every species resolves (vanilla Crystal, or an activated catalog entry on
    the expanded track only) -- the same Resolver gen_expanded.py uses;
  * every dialogue page is <= 2 lines of <= 18 characters; chat/intro/
    afterWin/afterLoss open with "NAME:", win/loss do not (the IPC rule).

DRAFT: nothing here ships until the developer has reviewed it on the review
page. Small = first three slots, six = small + three; slot 3 is the ace.
"""
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import gen_expanded as G  # noqa: E402

OUT = os.path.join(HERE, "team_sources", "IPC-new-challengers-2026-11-01.json")


def team(early, middle, full):
    """Each arg: (small3, extra3) as space-separated names; '+' marks the ace
    offset (+1), '-' a -1 offset."""
    def mons(s):
        out = []
        for tok in s.split():
            off = 1 if tok.endswith("+") else -1 if tok.endswith("-") else 0
            name = tok.rstrip("+-").replace("_", " ")
            form = ""
            if name.startswith("Wooper["):
                name, form = "Wooper", "Paldean"
            out.append({"species": name, "offset": off} | ({"form": form} if form else {}))
        return out
    return [(st, mons(a), mons(b)) for st, (a, b) in zip(G.STRENGTHS, (early, middle, full))]


# name, key, tier, carrier class/member, overworld palette, theme,
# gen12 team, expanded team, lines
C = []


def add(key, name, tier, cls, member, pal, theme, gen12, exp, lines):
    C.append(dict(key=key, name=name, tier=tier, cls=cls, member=member, pal=pal,
                  theme=theme, gen12=gen12, exp=exp, lines=lines))


add("ALDER", "ALDER", 4, "CHAMPION", "LANCE", "PAL_OW_RED",
    "Unova's wandering champion: bugs, fighters and fire",
    team(("LEDYBA MANKEY GROWLITHE+", "TAUROS PINECO MACHOP"),
         ("LEDIAN PRIMEAPE ARCANINE+", "TAUROS FORRETRESS MACHOKE"),
         ("HERACROSS SCIZOR ARCANINE+", "TAUROS FORRETRESS MACHAMP")),
    team(("Venipede Riolu GROWLITHE+", "TAUROS PINECO MACHOP"),
         ("Whirlipede Lucario ARCANINE+", "TAUROS FORRETRESS MACHOKE"),
         ("Scolipede Lucario ARCANINE+", "TAUROS SCIZOR MACHAMP")),
    dict(chat="ALDER: I wander\nto learn. Today\fI learn from you!",
         intro="ALDER: Show me\nwhat you love!",
         win="Ha! You fight\nwith your heart.",
         loss="A good match is\na gift. Thanks!",
         afterWin="ALDER: Keep that\nfire burning.",
         afterLoss="ALDER: Rest, then\ntry me again!"))

add("BIANCA", "BIANCA", 2, "COOLTRAINERF", "LOIS", "PAL_OW_GREEN",
    "cheerful rival from Nuvema: fire starter and cuddly friends",
    team(("SNUBBULL DROWZEE CYNDAQUIL+", "HOPPIP PSYDUCK MARILL"),
         ("SNUBBULL HYPNO QUILAVA+", "SKIPLOOM PSYDUCK MARILL"),
         ("GRANBULL HYPNO TYPHLOSION+", "JUMPLUFF GOLDUCK AZUMARILL")),
    team(("SNUBBULL DROWZEE Torchic+", "Skitty PSYDUCK MARILL"),
         ("SNUBBULL HYPNO Combusken+", "Delcatty PSYDUCK MARILL"),
         ("GRANBULL HYPNO Blaziken+", "Delcatty GOLDUCK AZUMARILL")),
    dict(chat="BIANCA: Oh! Wait\nup! I got lost\fon the way here.",
         intro="BIANCA: I'll do\nmy very best!",
         win="Waah! You're so\nstrong!",
         loss="I did it! I\nreally did it!",
         afterWin="BIANCA: Next time\nI won't get lost!",
         afterLoss="BIANCA: Yay! Let's\nbattle again!"))

add("BURGH", "BURGH", 3, "BROCK", "BROCK1", "PAL_OW_BROWN",
    "Castelia's artist leader: bugs as living art",
    team(("SPINARAK PINECO SCYTHER+", "VENONAT PARAS WEEDLE"),
         ("ARIADOS PINECO SCYTHER+", "VENONAT PARAS KAKUNA"),
         ("ARIADOS FORRETRESS SCIZOR+", "VENOMOTH PARASECT BEEDRILL")),
    team(("Venipede Nincada SCYTHER+", "Wurmple PARAS Wimpod"),
         ("Whirlipede Ninjask SCYTHER+", "Silcoon PARAS Wimpod"),
         ("Scolipede Ninjask SCIZOR+", "Beautifly PARASECT Golisopod")),
    dict(chat="BURGH: Every bug\nis a brushstroke.",
         intro="BURGH: Let's\npaint a battle!",
         win="A masterpiece!\nNot mine, though.",
         loss="My canvas is\ncomplete!",
         afterWin="BURGH: You've\ninspired me!",
         afterLoss="BURGH: Art takes\npractice. Return!"))

add("CHEREN", "CHEREN", 2, "COOLTRAINERM", "AARON", "PAL_OW_BLUE",
    "serious rival from Nuvema: steady normal types and a water starter",
    team(("SENTRET MEOWTH TOTODILE+", "RATTATA AIPOM TEDDIURSA"),
         ("FURRET PERSIAN CROCONAW+", "RATICATE AIPOM URSARING"),
         ("FURRET PERSIAN FERALIGATR+", "RATICATE KANGASKHAN URSARING")),
    team(("SENTRET Zorua TOTODILE+", "Starly AIPOM TEDDIURSA"),
         ("FURRET Zoroark CROCONAW+", "Staravia AIPOM URSARING"),
         ("FURRET Zoroark FERALIGATR+", "Staraptor KANGASKHAN URSARING")),
    dict(chat="CHEREN: What does\nstrength mean to\fyou? I still ask.",
         intro="CHEREN: Let's\nfind out.",
         win="I see. I have\nmore to learn.",
         loss="That's one\nanswer, at least.",
         afterWin="CHEREN: You made\nme think.",
         afterLoss="CHEREN: Strong is\nnot the same as\fright. Remember."))

add("CILAN", "CILAN", 3, "BLAINE", "BLAINE1", "PAL_OW_GREEN",
    "Striaton connoisseur: grass types, served with flair",
    team(("HOPPIP SUNKERN BELLSPROUT+", "ODDISH EXEGGCUTE SNUBBULL"),
         ("SKIPLOOM SUNKERN WEEPINBELL+", "GLOOM EXEGGCUTE SNUBBULL"),
         ("JUMPLUFF SUNFLORA VICTREEBEL+", "BELLOSSOM EXEGGUTOR GRANBULL")),
    team(("HOPPIP SUNKERN Treecko+", "ODDISH Roselia SNUBBULL"),
         ("SKIPLOOM SUNKERN Grovyle+", "GLOOM Roselia SNUBBULL"),
         ("JUMPLUFF SUNFLORA Sceptile+", "BELLOSSOM Roserade GRANBULL")),
    dict(chat="CILAN: Let me\nsavor this match.",
         intro="CILAN: It's\ntasting time!",
         win="A flavor I\ndidn't expect!",
         loss="A perfect\npairing!",
         afterWin="CILAN: Your style\nhas real taste.",
         afterLoss="CILAN: A dash more\nspice next time!"))

add("DRAYDEN", "DRAYDEN", 3, "CLAIR", "CLAIR1", "PAL_OW_BLUE",
    "Opelucid's mayor and dragon master",
    team(("HORSEA LARVITAR DRATINI+", "ONIX CHARMANDER GLIGAR"),
         ("SEADRA PUPITAR DRAGONAIR+", "ONIX CHARMELEON GLIGAR"),
         ("KINGDRA TYRANITAR DRAGONITE+", "STEELIX CHARIZARD GLIGAR")),
    team(("HORSEA Swablu Gible+", "ONIX CHARMANDER GLIGAR"),
         ("SEADRA Altaria Gabite+", "ONIX CHARMELEON GLIGAR"),
         ("KINGDRA Altaria Garchomp+", "STEELIX CHARIZARD Gliscor")),
    dict(chat="DRAYDEN: Dragons\nteach patience.\fI hope you have\nsome.",
         intro="DRAYDEN: Then\nlet us begin.",
         win="Well fought. You\nearned this.",
         loss="Strength without\nhaste. Remember.",
         afterWin="DRAYDEN: You will\ngo far.",
         afterLoss="DRAYDEN: Train,\nand come again."))

add("ELESA", "ELESA", 3, "LT_SURGE", "LT_SURGE1", "PAL_OW_BLUE",
    "Nimbasa's shining model: electric types under the spotlight",
    team(("MAREEP ELEKID EEVEE+", "PICHU VOLTORB CHINCHOU"),
         ("FLAAFFY ELECTABUZZ JOLTEON+", "PIKACHU ELECTRODE CHINCHOU"),
         ("AMPHAROS ELECTABUZZ JOLTEON+", "RAICHU ELECTRODE LANTURN")),
    team(("MAREEP ELEKID EEVEE+", "PICHU MAGNEMITE CHINCHOU"),
         ("FLAAFFY ELECTABUZZ JOLTEON+", "PIKACHU MAGNETON CHINCHOU"),
         ("AMPHAROS Electivire JOLTEON+", "RAICHU Magnezone LANTURN")),
    dict(chat="ELESA: The lights\nare on. Ready?",
         intro="ELESA: Dazzle me!",
         win="You stole the\nshow tonight.",
         loss="Shocking, isn't\nit?",
         afterWin="ELESA: You'd look\ngood on a runway.",
         afterLoss="ELESA: Shine a\nlittle brighter!"))

add("GRIMSLEY", "GRIMSLEY", 4, "KAREN", "KAREN1", "PAL_OW_BLUE",
    "Elite Four gambler: dark types, all in",
    team(("SNEASEL MURKROW HOUNDOUR+", "MEOWTH EEVEE SANDSHREW"),
         ("SNEASEL MURKROW HOUNDOOM+", "PERSIAN UMBREON SANDSLASH"),
         ("SNEASEL MURKROW HOUNDOOM+", "PERSIAN UMBREON TYRANITAR")),
    team(("SNEASEL Zorua HOUNDOUR+", "MEOWTH EEVEE SANDSHREW"),
         ("SNEASEL Zoroark HOUNDOOM+", "PERSIAN UMBREON Spiritomb"),
         ("Obstagoon Zoroark HOUNDOOM+", "PERSIAN UMBREON Spiritomb")),
    dict(chat="GRIMSLEY: Life's\na gamble. So is\fthis match.",
         intro="GRIMSLEY: All in.",
         win="The dice turned.\nSo it goes.",
         loss="The house\nalways wins.",
         afterWin="GRIMSLEY: Lady\nLuck likes you.",
         afterLoss="GRIMSLEY: Bet\nagain sometime."))

add("IRIS", "IRIS", 4, "CHAMPION", "LANCE", "PAL_OW_PINK",
    "young dragon champion from the Village of Dragons",
    team(("LARVITAR LAPRAS DRATINI+", "ONIX OMANYTE KABUTO"),
         ("PUPITAR LAPRAS DRAGONAIR+", "ONIX OMANYTE AERODACTYL"),
         ("TYRANITAR LAPRAS DRAGONITE+", "STEELIX OMASTAR AERODACTYL")),
    team(("LARVITAR LAPRAS DRATINI+", "Aron Archen Gible"),
         ("PUPITAR LAPRAS DRAGONAIR+", "Lairon Archen Gabite"),
         ("TYRANITAR LAPRAS DRAGONITE+", "Aggron Archeops Garchomp")),
    dict(chat="IRIS: Ooh, you\nlook really\fstrong! Let's go!",
         intro="IRIS: My dragons\nare fired up!",
         win="Aww! You're\nreally good!",
         loss="Yay! The dragons\nand me did it!",
         afterWin="IRIS: Next time\nI'll win for sure!",
         afterLoss="IRIS: That was so\nmuch fun!"))

add("MARSHAL", "MARSHAL", 4, "BRUNO", "BRUNO1", "PAL_OW_BROWN",
    "Elite Four fighter, Alder's apprentice",
    team(("MACHOP MANKEY TYROGUE+", "POLIWAG HERACROSS TEDDIURSA"),
         ("MACHOKE PRIMEAPE HITMONLEE+", "POLIWHIRL HERACROSS URSARING"),
         ("MACHAMP HITMONCHAN HITMONLEE+", "POLIWRATH HERACROSS URSARING")),
    team(("MACHOP Meditite TYROGUE+", "POLIWAG HERACROSS Riolu"),
         ("MACHOKE Medicham HITMONLEE+", "POLIWHIRL HERACROSS Lucario"),
         ("MACHAMP Medicham HITMONLEE+", "POLIWRATH HERACROSS Lucario")),
    dict(chat="MARSHAL: My master\ntaught me to fight\fwith a calm mind.",
         intro="MARSHAL: Hup!",
         win="Your spirit is\nstrong.",
         loss="Discipline wins.",
         afterWin="MARSHAL: I will\ntrain harder.",
         afterLoss="MARSHAL: Train\nyour body and\fyour mind."))

add("SHAUNTAL", "SHAUNTAL", 4, "KAREN", "KAREN1", "PAL_OW_BLUE",
    "Elite Four novelist: ghost types and the stories they tell",
    team(("MISDREAVUS TENTACOOL GASTLY+", "DROWZEE MURKROW VULPIX"),
         ("MISDREAVUS TENTACRUEL HAUNTER+", "HYPNO MURKROW VULPIX"),
         ("MISDREAVUS TENTACRUEL GENGAR+", "HYPNO MURKROW NINETALES")),
    team(("MISDREAVUS TENTACOOL GASTLY+", "DROWZEE MURKROW VULPIX"),
         ("MISDREAVUS TENTACRUEL HAUNTER+", "HYPNO Spiritomb VULPIX"),
         ("Mismagius TENTACRUEL GENGAR+", "HYPNO Spiritomb NINETALES")),
    dict(chat="SHAUNTAL: Ah! A\nnew character for\fmy next story!",
         intro="SHAUNTAL: Let's\nwrite a chapter.",
         win="What a twist!\nI must write it.",
         loss="And so the tale\nends... for now.",
         afterWin="SHAUNTAL: You'll\nbe my hero.",
         afterLoss="SHAUNTAL: Every\nstory needs a\fsequel."))

add("SKYLA", "SKYLA", 3, "MISTY", "MISTY1", "PAL_OW_BLUE",
    "Mistralton's pilot leader: birds of every size",
    team(("HOOTHOOT NATU PIDGEY+", "SPEAROW ZUBAT HOPPIP"),
         ("NOCTOWL NATU PIDGEOTTO+", "FEAROW GOLBAT SKIPLOOM"),
         ("NOCTOWL XATU PIDGEOT+", "FEAROW CROBAT JUMPLUFF")),
    team(("HOOTHOOT Swablu Starly+", "SPEAROW ZUBAT HOPPIP"),
         ("NOCTOWL Altaria Staravia+", "FEAROW GOLBAT SKIPLOOM"),
         ("NOCTOWL Altaria Staraptor+", "FEAROW CROBAT JUMPLUFF")),
    dict(chat="SKYLA: Cleared for\ntakeoff? Let's\ffly!",
         intro="SKYLA: Up, up and\naway!",
         win="Whoa! You flew\nright past me!",
         loss="Smooth landing!",
         afterWin="SKYLA: I'll catch\nyou on the wind.",
         afterLoss="SKYLA: Keep your\nhead in the sky!"))

add("VALERIE", "VALERIE", 3, "SABRINA", "SABRINA1", "PAL_OW_PINK",
    "Laverre's fairy-type designer",
    team(("SNUBBULL MARILL TOGEPI+", "CLEFAIRY JIGGLYPUFF MR._MIME"),
         ("SNUBBULL MARILL TOGETIC+", "CLEFAIRY JIGGLYPUFF MR._MIME"),
         ("GRANBULL AZUMARILL TOGETIC+", "CLEFABLE WIGGLYTUFF MR._MIME")),
    team(("SNUBBULL MARILL TOGEPI+", "Ralts JIGGLYPUFF MR._MIME"),
         ("SNUBBULL MARILL TOGETIC+", "Kirlia JIGGLYPUFF MR._MIME"),
         ("GRANBULL AZUMARILL Togekiss+", "Gardevoir WIGGLYTUFF MR._MIME")),
    dict(chat="VALERIE: Oh...\nhello. I was lost\fin a daydream.",
         intro="VALERIE: Let us\ndance, softly.",
         win="How lovely. You\nare like silk.",
         loss="A fairy tale\nending.",
         afterWin="VALERIE: You have\na gentle power.",
         afterLoss="VALERIE: Come see\nme again."))

add("WALLACE", "WALLACE", 4, "CHAMPION", "LANCE", "PAL_OW_BLUE",
    "Hoenn's water champion and contest star",
    team(("TENTACOOL SEEL STARYU+", "SHELLDER PSYDUCK WOOPER"),
         ("TENTACRUEL DEWGONG STARMIE+", "SHELLDER GOLDUCK QUAGSIRE"),
         ("TENTACRUEL GYARADOS STARMIE+", "CLOYSTER GOLDUCK QUAGSIRE")),
    team(("TENTACOOL Lotad Feebas+", "SHELLDER PSYDUCK Barboach"),
         ("TENTACRUEL Lombre Milotic+", "SHELLDER GOLDUCK Whiscash"),
         ("TENTACRUEL Ludicolo Milotic+", "CLOYSTER STARMIE Whiscash")),
    dict(chat="WALLACE: Battles\nshould be as\fbeautiful as the\nsea.",
         intro="WALLACE: Shall we\nbegin? Elegantly.",
         win="Magnificent! Truly\nmagnificent.",
         loss="Beauty and\nstrength, as one.",
         afterWin="WALLACE: Your\nstyle is stunning.",
         afterLoss="WALLACE: Polish\nyour grace."))

# Trainer classes (BW3G). The sheet names two as "Infer" and "Infer sage";
# their display names are the developer's call on the review page.
add("CYCLIST_F", "CYCLIST", 1, "PICNICKER", "GINA1", "PAL_OW_PINK",
    "speedy cyclist: fast runners and fliers",
    team(("DODUO RATTATA PONYTA+", "PIDGEY SENTRET VOLTORB"),
         ("DODRIO RATICATE RAPIDASH+", "PIDGEOTTO FURRET ELECTRODE"),
         ("DODRIO RATICATE RAPIDASH+", "PIDGEOT FURRET ELECTRODE")),
    team(("DODUO Nincada PONYTA+", "PIDGEY SENTRET VOLTORB"),
         ("DODRIO Ninjask RAPIDASH+", "PIDGEOTTO FURRET ELECTRODE"),
         ("DODRIO Ninjask RAPIDASH+", "PIDGEOT FURRET ELECTRODE")),
    dict(chat="CYCLIST: I rode\nhere nonstop!",
         intro="CYCLIST: Let's go,\nfull speed!",
         win="Flat tire!",
         loss="Downhill all\nthe way!",
         afterWin="CYCLIST: You're\nfaster than me!",
         afterLoss="CYCLIST: Wanna\nrace again?"))

add("HARLEQUIN", "HARLEQUIN", 1, "JUGGLER", "FRITZ", "PAL_OW_RED",
    "clown: tricksters and mimics",
    team(("DROWZEE JIGGLYPUFF MR._MIME+", "SMOOCHUM VOLTORB AIPOM"),
         ("HYPNO JIGGLYPUFF MR._MIME+", "JYNX ELECTRODE AIPOM"),
         ("HYPNO WIGGLYTUFF MR._MIME+", "JYNX ELECTRODE AIPOM")),
    team(("DROWZEE Skitty MR._MIME+", "SMOOCHUM VOLTORB AIPOM"),
         ("HYPNO Delcatty MR._MIME+", "JYNX ELECTRODE AIPOM"),
         ("HYPNO Delcatty MR._MIME+", "JYNX ELECTRODE AIPOM")),
    dict(chat="HARLEQUIN: Step\nright up! The\fshow is free!",
         intro="HARLEQUIN: Ta-da!",
         win="My act fell\nflat!",
         loss="Thank you, thank\nyou!",
         afterWin="HARLEQUIN: Tough\ncrowd today.",
         afterLoss="HARLEQUIN: Encore!\nEncore!"))

# Renamed FIREBRAND by the developer on the review page; the approved words are
# unchanged, only rewrapped for the longer speaker tag.
add("INFER", "FIREBRAND", 2, "PICNICKER", "HOPE", "PAL_OW_PINK",
    "fire-type girl (sheet name 'Infer')",
    team(("SLUGMA VULPIX MAGBY+", "PONYTA HOUNDOUR EEVEE"),
         ("MAGCARGO VULPIX MAGMAR+", "PONYTA HOUNDOUR FLAREON"),
         ("MAGCARGO NINETALES MAGMAR+", "RAPIDASH HOUNDOOM FLAREON")),
    team(("SLUGMA Numel MAGBY+", "PONYTA HOUNDOUR EEVEE"),
         ("MAGCARGO Camerupt MAGMAR+", "PONYTA HOUNDOUR FLAREON"),
         ("MAGCARGO Camerupt MAGMAR+", "RAPIDASH HOUNDOOM FLAREON")),
    dict(chat="FIREBRAND: Is it\nhot in here, or is\fit just my team?",
         intro="FIREBRAND: Let's\nheat things up!",
         win="Burned out...",
         loss="Too hot to\nhandle!",
         afterWin="FIREBRAND: You put\nmy fire out!",
         afterLoss="FIREBRAND: Stay\nwarm!"))

add("INFER_SAGE", "SAGE", 2, "PSYCHIC_T", "HERMAN", "PAL_OW_PINK",
    "robed fire sage (sheet name 'Infer sage')",
    team(("GROWLITHE NATU PONYTA+", "ABRA VULPIX SLUGMA"),
         ("ARCANINE XATU RAPIDASH+", "KADABRA NINETALES MAGCARGO"),
         ("ARCANINE XATU RAPIDASH+", "ALAKAZAM NINETALES MAGCARGO")),
    team(("GROWLITHE NATU PONYTA+", "ABRA VULPIX Beldum"),
         ("ARCANINE XATU RAPIDASH+", "KADABRA NINETALES Metang"),
         ("ARCANINE XATU RAPIDASH+", "ALAKAZAM NINETALES Metagross")),
    dict(chat="SAGE: The flame\nreveals the truth.",
         intro="SAGE: Let the fire\njudge us.",
         win="The flame\nhas spoken.",
         loss="As the fire\nforetold.",
         afterWin="SAGE: Your light\nburns bright.",
         afterLoss="SAGE: Meditate\non this loss."))

add("LINEBACKER", "LINEBACKER", 2, "BLACKBELT_T", "YOSHI", "PAL_OW_BROWN",
    "football player: heavy rock and ground hitters",
    team(("GEODUDE CUBONE RHYHORN+", "MANKEY PHANPY TEDDIURSA"),
         ("GRAVELER MAROWAK RHYDON+", "PRIMEAPE DONPHAN URSARING"),
         ("GOLEM MAROWAK RHYDON+", "PRIMEAPE DONPHAN URSARING")),
    team(("GEODUDE Wooper[Paldean] RHYHORN+", "MANKEY PHANPY TEDDIURSA"),
         ("GRAVELER Clodsire RHYDON+", "PRIMEAPE DONPHAN URSARING"),
         ("GOLEM Clodsire Rhyperior+", "PRIMEAPE DONPHAN URSARING")),
    dict(chat="LINEBACKER: Huddle\nup! It's game day!",
         intro="LINEBACKER: Hut!\nHut! HIKE!",
         win="Fumble!",
         loss="Touchdown!",
         afterWin="LINEBACKER: You\nbroke my tackle!",
         afterLoss="LINEBACKER: Good\ngame! Shake on it."))

add("ROUGHNECK", "ROUGHNECK", 1, "BIKER", "ZEKE", "PAL_OW_BROWN",
    "tough guy: poison, smog and muscle",
    team(("GRIMER ZUBAT KOFFING+", "MACHOP SANDSHREW TEDDIURSA"),
         ("MUK GOLBAT WEEZING+", "MACHOKE SANDSLASH URSARING"),
         ("MUK GOLBAT WEEZING+", "MACHAMP SANDSLASH URSARING")),
    team(("Trubbish ZUBAT KOFFING+", "MACHOP SANDSHREW TEDDIURSA"),
         ("Garbodor GOLBAT WEEZING+", "MACHOKE SANDSLASH URSARING"),
         ("Garbodor GOLBAT WEEZING+", "MACHAMP SANDSLASH URSARING")),
    dict(chat="ROUGHNECK: What're\nyou lookin' at?",
         intro="ROUGHNECK: You\nasked for it!",
         win="Tch. Lucky.",
         loss="Hah! Too easy.",
         afterWin="ROUGHNECK: ...You\nain't bad, kid.",
         afterLoss="ROUGHNECK: Beat\nit, small fry."))

add("SOCIALITE", "SOCIALITE", 2, "BEAUTY", "VICTORIA", "PAL_OW_BROWN",
    "high-society lady: elegant and pampered",
    team(("MEOWTH HOPPIP EEVEE+", "ODDISH SMOOCHUM STARYU"),
         ("PERSIAN SKIPLOOM ESPEON+", "GLOOM JYNX STARMIE"),
         ("PERSIAN JUMPLUFF ESPEON+", "BELLOSSOM JYNX STARMIE")),
    team(("MEOWTH Wurmple EEVEE+", "ODDISH SMOOCHUM STARYU"),
         ("PERSIAN Beautifly ESPEON+", "GLOOM JYNX STARMIE"),
         ("PERSIAN Beautifly ESPEON+", "BELLOSSOM JYNX STARMIE")),
    dict(chat="SOCIALITE: Oh my,\nwhat a quaint\flittle stadium.",
         intro="SOCIALITE: Do try\nto keep up, dear.",
         win="How dreadfully\nrude!",
         loss="Simply\ndivine.",
         afterWin="SOCIALITE: You\nhave some class.",
         afterLoss="SOCIALITE: Tea,\nafterward?"))

# The developer's review on the IPC New Challengers page (2026-11-01): all 21
# approved. Notes are kept verbatim. These five are NOT to be lumped into the
# carrier's class: each battles under its OWN class with a personal name, e.g.
# "FIREBRAND JUDY". The carrier class/member above still supplies AI, music and
# money; only the display changes. Engine fact (v0.3.96): the Gen 2 battle
# prints opts.trainer.name, which World builds as className .. " " .. name
# (src/world/gen2/World.lua, "class then name, YOUNGSTER JOEY"), so IPC's
# existing World.startBattle wrap can set it to the new class plus name.
# TODO/CONFIRM at wiring: every other place that names the trainer (phone,
# rematch text, results card) uses the same string. Personal names are the
# developer's own examples ("whatever name"). Their lines keep the class word
# as the speaker tag (FIREBRAND:, SAGE:, ...), as the approved lines read.
NEW_CLASS = {
    "INFER": ("FIREBRAND", "JUDY"),
    "INFER_SAGE": ("SAGE", "CASSANDRA"),
    "LINEBACKER": ("LINEBACKER", "RAY"),
    "ROUGHNECK": ("ROUGHNECK", "ROCCO"),
    "SOCIALITE": ("SOCIALITE", "HOLLY"),
}
REVIEW = {
    "VALERIE": "valerie battle sprite appears to need color",
    "INFER": "should be a new trainer class named FIREBRAND, so would battle as FIREBRAND JUDY (whatever name)",
    "INFER_SAGE": "should be a new trainer class named SAGE, so would battle as SAGE CASSANDRA (whatever name)",
    "LINEBACKER": "should be a new trainer class named LINEBACKER , so would battle as LINEBACKER RAY (whatever name)",
    "ROUGHNECK": "should be a new trainer class named ROUGHNECK, so would battle as ROUGHNECK ROCCO (whatever name)",
    "SOCIALITE": "should be a new trainer class named SOCIALITE, so would battle as SOCIALITE HOLLY (whatever name)",
}


def check_lines(c):
    bad = []
    for f, s in c["lines"].items():
        for page in s.split("\f"):
            rows = page.split("\n")
            if len(rows) > 2:
                bad.append(f"{c['key']}.{f}: 3+ lines on a page")
            bad += [f"{c['key']}.{f}: {len(r)} chars: {r!r}" for r in rows if len(r) > 18]
        named = s.startswith(c["name"] + ":")
        if f in ("chat", "intro", "afterWin", "afterLoss") and not named:
            bad.append(f"{c['key']}.{f}: must open with '{c['name']}:'")
        if f in ("win", "loss") and named:
            bad.append(f"{c['key']}.{f}: battle lines are unnamed")
    return bad


def main():
    resolve = G.Resolver(G.load_json(G.CATALOG), G.rom_ids())
    fails, out = [], []
    for c in C:
        fails += check_lines(c)
        variants = []
        for (st, g_small, g_extra), (_, e_small, e_extra) in zip(c["gen12"], c["exp"]):
            for track, mons in (("gen12", g_small + g_extra), ("expanded", e_small + e_extra)):
                for m in mons:
                    sid, ent, held = resolve(m["species"], m.get("form", ""))
                    if held is not None:
                        fails.append(f"{c['key']} {st} {track}: {m['species']} is held")
                    if track == "gen12" and ent is not None:
                        fails.append(f"{c['key']} {st} gen12: {m['species']} is an added species")
            variants.append({"strength": st,
                             "gen12_small": g_small, "gen12_six": g_small + g_extra,
                             "expanded_small": e_small, "expanded_six": e_small + e_extra})
        row = {"key": c["key"], "name": c["name"], "tier": c["tier"],
               "class": c["cls"], "member": c["member"], "overworld_palette": c["pal"],
               "theme": c["theme"], "variants": variants, "lines": c["lines"]}
        if c["key"] in NEW_CLASS:
            cls, person = NEW_CLASS[c["key"]]
            row["new_class"] = {"display_class": cls, "personal_name": person,
                                "battles_as": f"{cls} {person}"}
        if c["key"] in REVIEW:
            row["developer_note"] = REVIEW[c["key"]]
        out.append(row)
    for f in fails:
        print("FAIL", f)
    doc = {"date": "2026-11-01",
           "status": "APPROVED: all 21 by the developer on the review page, 2026-11-01 (REQUESTS 372)",
           "new_classes": "INFER, INFER_SAGE, LINEBACKER, ROUGHNECK and SOCIALITE battle under their own new class + "
                          "personal name (see new_class); never shown as the carrier's class",
           "request": "developer, 2026-11-01: \"A all cup challengers\"",
           "note": "Same variant shape as IPC-developer-team-additions.json. Slot 3 is the ace.",
           "trainers": out}
    with open(OUT, "w", encoding="utf-8", newline="\n") as f:
        json.dump(doc, f, indent=1, ensure_ascii=False)
        f.write("\n")
    print(f"{len(out)} trainers, {len(fails)} problem(s) -> {OUT}")
    return 1 if fails else 0


if __name__ == "__main__":
    sys.exit(main())
