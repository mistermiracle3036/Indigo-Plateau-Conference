-- Source: official-stats
-- Dropped level moves absent from Crystal moveOrder: FEINT, FORCEPALM, CALMMIND, HIGHJUMPKICK, ACUPRESSURE, POWERTRICK
-- Dropped tmhm moves absent from Crystal moveOrder: SIGNALBEAM, FLING, FOCUSPUNCH, FOCUSBLAST, BRICKBREAK, DRAINPUNCH, LOWSWEEP, POWERUPPUNCH, BULKUP, GRASSKNOT, FACADE, ROUND, CONFIDE, HELPINGHAND, RECYCLE, WORKUP, POISONJAB, PSYSHOCK, ZENHEADBUTT, CALMMIND, GRAVITY, MAGICCOAT, ROLEPLAY, TELEKINESIS, TRICK, ROCKTOMB, RETALIATE
-- Dropped egg moves absent from Crystal moveOrder: FAKEOUT, POWERSWAP, GUARDSWAP, PSYCHOCUT, BULLETPUNCH, DRAINPUNCH, SECRETPOWER, QUICKGUARD
-- Same-move identifier normalization (accepted batch1 convention): HIDDENPOWER=HIDDEN_POWER, MINDREADER=MIND_READER, PSYCHUP=PSYCH_UP, ROCKSMASH=ROCK_SMASH, LOWKICK=LOW_KICK, FIREPUNCH=FIRE_PUNCH, SUNNYDAY=SUNNY_DAY, SHADOWBALL=SHADOW_BALL, ICEPUNCH=ICE_PUNCH, DOUBLETEAM=DOUBLE_TEAM, PAINSPLIT=PAIN_SPLIT, SLEEPTALK=SLEEP_TALK, DREAMEATER=DREAM_EATER, PSYCHIC=PSYCHIC_M, LIGHTSCREEN=LIGHT_SCREEN, ROCKSLIDE=ROCK_SLIDE, RAINDANCE=RAIN_DANCE, BATONPASS=BATON_PASS
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_HUMANSHAPE; cryBase proposal: MACHOP; developer veto applies.
-- Dex source game: diamond.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "MEDITITE",
    slug = "meditite",
    name = "MEDITITE",
    dex = 307,
    types = {"FIGHTING", "PSYCHIC_TYPE"},
    baseStats = {hp = 30, attack = 40, defense = 55, specialAttack = 40, specialDefense = 55, speed = 60},
    catchRate = 180,
    baseExp = 56,
    growthRate = "GROWTH_MEDIUM_FAST",
    genderRatio = 127,
    eggGroups = {"EGG_HUMANSHAPE", "EGG_HUMANSHAPE"},
    eggGroupsRaw = 136,
    eggSteps = 20,
    levelMoves = {{level = 1, move = "BIDE"}, {level = 4, move = "MEDITATE"}, {level = 7, move = "CONFUSION"}, {level = 9, move = "DETECT"}, {level = 12, move = "ENDURE"}, {level = 20, move = "HIDDEN_POWER"}, {level = 25, move = "MIND_READER"}, {level = 31, move = "PSYCH_UP"}, {level = 39, move = "REVERSAL"}, {level = 41, move = "RECOVER"}, {level = 44, move = "COUNTER"}},
    tmhm = {"THUNDERPUNCH", "ROCK_SMASH", "LOW_KICK", "FIRE_PUNCH", "SUNNY_DAY", "SHADOW_BALL", "ICE_PUNCH", "STRENGTH", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PAIN_SPLIT", "PROTECT", "PSYCH_UP", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "DREAM_EATER", "PSYCHIC_M", "LIGHT_SCREEN", "REFLECT", "REST", "ROCK_SLIDE", "RAIN_DANCE", "ENDURE", "SWIFT"},
    eggMoves = {"FIRE_PUNCH", "THUNDERPUNCH", "ICE_PUNCH", "FORESIGHT", "BATON_PASS", "DYNAMICPUNCH"},
    evolutions = {{method = "EVOLVE_LEVEL", into = "MEDICHAM", level = 37}},
    items = {},
    cryBase = "MACHOP",
    palette = {normal = {{206, 206, 214}, {99, 140, 214}}, shiny = {{222, 181, 222}, {214, 25, 33}}},
    dexEntry = {kind = "MEDITATE", heightFt = 2, heightIn = 0, weightLbs = 24.7, text = "It eats just one<NEXT>berry a day. By<NEXT>enduring hunger,", text2 = "its spirit is<NEXT>tempered and made<NEXT>sharper."},
    entry_key = "pokemon:meditite:default:art:default",
    source = "official-stats",
  }
}
