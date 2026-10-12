-- Dex entry source: pearl.
return { {
  baseExp = 56,
  baseStats = {attack = 45, defense = 35, hp = 45, specialAttack = 20, specialDefense = 30, speed = 20},
  catchRate = 255,
  cryBase = "BEEDRILL",
  dex = 265,
  dexEntry = {heightFt = 1, heightIn = 0, kind = "WORM", text = "It spits a white<NEXT>silk that turns<NEXT>sticky when it", text2 = "contacts air. It<NEXT>is used to<NEXT>immobilize foes.", weightLbs = 7.9},
  eggGroups = {"EGG_BUG", "EGG_BUG"},
  eggGroupsRaw = 51,
  eggMoves = {},
  eggSteps = 15,
  entry_key = "pokemon:wurmple:default:art:default",
  -- DEFERRED EVOLUTION (restore when the target species is added):
  --   WURMPLE -> CASCOON, official method: level 7, personality-dependent branch
  evolutions = {{method = "EVOLVE_LEVEL", level = 7, into = "SILCOON"}},
  genderRatio = 127,
  growthRate = "GROWTH_MEDIUM_FAST",
  id = "WURMPLE",
  items = {"PSNCUREBERRY"},
  levelMoves = {{level = 1, move = "TACKLE"}, {level = 1, move = "STRING_SHOT"}, {level = 5, move = "POISON_STING"}},
  name = "WURMPLE",
  palette = {normal = {{255, 173, 25}, {222, 49, 41}}, shiny = {{255, 230, 25}, {189, 25, 189}}},
  slug = "wurmple",
  source = "official-stats",
  tmhm = {},
  types = {"BUG"},
} }
