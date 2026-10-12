-- Source: official-stats
-- Dropped level moves absent from Crystal moveOrder: ZENHEADBUTT, FEINT, FORCEPALM, CALMMIND, HIGHJUMPKICK, ACUPRESSURE, POWERTRICK
-- Dropped tmhm moves absent from Crystal moveOrder: SIGNALBEAM, FLING, FOCUSPUNCH, FOCUSBLAST, BRICKBREAK, DRAINPUNCH, LOWSWEEP, POWERUPPUNCH, BULKUP, ENERGYBALL, GRASSKNOT, GIGAIMPACT, FACADE, ROUND, CONFIDE, HELPINGHAND, LASERFOCUS, RECYCLE, WORKUP, POISONJAB, PSYSHOCK, ZENHEADBUTT, CALMMIND, GRAVITY, MAGICCOAT, ROLEPLAY, TELEKINESIS, TRICK, ROCKTOMB, RETALIATE
-- Same-move identifier normalization (accepted batch1 convention): FIREPUNCH=FIRE_PUNCH, ICEPUNCH=ICE_PUNCH, HIDDENPOWER=HIDDEN_POWER, MINDREADER=MIND_READER, PSYCHUP=PSYCH_UP, ROCKSMASH=ROCK_SMASH, LOWKICK=LOW_KICK, SUNNYDAY=SUNNY_DAY, SHADOWBALL=SHADOW_BALL, HYPERBEAM=HYPER_BEAM, DOUBLETEAM=DOUBLE_TEAM, PAINSPLIT=PAIN_SPLIT, SLEEPTALK=SLEEP_TALK, DREAMEATER=DREAM_EATER, PSYCHIC=PSYCHIC_M, LIGHTSCREEN=LIGHT_SCREEN, ROCKSLIDE=ROCK_SLIDE, RAINDANCE=RAIN_DANCE
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_HUMANSHAPE; cryBase proposal: MACHOP; developer veto applies.
-- Dex source game: diamond.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "MEDICHAM",
    slug = "medicham",
    name = "MEDICHAM",
    dex = 308,
    types = {"FIGHTING", "PSYCHIC_TYPE"},
    baseStats = {hp = 60, attack = 60, defense = 75, specialAttack = 60, specialDefense = 75, speed = 80},
    catchRate = 90,
    baseExp = 144,
    growthRate = "GROWTH_MEDIUM_FAST",
    genderRatio = 127,
    eggGroups = {"EGG_HUMANSHAPE", "EGG_HUMANSHAPE"},
    eggGroupsRaw = 136,
    eggSteps = 20,
    levelMoves = {{level = 1, move = "FIRE_PUNCH"}, {level = 1, move = "THUNDERPUNCH"}, {level = 1, move = "ICE_PUNCH"}, {level = 1, move = "BIDE"}, {level = 1, move = "MEDITATE"}, {level = 1, move = "CONFUSION"}, {level = 1, move = "DETECT"}, {level = 4, move = "MEDITATE"}, {level = 7, move = "CONFUSION"}, {level = 9, move = "DETECT"}, {level = 12, move = "ENDURE"}, {level = 20, move = "HIDDEN_POWER"}, {level = 25, move = "MIND_READER"}, {level = 31, move = "PSYCH_UP"}, {level = 42, move = "REVERSAL"}, {level = 47, move = "RECOVER"}, {level = 53, move = "COUNTER"}},
    tmhm = {"THUNDERPUNCH", "ROCK_SMASH", "LOW_KICK", "FIRE_PUNCH", "SUNNY_DAY", "SHADOW_BALL", "ICE_PUNCH", "HYPER_BEAM", "STRENGTH", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PAIN_SPLIT", "PROTECT", "PSYCH_UP", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "DREAM_EATER", "PSYCHIC_M", "LIGHT_SCREEN", "REFLECT", "REST", "ROCK_SLIDE", "RAIN_DANCE", "ENDURE", "SWIFT"},
    eggMoves = {},
    evolutions = {},
    items = {},
    cryBase = "MACHOP",
    palette = {normal = {{206, 189, 148}, {230, 90, 107}}, shiny = {{214, 173, 99}, {58, 115, 206}}},
    dexEntry = {kind = "MEDITATE", heightFt = 4, heightIn = 3, weightLbs = 69.4, text = "Through yoga<NEXT>training, it has<NEXT>honed its sixth", text2 = "sense. Its<NEXT>movements are<NEXT>elegant."},
    entry_key = "pokemon:medicham:default:art:default",
    source = "official-stats",
  }
}
