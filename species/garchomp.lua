-- Source: official-stats
-- PBS evolution level 0 for CRUNCH -> level 1 (Gen2 schema minimum)
-- baseExp 270 -> 255 (Gen2 byte limit)
-- Duplicate level 1 CRUNCH entry removed after minimum-level normalization; distinct learned levels retained
-- Dropped level moves absent from Crystal moveOrder: DUALCHOP, SANDTOMB, BULLDOZE, DRAGONCLAW, DRAGONRUSH
-- Dropped tmhm moves absent from Crystal moveOrder: BRUTALSWING, FLING, DRACOMETEOR, DRAGONPULSE, DRAGONCLAW, DRAGONTAIL, DUALCHOP, BRICKBREAK, AERIALACE, SHADOWCLAW, EARTHPOWER, STOMPINGTANTRUM, BULLDOZE, GIGAIMPACT, FACADE, ROUND, CONFIDE, LASERFOCUS, POISONJAB, STONEEDGE, ROCKTOMB, STEALTHROCK, IRONHEAD, AQUATAIL, MUDSHOT, FIREFANG, SCORCHINGSANDS, BREAKINGSWIPE, SCALESHOT, SANDTOMB
-- Same-move identifier normalization (accepted batch1 convention): SANDATTACK=SAND_ATTACK, TAKEDOWN=TAKE_DOWN, ROCKSMASH=ROCK_SMASH, FIREBLAST=FIRE_BLAST, SUNNYDAY=SUNNY_DAY, HYPERBEAM=HYPER_BEAM, HIDDENPOWER=HIDDEN_POWER, FALSESWIPE=FALSE_SWIPE, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, SWORDSDANCE=SWORDS_DANCE, ROCKSLIDE=ROCK_SLIDE, IRONTAIL=IRON_TAIL, RAINDANCE=RAIN_DANCE, BODYSLAM=BODY_SLAM, SCARYFACE=SCARY_FACE
-- Art credit (catalog verbatim): retro_pokesprites (front), koolboyman (back)
-- Shared icon proposal: ICON_MONSTER; cryBase proposal: DRATINI; developer veto applies.
-- Dex source game: moon.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "GARCHOMP",
    slug = "garchomp",
    name = "GARCHOMP",
    dex = 445,
    types = {"DRAGON", "GROUND"},
    baseStats = {hp = 108, attack = 130, defense = 95, specialAttack = 80, specialDefense = 85, speed = 102},
    catchRate = 45,
    baseExp = 255,
    growthRate = "GROWTH_SLOW",
    genderRatio = 127,
    eggGroups = {"EGG_MONSTER", "EGG_DRAGON"},
    eggGroupsRaw = 30,
    eggSteps = 40,
    levelMoves = {{level = 1, move = "CRUNCH"}, {level = 1, move = "TACKLE"}, {level = 1, move = "SAND_ATTACK"}, {level = 1, move = "DRAGONBREATH"}, {level = 27, move = "BITE"}, {level = 34, move = "SLASH"}, {level = 52, move = "DIG"}, {level = 62, move = "SANDSTORM"}, {level = 72, move = "TAKE_DOWN"}},
    tmhm = {"OUTRAGE", "ROCK_SMASH", "FIRE_BLAST", "FLAMETHROWER", "SUNNY_DAY", "EARTHQUAKE", "HYPER_BEAM", "STRENGTH", "HIDDEN_POWER", "CUT", "SNORE", "FALSE_SWIPE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "ROAR", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "SWORDS_DANCE", "TOXIC", "REST", "ROCK_SLIDE", "SANDSTORM", "IRON_TAIL", "SURF", "RAIN_DANCE", "ENDURE", "BODY_SLAM", "SWIFT", "SCARY_FACE", "WHIRLPOOL", "CRUNCH", "DIG"},
    eggMoves = {},
    evolutions = {},
    items = {},
    cryBase = "DRATINI",
    palette = {normal = {{247, 66, 49}, {67, 82, 161}}, shiny = {{231, 99, 41}, {68, 90, 132}}},
    dexEntry = {kind = "MACH", heightFt = 6, heightIn = 3, weightLbs = 209.4, text = "The protuberances<NEXT>on its head serve<NEXT>as sensors. It can", text2 = "even detect<NEXT>distant prey."},
    entry_key = "pokemon:garchomp:default:art:default",
    source = "official-stats",
  }
}
