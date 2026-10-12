-- Source: official-stats
-- PBS WildItemUncommon=MENTALHERB omitted: no corresponding Gen2 row slot
-- Dropped level moves absent from Crystal moveOrder: TEETERDANCE, FAKEOUT, KNOCKOFF, NATUREPOWER, ZENHEADBUTT, ENERGYBALL, ASTONISH
-- Dropped tmhm moves absent from Crystal moveOrder: KNOCKOFF, FLING, FOCUSPUNCH, FOCUSBLAST, BRICKBREAK, DRAINPUNCH, POWERUPPUNCH, ENERGYBALL, SEEDBOMB, GRASSKNOT, HAIL, GIGAIMPACT, HYPERVOICE, UPROAR, FACADE, ROUND, ECHOEDVOICE, CONFIDE, NATUREPOWER, ZENHEADBUTT, DIVE, SCALD, WATERPULSE, GRASSYGLIDE, LEAFSTORM, BULLETSEED, MUDSHOT, MUDDYWATER, WEATHERBALL
-- Same-move identifier normalization (accepted batch1 convention): MEGADRAIN=MEGA_DRAIN, FURYSWIPES=FURY_SWIPES, GIGADRAIN=GIGA_DRAIN, RAINDANCE=RAIN_DANCE, HYDROPUMP=HYDRO_PUMP, WATERGUN=WATER_GUN, ROCKSMASH=ROCK_SMASH, FIREPUNCH=FIRE_PUNCH, SUNNYDAY=SUNNY_DAY, ICEBEAM=ICE_BEAM, ICEPUNCH=ICE_PUNCH, ICYWIND=ICY_WIND, HYPERBEAM=HYPER_BEAM, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, SWORDSDANCE=SWORDS_DANCE, MEGAKICK=MEGA_KICK, BODYSLAM=BODY_SLAM, MEGAPUNCH=MEGA_PUNCH
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_ODDISH; cryBase proposal: POLIWAG; developer veto applies.
-- Dex source game: heartgold.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "LUDICOLO",
    slug = "ludicolo",
    name = "LUDICOLO",
    dex = 272,
    types = {"WATER", "GRASS"},
    baseStats = {hp = 80, attack = 70, defense = 70, specialAttack = 90, specialDefense = 100, speed = 70},
    catchRate = 45,
    baseExp = 216,
    growthRate = "GROWTH_MEDIUM_SLOW",
    genderRatio = 127,
    eggGroups = {"EGG_WATER_1", "EGG_PLANT"},
    eggGroupsRaw = 39,
    eggSteps = 15,
    levelMoves = {{level = 1, move = "FLAIL"}, {level = 1, move = "MIST"}, {level = 1, move = "MEGA_DRAIN"}, {level = 1, move = "FURY_SWIPES"}, {level = 1, move = "BUBBLEBEAM"}, {level = 1, move = "GIGA_DRAIN"}, {level = 1, move = "RAIN_DANCE"}, {level = 1, move = "HYDRO_PUMP"}, {level = 1, move = "GROWL"}, {level = 1, move = "ABSORB"}, {level = 1, move = "WATER_GUN"}},
    tmhm = {"THIEF", "THUNDERPUNCH", "ROCK_SMASH", "FIRE_PUNCH", "SUNNY_DAY", "SOLARBEAM", "GIGA_DRAIN", "SYNTHESIS", "BLIZZARD", "ICE_BEAM", "ICE_PUNCH", "ICY_WIND", "HYPER_BEAM", "STRENGTH", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "SWORDS_DANCE", "TOXIC", "REST", "SURF", "WATERFALL", "RAIN_DANCE", "ENDURE", "MEGA_KICK", "BODY_SLAM", "MEGA_PUNCH", "WHIRLPOOL", "HYDRO_PUMP", "METRONOME", "AMNESIA", "ENCORE"},
    eggMoves = {},
    evolutions = {},
    items = {},
    cryBase = "POLIWAG",
    palette = {normal = {{255, 197, 66}, {90, 189, 49}}, shiny = {{255, 173, 66}, {49, 189, 140}}},
    dexEntry = {kind = "CAREFREE", heightFt = 4, heightIn = 11, weightLbs = 121.3, text = "If it hears<NEXT>festive music, it<NEXT>begins moving in", text2 = "rhythm in order to<NEXT>amplify its power."},
    entry_key = "pokemon:ludicolo:default:art:default",
    source = "official-stats",
  }
}
