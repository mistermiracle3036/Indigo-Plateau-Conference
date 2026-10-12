-- Source: official-stats
-- Dropped level moves absent from Crystal moveOrder: FAKEOUT, DISARMINGVOICE, COPYCAT, FEINTATTACK, WAKEUPSLAP, ASSIST, COVET, CAPTIVATE, PLAYROUGH
-- Dropped tmhm moves absent from Crystal moveOrder: PAYBACK, WILDCHARGE, SHOCKWAVE, CHARGEBEAM, GRASSKNOT, LASTRESORT, HYPERVOICE, UPROAR, FACADE, COVET, ROUND, ECHOEDVOICE, CONFIDE, HELPINGHAND, WORKUP, ZENHEADBUTT, CALMMIND, WATERPULSE, RETALIATE
-- Dropped egg moves absent from Crystal moveOrder: HELPINGHAND, UPROAR, FAKETEARS, WISH, TICKLE, LASTRESORT, FAKEOUT, ZENHEADBUTT, SUCKERPUNCH, MUDBOMB, SIMPLEBEAM, CAPTIVATE, COSMICPOWER
-- Same-move identifier normalization (accepted batch1 convention): TAILWHIP=TAIL_WHIP, HEALBELL=HEAL_BELL, DOUBLEEDGE=DOUBLE_EDGE, THUNDERWAVE=THUNDER_WAVE, SUNNYDAY=SUNNY_DAY, SHADOWBALL=SHADOW_BALL, ICEBEAM=ICE_BEAM, ICYWIND=ICY_WIND, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, PSYCHUP=PSYCH_UP, SLEEPTALK=SLEEP_TALK, DREAMEATER=DREAM_EATER, IRONTAIL=IRON_TAIL, RAINDANCE=RAIN_DANCE, BATONPASS=BATON_PASS
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_FOX; cryBase proposal: MEOWTH; developer veto applies.
-- Dex source game: black-2.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "SKITTY",
    slug = "skitty",
    name = "SKITTY",
    dex = 300,
    types = {"NORMAL"},
    baseStats = {hp = 50, attack = 45, defense = 45, specialAttack = 35, specialDefense = 35, speed = 50},
    catchRate = 255,
    baseExp = 52,
    growthRate = "GROWTH_FAST",
    genderRatio = 191,
    eggGroups = {"EGG_GROUND", "EGG_FAIRY"},
    eggGroupsRaw = 86,
    eggSteps = 15,
    levelMoves = {{level = 1, move = "GROWL"}, {level = 1, move = "TAIL_WHIP"}, {level = 1, move = "TACKLE"}, {level = 4, move = "FORESIGHT"}, {level = 7, move = "SING"}, {level = 10, move = "ATTRACT"}, {level = 16, move = "DOUBLESLAP"}, {level = 25, move = "CHARM"}, {level = 37, move = "HEAL_BELL"}, {level = 40, move = "DOUBLE_EDGE"}},
    tmhm = {"THUNDER", "THUNDERBOLT", "THUNDER_WAVE", "SUNNY_DAY", "SHADOW_BALL", "SOLARBEAM", "BLIZZARD", "ICE_BEAM", "ICY_WIND", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "HEAL_BELL", "PROTECT", "PSYCH_UP", "SAFEGUARD", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "DREAM_EATER", "REST", "IRON_TAIL", "RAIN_DANCE", "ENDURE", "SWIFT", "DIG"},
    eggMoves = {"BATON_PASS"},
    evolutions = {{method = "EVOLVE_ITEM", into = "DELCATTY", item = "MOON_STONE"}},
    items = {},
    cryBase = "MEOWTH",
    palette = {normal = {{247, 222, 115}, {239, 99, 99}}, shiny = {{255, 247, 115}, {206, 41, 41}}},
    dexEntry = {kind = "KITTEN", heightFt = 2, heightIn = 0, weightLbs = 24.3, text = "It shows its cute<NEXT>side by chasing<NEXT>its own tail until", text2 = "it gets dizzy."},
    entry_key = "pokemon:skitty:default:art:default",
    source = "official-stats",
  }
}
