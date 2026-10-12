-- Dex entry source: alpha-sapphire.
return { {
  baseExp = 63,
  baseStats = {attack = 51, defense = 53, hp = 53, specialAttack = 61, specialDefense = 56, speed = 40},
  catchRate = 45,
  cryBase = "SEEL",
  dex = 393,
  dexEntry = {heightFt = 1, heightIn = 4, kind = "PENGUIN", text = "Because it is very<NEXT>proud, it hates<NEXT>accepting food", text2 = "from people. Its<NEXT>thick down guards<NEXT>it from cold.", weightLbs = 11.5},
  eggGroups = {"EGG_WATER_1", "EGG_GROUND"},
  eggGroupsRaw = 37,
  eggMoves = {"SUPERSONIC", "MUD_SLAP", "SNORE", "FLAIL", "AGILITY", "HYDRO_PUMP", "BIDE", "ICY_WIND"},
  eggSteps = 20,
  entry_key = "pokemon:piplup:default:art:default",
  -- DEFERRED EVOLUTION (restore when the target species is added):
  --   PIPLUP -> PRINPLUP, official method: level 16
  evolutions = {},
  genderRatio = 31,
  growthRate = "GROWTH_MEDIUM_SLOW",
  id = "PIPLUP",
  items = {},
  levelMoves = {{level = 1, move = "POUND"}, {level = 4, move = "GROWL"}, {level = 8, move = "BUBBLE"}, {level = 15, move = "PECK"}, {level = 18, move = "BUBBLEBEAM"}, {level = 22, move = "BIDE"}, {level = 25, move = "FURY_ATTACK"}, {level = 32, move = "WHIRLPOOL"}, {level = 36, move = "MIST"}, {level = 39, move = "DRILL_PECK"}, {level = 43, move = "HYDRO_PUMP"}},
  name = "PIPLUP",
  palette = {normal = {{157, 215, 248}, {20, 122, 193}}, shiny = {{152, 224, 224}, {16, 152, 176}}},
  slug = "piplup",
  source = "official-stats",
  tmhm = {"BLIZZARD", "ICE_BEAM", "ICY_WIND", "HIDDEN_POWER", "CUT", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "REST", "SURF", "WATERFALL", "RAIN_DANCE", "ENDURE", "WHIRLPOOL", "DIG"},
  types = {"WATER"},
} }
