-- Source: official-stats
-- PBS evolution level 0 for CONFUSION -> level 1 (Gen2 schema minimum)
-- PBS evolution level 0 for METALCLAW -> level 1 (Gen2 schema minimum)
-- PBS WildItemUncommon=METALCOAT omitted: no corresponding Gen2 row slot
-- Duplicate level 1 CONFUSION entry removed after minimum-level normalization; distinct learned levels retained
-- Duplicate level 1 METAL_CLAW entry removed after minimum-level normalization; distinct learned levels retained
-- Dropped level moves absent from Crystal moveOrder: BULLETPUNCH, ZENHEADBUTT, MAGNETRISE, FLASHCANNON, METEORMASH, IRONDEFENSE
-- Dropped tmhm moves absent from Crystal moveOrder: SIGNALBEAM, MAGNETRISE, BRICKBREAK, POWERUPPUNCH, AERIALACE, GRASSKNOT, BULLDOZE, FACADE, ROUND, CONFIDE, PSYSHOCK, ZENHEADBUTT, ALLYSWITCH, GRAVITY, TELEKINESIS, TRICK, ROCKTOMB, ROCKPOLISH, STEALTHROCK, FLASHCANNON, IRONHEAD, GYROBALL, IRONDEFENSE, STEELBEAM, STEELROLLER, EXPANDINGFORCE, PSYCHOCUT, METEORBEAM, COSMICPOWER
-- Same-move identifier normalization (accepted batch1 convention): METALCLAW=METAL_CLAW, TAKEDOWN=TAKE_DOWN, PSYCHIC=PSYCHIC_M, SCARYFACE=SCARY_FACE, HYPERBEAM=HYPER_BEAM, ROCKSMASH=ROCK_SMASH, SUNNYDAY=SUNNY_DAY, SHADOWBALL=SHADOW_BALL, ICEPUNCH=ICE_PUNCH, ICYWIND=ICY_WIND, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, PSYCHUP=PSYCH_UP, SLEEPTALK=SLEEP_TALK, SLUDGEBOMB=SLUDGE_BOMB, LIGHTSCREEN=LIGHT_SCREEN, ROCKSLIDE=ROCK_SLIDE, RAINDANCE=RAIN_DANCE, BODYSLAM=BODY_SLAM
-- Art credit (catalog verbatim): RainbowDevs/Prism Team
-- Shared icon proposal: ICON_GEODUDE; cryBase proposal: MAGNEMITE; developer veto applies.
-- Dex source game: moon.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "METANG",
    slug = "metang",
    name = "METANG",
    dex = 375,
    types = {"STEEL", "PSYCHIC_TYPE"},
    baseStats = {hp = 60, attack = 75, defense = 100, specialAttack = 55, specialDefense = 80, speed = 50},
    catchRate = 3,
    baseExp = 147,
    growthRate = "GROWTH_SLOW",
    genderRatio = 255,
    eggGroups = {"EGG_MINERAL", "EGG_MINERAL"},
    eggGroupsRaw = 170,
    eggSteps = 40,
    levelMoves = {{level = 1, move = "CONFUSION"}, {level = 1, move = "METAL_CLAW"}, {level = 1, move = "TACKLE"}, {level = 26, move = "TAKE_DOWN"}, {level = 34, move = "PSYCHIC_M"}, {level = 42, move = "SCARY_FACE"}, {level = 66, move = "AGILITY"}, {level = 74, move = "HYPER_BEAM"}},
    tmhm = {"THUNDERPUNCH", "ROCK_SMASH", "SUNNY_DAY", "SHADOW_BALL", "EARTHQUAKE", "ICE_PUNCH", "ICY_WIND", "EXPLOSION", "HYPER_BEAM", "STRENGTH", "HIDDEN_POWER", "CUT", "SNORE", "FRUSTRATION", "RETURN", "DOUBLE_TEAM", "PROTECT", "PSYCH_UP", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "SLUDGE_BOMB", "TOXIC", "PSYCHIC_M", "LIGHT_SCREEN", "REFLECT", "REST", "ROCK_SLIDE", "SANDSTORM", "RAIN_DANCE", "ENDURE", "BODY_SLAM", "SELFDESTRUCT", "SWIFT", "SCARY_FACE", "AGILITY"},
    eggMoves = {},
    evolutions = {{method = "EVOLVE_LEVEL", into = "METAGROSS", level = 45}},
    items = {},
    cryBase = "MAGNEMITE",
    palette = {normal = {{96, 128, 208}, {0, 64, 168}}, shiny = {{136, 136, 144}, {104, 88, 120}}},
    dexEntry = {kind = "IRON CLAW", heightFt = 3, heightIn = 11, weightLbs = 446.4, text = "It adores magnetic<NEXT>minerals, so it<NEXT>pursues Nosepass", text2 = "at speeds<NEXT>exceeding 60 mph."},
    entry_key = "pokemon:metang:default:art:default",
    source = "official-stats",
  }
}
