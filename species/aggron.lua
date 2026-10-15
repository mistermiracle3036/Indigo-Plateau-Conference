-- Source: official-stats
-- PBS WildItemUncommon=HARDSTONE omitted: no corresponding Gen2 row slot
-- Dropped level moves absent from Crystal moveOrder: ROCKTOMB, IRONHEAD, METALSOUND, AUTOTOMIZE, IRONDEFENSE, HEAVYSLAM, METALBURST
-- Dropped tmhm moves absent from Crystal moveOrder: DARKPULSE, BRUTALSWING, PAYBACK, FLING, TAUNT, DRAGONPULSE, DRAGONCLAW, DRAGONTAIL, SHOCKWAVE, MAGNETRISE, FOCUSPUNCH, FOCUSBLAST, SUPERPOWER, BRICKBREAK, POWERUPPUNCH, AERIALACE, SHADOWCLAW, EARTHPOWER, STOMPINGTANTRUM, BULLDOZE, GIGAIMPACT, UPROAR, FACADE, ROUND, ENDEAVOR, BLOCK, CONFIDE, STONEEDGE, ROCKTOMB, SMACKDOWN, ROCKPOLISH, STEALTHROCK, FLASHCANNON, IRONHEAD, SMARTSTRIKE, IRONDEFENSE, AQUATAIL, WATERPULSE, STEELBEAM, HEAVYSLAM, STEELROLLER, BODYPRESS, HIGHHORSEPOWER, SANDTOMB, METEORBEAM, ROCKBLAST, AVALANCHE
-- Same-move identifier normalization (accepted batch1 convention): METALCLAW=METAL_CLAW, ROCKSLIDE=ROCK_SLIDE, TAKEDOWN=TAKE_DOWN, IRONTAIL=IRON_TAIL, DOUBLEEDGE=DOUBLE_EDGE, THUNDERWAVE=THUNDER_WAVE, ROCKSMASH=ROCK_SMASH, LOWKICK=LOW_KICK, FIREBLAST=FIRE_BLAST, FIREPUNCH=FIRE_PUNCH, SUNNYDAY=SUNNY_DAY, ICEBEAM=ICE_BEAM, ICEPUNCH=ICE_PUNCH, ICYWIND=ICY_WIND, HYPERBEAM=HYPER_BEAM, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, RAINDANCE=RAIN_DANCE, MEGAKICK=MEGA_KICK, BODYSLAM=BODY_SLAM, MEGAPUNCH=MEGA_PUNCH, SCARYFACE=SCARY_FACE, HYDROPUMP=HYDRO_PUMP
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_MONSTER; cryBase proposal: RHYHORN; developer veto applies.
-- Dex source game: black.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "AGGRON",
    slug = "aggron",
    name = "AGGRON",
    dex = 306,
    types = {"STEEL", "ROCK"},
    baseStats = {hp = 70, attack = 110, defense = 180, specialAttack = 60, specialDefense = 60, speed = 50},
    catchRate = 45,
    baseExp = 239,
    growthRate = "GROWTH_SLOW",
    genderRatio = 127,
    eggGroups = {"EGG_MONSTER", "EGG_MONSTER"},
    eggGroupsRaw = 17,
    eggSteps = 35,
    levelMoves = {{level = 1, move = "TACKLE"}, {level = 1, move = "HARDEN"}, {level = 1, move = "METAL_CLAW"}, {level = 12, move = "ROAR"}, {level = 16, move = "HEADBUTT"}, {level = 20, move = "PROTECT"}, {level = 24, move = "ROCK_SLIDE"}, {level = 40, move = "TAKE_DOWN"}, {level = 56, move = "IRON_TAIL"}, {level = 80, move = "DOUBLE_EDGE"}},
    tmhm = {"OUTRAGE", "THUNDER", "THUNDERBOLT", "THUNDERPUNCH", "THUNDER_WAVE", "ROCK_SMASH", "LOW_KICK", "FIRE_BLAST", "FLAMETHROWER", "FIRE_PUNCH", "SUNNY_DAY", "SPITE", "SOLARBEAM", "EARTHQUAKE", "BLIZZARD", "ICE_BEAM", "ICE_PUNCH", "ICY_WIND", "HYPER_BEAM", "STRENGTH", "HIDDEN_POWER", "CUT", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "ROAR", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "REST", "ROCK_SLIDE", "SANDSTORM", "IRON_TAIL", "SURF", "RAIN_DANCE", "ENDURE", "MEGA_KICK", "BODY_SLAM", "MEGA_PUNCH", "SCREECH", "SCARY_FACE", "REVERSAL", "WHIRLPOOL", "HYDRO_PUMP", "CRUNCH", "DIG"},
    eggMoves = {},
    evolutions = {},
    items = {},
    cryBase = "RHYHORN",
    anim = {tiles = 7, play = {{1, 12}, {2, 6}, {1, 38}, {2, 6}, {3, 10}, {4, 6}}, idle = {{3, 10}, {4, 6}}},
    palette = {normal = {{165, 173, 197}, {74, 74, 99}}, shiny = {{148, 206, 165}, {33, 99, 115}}},
    dexEntry = {kind = "IRON ARMOR", heightFt = 6, heightIn = 11, weightLbs = 793.7, text = "While seeking iron<NEXT>for food, it digs<NEXT>tunnels by", text2 = "breaking through<NEXT>bedrock with its<NEXT>steel horns."},
    entry_key = "pokemon:aggron:default:art:default",
    source = "official-stats",
  }
}
