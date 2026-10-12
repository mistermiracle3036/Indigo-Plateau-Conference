-- Source: official-stats
-- PBS WildItemUncommon=MENTALHERB omitted: no corresponding Gen2 row slot
-- Dropped level moves absent from Crystal moveOrder: ASTONISH, NATUREPOWER, ZENHEADBUTT, ENERGYBALL
-- Dropped tmhm moves absent from Crystal moveOrder: ENERGYBALL, SEEDBOMB, GRASSKNOT, HAIL, UPROAR, FACADE, ROUND, ECHOEDVOICE, CONFIDE, NATUREPOWER, ZENHEADBUTT, SCALD, WATERPULSE, GRASSYGLIDE, BULLETSEED
-- Dropped egg moves absent from Crystal moveOrder: TICKLE, TEETERDANCE
-- Same-move identifier normalization (accepted batch1 convention): WATERGUN=WATER_GUN, MEGADRAIN=MEGA_DRAIN, GIGADRAIN=GIGA_DRAIN, RAINDANCE=RAIN_DANCE, SUNNYDAY=SUNNY_DAY, ICEBEAM=ICE_BEAM, ICYWIND=ICY_WIND, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, SWORDSDANCE=SWORDS_DANCE, BODYSLAM=BODY_SLAM, RAZORLEAF=RAZOR_LEAF, SWEETSCENT=SWEET_SCENT, LEECHSEED=LEECH_SEED
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_ODDISH; cryBase proposal: POLIWAG; developer veto applies.
-- Dex source game: black.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "LOTAD",
    slug = "lotad",
    name = "LOTAD",
    dex = 270,
    types = {"WATER", "GRASS"},
    baseStats = {hp = 40, attack = 30, defense = 30, specialAttack = 40, specialDefense = 50, speed = 30},
    catchRate = 255,
    baseExp = 44,
    growthRate = "GROWTH_MEDIUM_SLOW",
    genderRatio = 127,
    eggGroups = {"EGG_WATER_1", "EGG_PLANT"},
    eggGroupsRaw = 39,
    eggSteps = 15,
    levelMoves = {{level = 1, move = "GROWL"}, {level = 3, move = "ABSORB"}, {level = 6, move = "WATER_GUN"}, {level = 9, move = "MIST"}, {level = 12, move = "MEGA_DRAIN"}, {level = 16, move = "FLAIL"}, {level = 20, move = "BUBBLEBEAM"}, {level = 28, move = "GIGA_DRAIN"}, {level = 33, move = "RAIN_DANCE"}},
    tmhm = {"THIEF", "SUNNY_DAY", "SOLARBEAM", "GIGA_DRAIN", "SYNTHESIS", "BLIZZARD", "ICE_BEAM", "ICY_WIND", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "SWORDS_DANCE", "TOXIC", "REST", "SURF", "RAIN_DANCE", "ENDURE", "BODY_SLAM", "WHIRLPOOL"},
    eggMoves = {"SYNTHESIS", "RAZOR_LEAF", "SWEET_SCENT", "LEECH_SEED", "FLAIL", "WATER_GUN", "COUNTER", "GIGA_DRAIN"},
    evolutions = {{method = "EVOLVE_LEVEL", into = "LOMBRE", level = 14}},
    items = {},
    cryBase = "POLIWAG",
    palette = {normal = {{58, 165, 49}, {66, 90, 132}}, shiny = {{49, 173, 123}, {123, 33, 82}}},
    dexEntry = {kind = "WATER WEED", heightFt = 1, heightIn = 8, weightLbs = 5.7, text = "It looks like an<NEXT>aquatic plant and<NEXT>serves as a ferry", text2 = "to Pokémon that<NEXT>can't swim."},
    entry_key = "pokemon:lotad:default:art:default",
    source = "official-stats",
  }
}
