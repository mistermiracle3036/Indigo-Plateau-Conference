-- Source: official-stats
-- Erratic growth -> GROWTH_FAST, approved batch1 substitute (600,000 vs 800,000 total EXP at level 100)
-- EVOLUTION SUBSTITUTE: Feebas -> Milotic officially levels up with Beauty >=170 (Gen III-IV/ORAS) or trades holding Prism Scale (Gen V+); proposed EVOLVE_TRADE with DRAGON_SCALE preserves the official trade-with-held-scale trigger using a Gen2 evolution item; developer review
-- FEWER THAN FOUR distinct level moves after filtering: 3; left faithful, no padding
-- Dropped tmhm moves absent from Crystal moveOrder: DRAGONPULSE, HAIL, FACADE, ROUND, CONFIDE, DIVE, SCALD, WATERPULSE, MUDSHOT, MUDDYWATER, SCALESHOT, BRINE
-- Dropped egg moves absent from Crystal moveOrder: MUDSPORT, TICKLE, BRINE, DRAGONPULSE, CAPTIVATE
-- Same-move identifier normalization (accepted batch1 convention): ICEBEAM=ICE_BEAM, ICYWIND=ICY_WIND, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, LIGHTSCREEN=LIGHT_SCREEN, IRONTAIL=IRON_TAIL, RAINDANCE=RAIN_DANCE, MIRRORCOAT=MIRROR_COAT, CONFUSERAY=CONFUSE_RAY
-- Art credit (catalog verbatim): RainbowDevs/Prism Team
-- Shared icon proposal: ICON_FISH; cryBase proposal: MAGIKARP; developer veto applies.
-- Dex source game: heartgold.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "FEEBAS",
    slug = "feebas",
    name = "FEEBAS",
    dex = 349,
    types = {"WATER"},
    baseStats = {hp = 20, attack = 15, defense = 20, specialAttack = 10, specialDefense = 55, speed = 80},
    catchRate = 255,
    baseExp = 40,
    growthRate = "GROWTH_FAST",
    genderRatio = 127,
    eggGroups = {"EGG_WATER_1", "EGG_DRAGON"},
    eggGroupsRaw = 46,
    eggSteps = 20,
    levelMoves = {{level = 1, move = "SPLASH"}, {level = 15, move = "TACKLE"}, {level = 25, move = "FLAIL"}},
    tmhm = {"BLIZZARD", "ICE_BEAM", "ICY_WIND", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "LIGHT_SCREEN", "REST", "IRON_TAIL", "SURF", "WATERFALL", "RAIN_DANCE", "ENDURE", "SWIFT", "WHIRLPOOL"},
    eggMoves = {"MIRROR_COAT", "DRAGONBREATH", "HYPNOSIS", "CONFUSE_RAY", "MIST", "HAZE", "IRON_TAIL"},
    evolutions = {{method = "EVOLVE_TRADE", into = "MILOTIC", item = "DRAGON_SCALE"}},
    items = {},
    cryBase = "MAGIKARP",
    palette = {normal = {{96, 152, 248}, {176, 144, 64}}, shiny = {{120, 136, 192}, {136, 56, 248}}},
    dexEntry = {kind = "FISH", heightFt = 2, heightIn = 0, weightLbs = 16.3, text = "It is the<NEXT>shabbiest Pokémon<NEXT>of all. It forms", text2 = "in schools and<NEXT>lives at the<NEXT>bottom of rivers."},
    entry_key = "pokemon:feebas:default:art:default",
    source = "official-stats",
  }
}
