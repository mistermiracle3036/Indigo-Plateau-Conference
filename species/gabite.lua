-- Source: official-stats
-- Dropped level moves absent from Crystal moveOrder: DUALCHOP, SANDTOMB, BULLDOZE, DRAGONCLAW, DRAGONRUSH
-- Dropped tmhm moves absent from Crystal moveOrder: DRACOMETEOR, DRAGONPULSE, DRAGONCLAW, DUALCHOP, AERIALACE, SHADOWCLAW, EARTHPOWER, BULLDOZE, FACADE, ROUND, CONFIDE, LASERFOCUS, STONEEDGE, ROCKTOMB, STEALTHROCK, IRONHEAD, MUDSHOT, SCORCHINGSANDS, SCALESHOT, SANDTOMB
-- Same-move identifier normalization (accepted batch1 convention): SANDATTACK=SAND_ATTACK, TAKEDOWN=TAKE_DOWN, ROCKSMASH=ROCK_SMASH, FIREBLAST=FIRE_BLAST, SUNNYDAY=SUNNY_DAY, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, ROCKSLIDE=ROCK_SLIDE, IRONTAIL=IRON_TAIL, RAINDANCE=RAIN_DANCE, BODYSLAM=BODY_SLAM, SCARYFACE=SCARY_FACE
-- Art credit (catalog verbatim): retro_pokesprites (front), koolboyman (back)
-- Shared icon proposal: ICON_MONSTER; cryBase proposal: DRATINI; developer veto applies.
-- Dex source game: black.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "GABITE",
    slug = "gabite",
    name = "GABITE",
    dex = 444,
    types = {"DRAGON", "GROUND"},
    baseStats = {hp = 68, attack = 90, defense = 65, specialAttack = 50, specialDefense = 55, speed = 82},
    catchRate = 45,
    baseExp = 144,
    growthRate = "GROWTH_SLOW",
    genderRatio = 127,
    eggGroups = {"EGG_MONSTER", "EGG_DRAGON"},
    eggGroupsRaw = 30,
    eggSteps = 40,
    levelMoves = {{level = 1, move = "TACKLE"}, {level = 1, move = "SAND_ATTACK"}, {level = 1, move = "DRAGONBREATH"}, {level = 27, move = "BITE"}, {level = 34, move = "SLASH"}, {level = 50, move = "DIG"}, {level = 58, move = "SANDSTORM"}, {level = 66, move = "TAKE_DOWN"}},
    tmhm = {"OUTRAGE", "ROCK_SMASH", "FIRE_BLAST", "FLAMETHROWER", "SUNNY_DAY", "EARTHQUAKE", "STRENGTH", "HIDDEN_POWER", "CUT", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "ROAR", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "REST", "ROCK_SLIDE", "SANDSTORM", "IRON_TAIL", "RAIN_DANCE", "ENDURE", "BODY_SLAM", "SWIFT", "SCARY_FACE", "DIG"},
    eggMoves = {},
    evolutions = {{method = "EVOLVE_LEVEL", into = "GARCHOMP", level = 48}},
    items = {},
    cryBase = "DRATINI",
    palette = {normal = {{87, 121, 186}, {247, 66, 49}}, shiny = {{0, 48, 200}, {240, 112, 48}}},
    dexEntry = {kind = "CAVE", heightFt = 4, heightIn = 7, weightLbs = 123.5, text = "It loves sparkly<NEXT>things. It seeks<NEXT>treasures in caves", text2 = "and hoards the<NEXT>loot in its nest."},
    entry_key = "pokemon:gabite:default:art:default",
    source = "official-stats",
  }
}
