-- Source: official-stats
-- Dropped level moves absent from Crystal moveOrder: WATERPULSE, AQUATAIL, MUDDYWATER
-- Dropped tmhm moves absent from Crystal moveOrder: BOUNCE, EARTHPOWER, BULLDOZE, HAIL, FACADE, ROUND, CONFIDE, ROCKTOMB, AQUATAIL, DIVE, SCALD, WATERPULSE, MUDSHOT, MUDDYWATER, DRAGONDANCE
-- Dropped egg moves absent from Crystal moveOrder: DRAGONDANCE, EARTHPOWER, MUDSHOT, MUDDYWATER
-- Same-move identifier normalization (accepted batch1 convention): MUDSLAP=MUD_SLAP, WATERGUN=WATER_GUN, FUTURESIGHT=FUTURE_SIGHT, ICEBEAM=ICE_BEAM, ICYWIND=ICY_WIND, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, RAINDANCE=RAIN_DANCE, HYDROPUMP=HYDRO_PUMP, TAKEDOWN=TAKE_DOWN
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_FISH; cryBase proposal: WOOPER; developer veto applies.
-- Dex source game: firered.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "BARBOACH",
    slug = "barboach",
    name = "BARBOACH",
    dex = 339,
    types = {"WATER", "GROUND"},
    baseStats = {hp = 50, attack = 48, defense = 43, specialAttack = 46, specialDefense = 41, speed = 60},
    catchRate = 190,
    baseExp = 58,
    growthRate = "GROWTH_MEDIUM_FAST",
    genderRatio = 127,
    eggGroups = {"EGG_WATER_2", "EGG_WATER_2"},
    eggGroupsRaw = 204,
    eggSteps = 20,
    levelMoves = {{level = 1, move = "MUD_SLAP"}, {level = 1, move = "WATER_GUN"}, {level = 6, move = "REST"}, {level = 6, move = "SNORE"}, {level = 18, move = "AMNESIA"}, {level = 36, move = "EARTHQUAKE"}, {level = 42, move = "FUTURE_SIGHT"}, {level = 48, move = "FISSURE"}},
    tmhm = {"EARTHQUAKE", "BLIZZARD", "ICE_BEAM", "ICY_WIND", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "REST", "SANDSTORM", "SURF", "WATERFALL", "RAIN_DANCE", "ENDURE", "WHIRLPOOL", "HYDRO_PUMP", "AMNESIA", "FUTURE_SIGHT"},
    eggMoves = {"THRASH", "WHIRLPOOL", "SPARK", "HYDRO_PUMP", "FLAIL", "TAKE_DOWN"},
    evolutions = {{method = "EVOLVE_LEVEL", into = "WHISCASH", level = 30}},
    items = {},
    cryBase = "WOOPER",
    palette = {normal = {{181, 181, 189}, {82, 90, 255}}, shiny = {{197, 214, 214}, {222, 156, 0}}},
    dexEntry = {kind = "WHISKERS", heightFt = 1, heightIn = 4, weightLbs = 4.2, text = "It probes muddy<NEXT>riverbeds with its<NEXT>two long whiskers.", text2 = "A slimy film<NEXT>protects its body."},
    entry_key = "pokemon:barboach:default:art:default",
    source = "official-stats",
  }
}
