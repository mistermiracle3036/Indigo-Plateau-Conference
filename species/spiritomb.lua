-- Source: official-stats
-- Dropped level moves absent from Crystal moveOrder: SHADOWSNEAK, PAYBACK, NASTYPLOT, HEX, MEMENTO, SUCKERPUNCH, DARKPULSE
-- Dropped tmhm moves absent from Crystal moveOrder: INFESTATION, FOULPLAY, DARKPULSE, SNARL, PAYBACK, EMBARGO, QUASH, SNATCH, TAUNT, TORMENT, SHOCKWAVE, WILLOWISP, GIGAIMPACT, UPROAR, FACADE, ROUND, CONFIDE, ALLYSWITCH, CALMMIND, TELEKINESIS, TRICK, WONDERROOM, ROCKTOMB, WATERPULSE, NASTYPLOT, RETALIATE, IMPRISON, LASHOUT, BURNINGJEALOUSY, HEX, POLTERGEIST, PHANTOMFORCE
-- Dropped egg moves absent from Crystal moveOrder: GRUDGE
-- Same-move identifier normalization (accepted batch1 convention): NIGHTSHADE=NIGHT_SHADE, CONFUSERAY=CONFUSE_RAY, SHADOWBALL=SHADOW_BALL, DREAMEATER=DREAM_EATER, SUNNYDAY=SUNNY_DAY, ICYWIND=ICY_WIND, HYPERBEAM=HYPER_BEAM, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, PAINSPLIT=PAIN_SPLIT, PSYCHUP=PSYCH_UP, SLEEPTALK=SLEEP_TALK, PSYCHIC=PSYCHIC_M, RAINDANCE=RAIN_DANCE, DESTINYBOND=DESTINY_BOND
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_GHOST; cryBase proposal: GASTLY; developer veto applies.
-- Dex source game: alpha-sapphire.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "SPIRITOMB",
    slug = "spiritomb",
    name = "SPIRITOMB",
    dex = 442,
    types = {"GHOST", "DARK"},
    baseStats = {hp = 50, attack = 92, defense = 108, specialAttack = 92, specialDefense = 108, speed = 35},
    catchRate = 100,
    baseExp = 170,
    growthRate = "GROWTH_MEDIUM_FAST",
    genderRatio = 127,
    eggGroups = {"EGG_INDETERMINATE", "EGG_INDETERMINATE"},
    eggGroupsRaw = 187,
    eggSteps = 30,
    levelMoves = {{level = 1, move = "NIGHT_SHADE"}, {level = 1, move = "CONFUSE_RAY"}, {level = 10, move = "SPITE"}, {level = 40, move = "CURSE"}, {level = 45, move = "SHADOW_BALL"}, {level = 55, move = "HYPNOSIS"}, {level = 60, move = "DREAM_EATER"}},
    tmhm = {"THIEF", "SUNNY_DAY", "SHADOW_BALL", "SPITE", "ICY_WIND", "HYPER_BEAM", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PAIN_SPLIT", "PROTECT", "PSYCH_UP", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "DREAM_EATER", "PSYCHIC_M", "REST", "RAIN_DANCE", "ENDURE"},
    eggMoves = {"DESTINY_BOND", "DISABLE", "PAIN_SPLIT", "SMOKESCREEN"},
    evolutions = {},
    items = {},
    cryBase = "GASTLY",
    palette = {normal = {{74, 189, 16}, {189, 58, 206}}, shiny = {{222, 58, 197}, {58, 181, 206}}},
    dexEntry = {kind = "FORBIDDEN", heightFt = 3, heightIn = 3, weightLbs = 238.1, text = "It was bound to a<NEXT>fissure in an odd<NEXT>keystone as", text2 = "punishment for<NEXT>misdeeds 500 years<NEXT>ago."},
    entry_key = "pokemon:spiritomb:default:art:default",
    source = "official-stats",
  }
}
