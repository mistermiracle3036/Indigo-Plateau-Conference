-- Source: official-stats
-- PBS WildItemUncommon=MENTALHERB omitted: no corresponding Gen2 row slot
-- Dropped level moves absent from Crystal moveOrder: TEETERDANCE, FAKEOUT, KNOCKOFF, ASTONISH, NATUREPOWER, ZENHEADBUTT, ENERGYBALL
-- Dropped tmhm moves absent from Crystal moveOrder: KNOCKOFF, FLING, BRICKBREAK, DRAINPUNCH, POWERUPPUNCH, ENERGYBALL, SEEDBOMB, GRASSKNOT, HAIL, HYPERVOICE, UPROAR, FACADE, ROUND, ECHOEDVOICE, CONFIDE, NATUREPOWER, ZENHEADBUTT, DIVE, SCALD, WATERPULSE, GRASSYGLIDE, BULLETSEED, MUDSHOT, MUDDYWATER
-- Same-move identifier normalization (accepted batch1 convention): WATERGUN=WATER_GUN, MEGADRAIN=MEGA_DRAIN, FURYSWIPES=FURY_SWIPES, GIGADRAIN=GIGA_DRAIN, RAINDANCE=RAIN_DANCE, HYDROPUMP=HYDRO_PUMP, ROCKSMASH=ROCK_SMASH, FIREPUNCH=FIRE_PUNCH, SUNNYDAY=SUNNY_DAY, ICEBEAM=ICE_BEAM, ICEPUNCH=ICE_PUNCH, ICYWIND=ICY_WIND, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, SWORDSDANCE=SWORDS_DANCE, MEGAKICK=MEGA_KICK, BODYSLAM=BODY_SLAM, MEGAPUNCH=MEGA_PUNCH
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_ODDISH; cryBase proposal: POLIWAG; developer veto applies.
-- Dex source game: heartgold.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "LOMBRE",
    slug = "lombre",
    name = "LOMBRE",
    dex = 271,
    types = {"WATER", "GRASS"},
    baseStats = {hp = 60, attack = 50, defense = 50, specialAttack = 60, specialDefense = 70, speed = 50},
    catchRate = 120,
    baseExp = 119,
    growthRate = "GROWTH_MEDIUM_SLOW",
    genderRatio = 127,
    eggGroups = {"EGG_WATER_1", "EGG_PLANT"},
    eggGroupsRaw = 39,
    eggSteps = 15,
    levelMoves = {{level = 1, move = "FLAIL"}, {level = 1, move = "GROWL"}, {level = 1, move = "ABSORB"}, {level = 1, move = "WATER_GUN"}, {level = 9, move = "MIST"}, {level = 12, move = "MEGA_DRAIN"}, {level = 18, move = "FURY_SWIPES"}, {level = 24, move = "BUBBLEBEAM"}, {level = 36, move = "GIGA_DRAIN"}, {level = 43, move = "RAIN_DANCE"}, {level = 64, move = "HYDRO_PUMP"}},
    tmhm = {"THIEF", "THUNDERPUNCH", "ROCK_SMASH", "FIRE_PUNCH", "SUNNY_DAY", "SOLARBEAM", "GIGA_DRAIN", "SYNTHESIS", "BLIZZARD", "ICE_BEAM", "ICE_PUNCH", "ICY_WIND", "STRENGTH", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "SWORDS_DANCE", "TOXIC", "REST", "SURF", "WATERFALL", "RAIN_DANCE", "ENDURE", "MEGA_KICK", "BODY_SLAM", "MEGA_PUNCH", "WHIRLPOOL", "HYDRO_PUMP", "ENCORE"},
    eggMoves = {},
    evolutions = {{method = "EVOLVE_ITEM", into = "LUDICOLO", item = "WATER_STONE"}},
    items = {},
    cryBase = "POLIWAG",
    palette = {normal = {{181, 239, 189}, {41, 165, 8}}, shiny = {{181, 230, 107}, {16, 107, 90}}},
    dexEntry = {kind = "JOLLY", heightFt = 3, heightIn = 11, weightLbs = 71.7, text = "It is nocturnal<NEXT>and becomes active<NEXT>at nightfall. It", text2 = "feeds on aquatic<NEXT>mosses that grow<NEXT>in the riverbed."},
    entry_key = "pokemon:lombre:default:art:default",
    source = "official-stats",
  }
}
