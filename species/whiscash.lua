-- Source: official-stats
-- PBS evolution level 0 for THRASH -> level 1 (Gen2 schema minimum)
-- Duplicate level 1 THRASH entry removed after minimum-level normalization; distinct learned levels retained
-- Dropped level moves absent from Crystal moveOrder: BELCH, ZENHEADBUTT, TICKLE, WATERPULSE, AQUATAIL, MUDDYWATER
-- Dropped tmhm moves absent from Crystal moveOrder: BOUNCE, EARTHPOWER, STOMPINGTANTRUM, BULLDOZE, HAIL, GIGAIMPACT, UPROAR, FACADE, ROUND, CONFIDE, ZENHEADBUTT, STONEEDGE, ROCKTOMB, AQUATAIL, LIQUIDATION, DIVE, SCALD, WATERPULSE, MUDSHOT, MUDDYWATER, WEATHERBALL, SANDTOMB, DRAGONDANCE
-- Same-move identifier normalization (accepted batch1 convention): MUDSLAP=MUD_SLAP, WATERGUN=WATER_GUN, FUTURESIGHT=FUTURE_SIGHT, ROCKSMASH=ROCK_SMASH, ICEBEAM=ICE_BEAM, ICYWIND=ICY_WIND, HYPERBEAM=HYPER_BEAM, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, ROCKSLIDE=ROCK_SLIDE, RAINDANCE=RAIN_DANCE, HYDROPUMP=HYDRO_PUMP
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_FISH; cryBase proposal: WOOPER; developer veto applies.
-- Dex source game: moon.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "WHISCASH",
    slug = "whiscash",
    name = "WHISCASH",
    dex = 340,
    types = {"WATER", "GROUND"},
    baseStats = {hp = 110, attack = 78, defense = 73, specialAttack = 76, specialDefense = 71, speed = 60},
    catchRate = 75,
    baseExp = 164,
    growthRate = "GROWTH_MEDIUM_FAST",
    genderRatio = 127,
    eggGroups = {"EGG_WATER_2", "EGG_WATER_2"},
    eggGroupsRaw = 204,
    eggSteps = 20,
    levelMoves = {{level = 1, move = "THRASH"}, {level = 1, move = "MUD_SLAP"}, {level = 1, move = "WATER_GUN"}, {level = 1, move = "REST"}, {level = 1, move = "SNORE"}, {level = 18, move = "AMNESIA"}, {level = 40, move = "EARTHQUAKE"}, {level = 48, move = "FUTURE_SIGHT"}, {level = 56, move = "FISSURE"}},
    tmhm = {"ROCK_SMASH", "EARTHQUAKE", "BLIZZARD", "ICE_BEAM", "ICY_WIND", "HYPER_BEAM", "STRENGTH", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "REST", "ROCK_SLIDE", "SANDSTORM", "SURF", "WATERFALL", "RAIN_DANCE", "ENDURE", "WHIRLPOOL", "HYDRO_PUMP", "AMNESIA", "FUTURE_SIGHT"},
    eggMoves = {},
    evolutions = {},
    items = {},
    cryBase = "WOOPER",
    palette = {normal = {{255, 206, 25}, {49, 66, 181}}, shiny = {{247, 156, 25}, {99, 74, 156}}},
    dexEntry = {kind = "WHISKERS", heightFt = 2, heightIn = 11, weightLbs = 52.0, text = "Sighting Whiscash<NEXT>leaping from the<NEXT>water is believed", text2 = "to herald an<NEXT>earthquake."},
    entry_key = "pokemon:whiscash:default:art:default",
    source = "official-stats",
  }
}
