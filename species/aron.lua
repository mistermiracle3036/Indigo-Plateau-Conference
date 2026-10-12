-- Source: official-stats
-- PBS WildItemUncommon=HARDSTONE omitted: no corresponding Gen2 row slot
-- Dropped level moves absent from Crystal moveOrder: ROCKTOMB, IRONHEAD, METALSOUND, AUTOTOMIZE, IRONDEFENSE, HEAVYSLAM, METALBURST
-- Dropped tmhm moves absent from Crystal moveOrder: SHOCKWAVE, MAGNETRISE, SUPERPOWER, AERIALACE, SHADOWCLAW, EARTHPOWER, BULLDOZE, UPROAR, FACADE, ROUND, ENDEAVOR, CONFIDE, ROCKTOMB, ROCKPOLISH, STEALTHROCK, IRONHEAD, IRONDEFENSE, WATERPULSE, STEELBEAM, HEAVYSLAM, STEELROLLER, BODYPRESS
-- Dropped egg moves absent from Crystal moveOrder: DRAGONRUSH, ENDEAVOR, HEADSMASH
-- Same-move identifier normalization (accepted batch1 convention): METALCLAW=METAL_CLAW, ROCKSLIDE=ROCK_SLIDE, TAKEDOWN=TAKE_DOWN, IRONTAIL=IRON_TAIL, DOUBLEEDGE=DOUBLE_EDGE, ROCKSMASH=ROCK_SMASH, SUNNYDAY=SUNNY_DAY, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, RAINDANCE=RAIN_DANCE, BODYSLAM=BODY_SLAM, MUDSLAP=MUD_SLAP
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_MONSTER; cryBase proposal: RHYHORN; developer veto applies.
-- Dex source game: heartgold.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "ARON",
    slug = "aron",
    name = "ARON",
    dex = 304,
    types = {"STEEL", "ROCK"},
    baseStats = {hp = 50, attack = 70, defense = 100, specialAttack = 40, specialDefense = 40, speed = 30},
    catchRate = 180,
    baseExp = 66,
    growthRate = "GROWTH_SLOW",
    genderRatio = 127,
    eggGroups = {"EGG_MONSTER", "EGG_MONSTER"},
    eggGroupsRaw = 17,
    eggSteps = 35,
    levelMoves = {{level = 1, move = "TACKLE"}, {level = 1, move = "HARDEN"}, {level = 4, move = "METAL_CLAW"}, {level = 12, move = "ROAR"}, {level = 16, move = "HEADBUTT"}, {level = 20, move = "PROTECT"}, {level = 24, move = "ROCK_SLIDE"}, {level = 36, move = "TAKE_DOWN"}, {level = 44, move = "IRON_TAIL"}, {level = 56, move = "DOUBLE_EDGE"}},
    tmhm = {"ROCK_SMASH", "SUNNY_DAY", "SPITE", "EARTHQUAKE", "STRENGTH", "HIDDEN_POWER", "CUT", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "ROAR", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "REST", "ROCK_SLIDE", "SANDSTORM", "IRON_TAIL", "RAIN_DANCE", "ENDURE", "BODY_SLAM", "SCREECH", "REVERSAL", "DIG"},
    eggMoves = {"CURSE", "MUD_SLAP", "STOMP"},
    evolutions = {{method = "EVOLVE_LEVEL", into = "LAIRON", level = 32}},
    items = {},
    cryBase = "RHYHORN",
    palette = {normal = {{181, 189, 206}, {16, 132, 255}}, shiny = {{165, 222, 173}, {214, 90, 25}}},
    dexEntry = {kind = "IRON ARMOR", heightFt = 1, heightIn = 4, weightLbs = 132.3, text = "When it evolves,<NEXT>it sheds the steel<NEXT>carapace that", text2 = "covered its whole<NEXT>body and develops<NEXT>a new one."},
    entry_key = "pokemon:aron:default:art:default",
    source = "official-stats",
  }
}
