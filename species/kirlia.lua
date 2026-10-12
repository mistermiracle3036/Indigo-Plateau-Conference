-- Dex entry source: diamond.
return { {
  baseExp = 97,
  baseStats = {attack = 35, defense = 35, hp = 38, specialAttack = 65, specialDefense = 55, speed = 50},
  catchRate = 120,
  cryBase = "KADABRA",
  dex = 281,
  dexEntry = {heightFt = 2, heightIn = 7, kind = "EMOTION", text = "It is highly<NEXT>perceptive of its<NEXT>Trainer's", text2 = "feelings. It<NEXT>dances when it is<NEXT>feeling happy.", weightLbs = 44.5},
  eggGroups = {"EGG_HUMANSHAPE", "EGG_INDETERMINATE"},
  eggGroupsRaw = 139,
  eggMoves = {},
  eggSteps = 20,
  entry_key = "pokemon:kirlia:default:art:default",
  -- DEFERRED EVOLUTION (restore when the target species is added):
  --   KIRLIA -> GALLADE, official method: Dawn Stone, male only
  evolutions = {{into = "GARDEVOIR", level = 30, method = "EVOLVE_LEVEL"}},
  genderRatio = 127,
  growthRate = "GROWTH_SLOW",
  id = "KIRLIA",
  items = {},
  levelMoves = {{level = 1, move = "GROWL"}, {level = 1, move = "DOUBLE_TEAM"}, {level = 1, move = "CONFUSION"}, {level = 9, move = "HYPNOSIS"}, {level = 15, move = "TELEPORT"}, {level = 18, move = "PSYBEAM"}, {level = 28, move = "CHARM"}, {level = 38, move = "PSYCHIC_M"}, {level = 48, move = "DREAM_EATER"}, {level = 53, move = "FUTURE_SIGHT"}},
  name = "KIRLIA",
  palette = {normal = {{74, 214, 82}, {197, 49, 33}}, shiny = {{74, 181, 222}, {206, 115, 33}}},
  slug = "kirlia",
  source = "official-stats",
  tmhm = {"THIEF", "THUNDERBOLT", "THUNDERPUNCH", "THUNDER_WAVE", "FIRE_PUNCH", "SUNNY_DAY", "SHADOW_BALL", "ICE_PUNCH", "ICY_WIND", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PAIN_SPLIT", "PROTECT", "PSYCH_UP", "SAFEGUARD", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "DREAM_EATER", "PSYCHIC_M", "LIGHT_SCREEN", "REFLECT", "REST", "RAIN_DANCE", "ENDURE", "MEGA_KICK", "BODY_SLAM", "MEGA_PUNCH", "SWIFT", "FUTURE_SIGHT", "CHARM", "ENCORE"},
  types = {"PSYCHIC_TYPE"},
} }
