-- Source: official-stats
-- Dropped level moves absent from Crystal moveOrder: SANDTOMB, BULLDOZE, DRAGONCLAW, DRAGONRUSH
-- Dropped tmhm moves absent from Crystal moveOrder: DRACOMETEOR, DRAGONPULSE, DRAGONCLAW, AERIALACE, SHADOWCLAW, EARTHPOWER, BULLDOZE, FACADE, ROUND, CONFIDE, STONEEDGE, ROCKTOMB, STEALTHROCK, IRONHEAD, MUDSHOT, SCORCHINGSANDS, SCALESHOT, SANDTOMB
-- Same-move identifier normalization (accepted batch1 convention): SANDATTACK=SAND_ATTACK, TAKEDOWN=TAKE_DOWN, ROCKSMASH=ROCK_SMASH, FIREBLAST=FIRE_BLAST, SUNNYDAY=SUNNY_DAY, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, ROCKSLIDE=ROCK_SLIDE, IRONTAIL=IRON_TAIL, RAINDANCE=RAIN_DANCE, BODYSLAM=BODY_SLAM, SCARYFACE=SCARY_FACE, DOUBLEEDGE=DOUBLE_EDGE, METALCLAW=METAL_CLAW
-- Art credit (catalog verbatim): retro_pokesprites (front), koolboyman (back)
-- Shared icon proposal: ICON_MONSTER; cryBase proposal: DRATINI; developer veto applies.
-- Dex source game: pearl.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "GIBLE",
    slug = "gible",
    name = "GIBLE",
    dex = 443,
    types = {"DRAGON", "GROUND"},
    baseStats = {hp = 58, attack = 70, defense = 45, specialAttack = 40, specialDefense = 45, speed = 42},
    catchRate = 45,
    baseExp = 60,
    growthRate = "GROWTH_SLOW",
    genderRatio = 127,
    eggGroups = {"EGG_MONSTER", "EGG_DRAGON"},
    eggGroupsRaw = 30,
    eggSteps = 40,
    levelMoves = {{level = 1, move = "TACKLE"}, {level = 6, move = "SAND_ATTACK"}, {level = 12, move = "DRAGONBREATH"}, {level = 24, move = "BITE"}, {level = 30, move = "SLASH"}, {level = 42, move = "DIG"}, {level = 48, move = "SANDSTORM"}, {level = 54, move = "TAKE_DOWN"}},
    tmhm = {"OUTRAGE", "ROCK_SMASH", "FIRE_BLAST", "FLAMETHROWER", "SUNNY_DAY", "EARTHQUAKE", "STRENGTH", "HIDDEN_POWER", "CUT", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "ROAR", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "REST", "ROCK_SLIDE", "SANDSTORM", "IRON_TAIL", "RAIN_DANCE", "ENDURE", "BODY_SLAM", "SWIFT", "SCARY_FACE", "DIG"},
    eggMoves = {"DOUBLE_EDGE", "METAL_CLAW", "THRASH", "TWISTER"},
    evolutions = {{method = "EVOLVE_LEVEL", into = "GABITE", level = 24}},
    items = {},
    cryBase = "DRATINI",
    palette = {normal = {{247, 66, 49}, {68, 135, 159}}, shiny = {{248, 184, 0}, {0, 128, 200}}},
    dexEntry = {kind = "LAND SHARK", heightFt = 2, heightIn = 4, weightLbs = 45.2, text = "It once lived in<NEXT>the tropics. To<NEXT>avoid the cold, it", text2 = "lives in caves<NEXT>warmed by<NEXT>geothermal heat."},
    entry_key = "pokemon:gible:default:art:default",
    source = "official-stats",
  }
}
