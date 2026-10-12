-- Source: official-stats
-- Erratic growth -> GROWTH_FAST, approved batch1 substitute (600,000 vs 800,000 total EXP at level 100)
-- Dropped level moves absent from Crystal moveOrder: WATERPULSE, WATERPULSE, DISARMINGVOICE, AQUARING, LIFEDEW, DRAGONTAIL, AQUATAIL, COIL
-- Dropped tmhm moves absent from Crystal moveOrder: BRUTALSWING, DRAGONPULSE, DRAGONTAIL, BULLDOZE, HAIL, GIGAIMPACT, FACADE, ROUND, CONFIDE, HELPINGHAND, LASERFOCUS, MAGICCOAT, IRONHEAD, AQUATAIL, DIVE, SCALD, WATERPULSE, MUDSHOT, MUDDYWATER, WEATHERBALL, BREAKINGSWIPE, SCALESHOT, IMPRISON, SKITTERSMACK, DRAGONDANCE, FLIPTURN, BRINE, AVALANCHE, TRIPLEAXEL
-- Same-move identifier normalization (accepted batch1 convention): WATERGUN=WATER_GUN, RAINDANCE=RAIN_DANCE, HYDROPUMP=HYDRO_PUMP, ICEBEAM=ICE_BEAM, ICYWIND=ICY_WIND, HYPERBEAM=HYPER_BEAM, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, PSYCHUP=PSYCH_UP, SLEEPTALK=SLEEP_TALK, LIGHTSCREEN=LIGHT_SCREEN, IRONTAIL=IRON_TAIL, BODYSLAM=BODY_SLAM
-- Art credit (catalog verbatim): RainbowDevs/Prism Team
-- Shared icon proposal: ICON_SERPENT; cryBase proposal: MAGIKARP; developer veto applies.
-- Dex source game: pearl.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "MILOTIC",
    slug = "milotic",
    name = "MILOTIC",
    dex = 350,
    types = {"WATER"},
    baseStats = {hp = 95, attack = 60, defense = 79, specialAttack = 100, specialDefense = 125, speed = 81},
    catchRate = 60,
    baseExp = 189,
    growthRate = "GROWTH_FAST",
    genderRatio = 127,
    eggGroups = {"EGG_WATER_1", "EGG_DRAGON"},
    eggGroupsRaw = 46,
    eggSteps = 20,
    levelMoves = {{level = 1, move = "FLAIL"}, {level = 1, move = "SPLASH"}, {level = 1, move = "TACKLE"}, {level = 1, move = "WRAP"}, {level = 1, move = "WATER_GUN"}, {level = 8, move = "TWISTER"}, {level = 16, move = "ATTRACT"}, {level = 28, move = "RECOVER"}, {level = 36, move = "SAFEGUARD"}, {level = 40, move = "SURF"}, {level = 44, move = "RAIN_DANCE"}, {level = 52, move = "HYDRO_PUMP"}},
    tmhm = {"BLIZZARD", "ICE_BEAM", "ICY_WIND", "HYPER_BEAM", "HIDDEN_POWER", "SNORE", "BIND", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "PSYCH_UP", "SAFEGUARD", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "LIGHT_SCREEN", "REST", "IRON_TAIL", "SURF", "WATERFALL", "RAIN_DANCE", "ENDURE", "BODY_SLAM", "SWIFT", "WHIRLPOOL", "HYDRO_PUMP"},
    eggMoves = {},
    evolutions = {},
    items = {},
    cryBase = "MAGIKARP",
    palette = {normal = {{87, 121, 186}, {209, 79, 44}}, shiny = {{248, 216, 0}, {48, 136, 248}}},
    dexEntry = {kind = "TENDER", heightFt = 20, heightIn = 4, weightLbs = 357.1, text = "It is the world's<NEXT>most beautiful<NEXT>Pokémon. There are", text2 = "many works of art<NEXT>featuring MILOTIC."},
    entry_key = "pokemon:milotic:default:art:default",
    source = "official-stats",
  }
}
