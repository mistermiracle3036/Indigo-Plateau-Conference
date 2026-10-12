-- Source: official-stats
-- PBS WildItemUncommon=HARDSTONE omitted: no corresponding Gen2 row slot
-- Dropped level moves absent from Crystal moveOrder: ROCKTOMB, IRONHEAD, METALSOUND, AUTOTOMIZE, IRONDEFENSE, HEAVYSLAM, METALBURST
-- Dropped tmhm moves absent from Crystal moveOrder: SHOCKWAVE, MAGNETRISE, SUPERPOWER, AERIALACE, SHADOWCLAW, EARTHPOWER, STOMPINGTANTRUM, BULLDOZE, UPROAR, FACADE, ROUND, ENDEAVOR, CONFIDE, STONEEDGE, ROCKTOMB, ROCKPOLISH, STEALTHROCK, IRONHEAD, IRONDEFENSE, WATERPULSE, STEELBEAM, HEAVYSLAM, STEELROLLER, BODYPRESS, SANDTOMB, ROCKBLAST
-- Same-move identifier normalization (accepted batch1 convention): METALCLAW=METAL_CLAW, ROCKSLIDE=ROCK_SLIDE, TAKEDOWN=TAKE_DOWN, IRONTAIL=IRON_TAIL, DOUBLEEDGE=DOUBLE_EDGE, ROCKSMASH=ROCK_SMASH, SUNNYDAY=SUNNY_DAY, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, RAINDANCE=RAIN_DANCE, BODYSLAM=BODY_SLAM
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_MONSTER; cryBase proposal: RHYHORN; developer veto applies.
-- Dex source game: black-2.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "LAIRON",
    slug = "lairon",
    name = "LAIRON",
    dex = 305,
    types = {"STEEL", "ROCK"},
    baseStats = {hp = 60, attack = 90, defense = 140, specialAttack = 50, specialDefense = 50, speed = 40},
    catchRate = 90,
    baseExp = 151,
    growthRate = "GROWTH_SLOW",
    genderRatio = 127,
    eggGroups = {"EGG_MONSTER", "EGG_MONSTER"},
    eggGroupsRaw = 17,
    eggSteps = 35,
    levelMoves = {{level = 1, move = "TACKLE"}, {level = 1, move = "HARDEN"}, {level = 1, move = "METAL_CLAW"}, {level = 12, move = "ROAR"}, {level = 16, move = "HEADBUTT"}, {level = 20, move = "PROTECT"}, {level = 24, move = "ROCK_SLIDE"}, {level = 40, move = "TAKE_DOWN"}, {level = 52, move = "IRON_TAIL"}, {level = 70, move = "DOUBLE_EDGE"}},
    tmhm = {"ROCK_SMASH", "SUNNY_DAY", "SPITE", "EARTHQUAKE", "STRENGTH", "HIDDEN_POWER", "CUT", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "ROAR", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "REST", "ROCK_SLIDE", "SANDSTORM", "IRON_TAIL", "RAIN_DANCE", "ENDURE", "BODY_SLAM", "SCREECH", "REVERSAL", "DIG"},
    eggMoves = {},
    evolutions = {{method = "EVOLVE_LEVEL", into = "AGGRON", level = 42}},
    items = {},
    cryBase = "RHYHORN",
    palette = {normal = {{165, 173, 197}, {82, 82, 115}}, shiny = {{214, 181, 173}, {74, 123, 132}}},
    dexEntry = {kind = "IRON ARMOR", heightFt = 2, heightIn = 11, weightLbs = 264.6, text = "Lairon fight over<NEXT>territory, and<NEXT>when their steel", text2 = "bodies collide,<NEXT>sparks fly."},
    entry_key = "pokemon:lairon:default:art:default",
    source = "official-stats",
  }
}
