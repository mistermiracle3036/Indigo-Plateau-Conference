-- Source: official-stats
-- FEWER THAN FOUR distinct level moves after filtering: 3; left faithful, no padding
-- Dropped level moves absent from Crystal moveOrder: FAKEOUT
-- Dropped tmhm moves absent from Crystal moveOrder: PAYBACK, WILDCHARGE, SHOCKWAVE, CHARGEBEAM, GRASSKNOT, STOMPINGTANTRUM, GIGAIMPACT, LASTRESORT, HYPERVOICE, UPROAR, FACADE, COVET, ROUND, ECHOEDVOICE, CONFIDE, HELPINGHAND, LASERFOCUS, WORKUP, ZENHEADBUTT, CALMMIND, WATERPULSE, RETALIATE
-- Same-move identifier normalization (accepted batch1 convention): THUNDERWAVE=THUNDER_WAVE, ROCKSMASH=ROCK_SMASH, SUNNYDAY=SUNNY_DAY, SHADOWBALL=SHADOW_BALL, ICEBEAM=ICE_BEAM, ICYWIND=ICY_WIND, HYPERBEAM=HYPER_BEAM, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, HEALBELL=HEAL_BELL, PSYCHUP=PSYCH_UP, SLEEPTALK=SLEEP_TALK, DREAMEATER=DREAM_EATER, IRONTAIL=IRON_TAIL, RAINDANCE=RAIN_DANCE
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_FOX; cryBase proposal: MEOWTH; developer veto applies.
-- Dex source game: black.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "DELCATTY",
    slug = "delcatty",
    name = "DELCATTY",
    dex = 301,
    types = {"NORMAL"},
    baseStats = {hp = 70, attack = 65, defense = 65, specialAttack = 55, specialDefense = 55, speed = 90},
    catchRate = 60,
    baseExp = 140,
    growthRate = "GROWTH_FAST",
    genderRatio = 191,
    eggGroups = {"EGG_GROUND", "EGG_FAIRY"},
    eggGroupsRaw = 86,
    eggSteps = 15,
    levelMoves = {{level = 1, move = "SING"}, {level = 1, move = "ATTRACT"}, {level = 1, move = "DOUBLESLAP"}},
    tmhm = {"THUNDER", "THUNDERBOLT", "THUNDER_WAVE", "ROCK_SMASH", "SUNNY_DAY", "SHADOW_BALL", "SOLARBEAM", "BLIZZARD", "ICE_BEAM", "ICY_WIND", "HYPER_BEAM", "STRENGTH", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "HEAL_BELL", "PROTECT", "PSYCH_UP", "SAFEGUARD", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "DREAM_EATER", "REST", "IRON_TAIL", "RAIN_DANCE", "ENDURE", "SWIFT", "DIG"},
    eggMoves = {},
    evolutions = {},
    items = {},
    cryBase = "MEOWTH",
    palette = {normal = {{255, 206, 82}, {189, 66, 132}}, shiny = {{255, 239, 82}, {239, 49, 25}}},
    dexEntry = {kind = "PRIM", heightFt = 3, heightIn = 7, weightLbs = 71.9, text = "It is highly<NEXT>popular among<NEXT>female Trainers", text2 = "for its sublime<NEXT>fur. It does not<NEXT>keep a nest."},
    entry_key = "pokemon:delcatty:default:art:default",
    source = "official-stats",
  }
}
