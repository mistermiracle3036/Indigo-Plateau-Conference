-- Source: polished-crystal data/pokemon/base_stats/wooper_paldean.asm@8f3c7e9651e988d876e32a4c7ad9ef1bb76702a8
-- Dropped unsupported pinned held item CHESTO_BERRY; no renamed substitute
-- Dex uses pinned Polished Crystal adaptation permitted by order; not claimed verbatim official-game prose
-- Dropped level moves absent from Crystal moveOrder: POISON_JAB, TOXIC_SPIKES, GUNK_SHOT
-- Dropped tmhm moves absent from Crystal moveOrder: HAIL, VENOSHOCK, BULLDOZE, FACADE, POISON_JAB, AQUA_TAIL, EARTH_POWER
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_MONSTER; cryBase proposal: WOOPER; developer veto applies.
-- Dex source game: Violet (Polished Crystal adaptation).
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "WOOPER_PALDEAN",
    slug = "wooper-paldean",
    name = "WOOPER",
    dex = 194,
    types = {"POISON", "GROUND"},
    baseStats = {hp = 55, attack = 45, defense = 45, specialAttack = 25, specialDefense = 25, speed = 15},
    catchRate = 255,
    baseExp = 52,
    growthRate = "GROWTH_MEDIUM_FAST",
    genderRatio = 127,
    eggGroups = {"EGG_WATER_1", "EGG_GROUND"},
    eggGroupsRaw = 37,
    eggSteps = 20,
    levelMoves = {{level = 1, move = "MUD_SLAP"}, {level = 1, move = "LEER"}, {level = 5, move = "TACKLE"}, {level = 9, move = "POISON_STING"}, {level = 15, move = "HEADBUTT"}, {level = 19, move = "RECOVER"}, {level = 23, move = "AMNESIA"}, {level = 29, move = "BELLY_DRUM"}, {level = 33, move = "EARTHQUAKE"}},
    tmhm = {"DYNAMICPUNCH", "CURSE", "TOXIC", "HIDDEN_POWER", "ICE_BEAM", "BLIZZARD", "PROTECT", "SAFEGUARD", "IRON_TAIL", "EARTHQUAKE", "RETURN", "DIG", "ROCK_SMASH", "DOUBLE_TEAM", "SLUDGE_BOMB", "SANDSTORM", "SUBSTITUTE", "REST", "ATTRACT", "FLASH", "SURF", "BODY_SLAM", "DEFENSE_CURL", "DOUBLE_EDGE", "ENDURE", "HEADBUTT", "ICE_PUNCH", "ICY_WIND", "ROLLOUT", "SLEEP_TALK", "SWAGGER"},
    eggMoves = {"COUNTER", "DOUBLE_KICK", "ENCORE", "RECOVER", "BODY_SLAM", "ANCIENTPOWER", "SAFEGUARD"},
    evolutions = {{method = "EVOLVE_LEVEL", into = "CLODSIRE", level = 20}},
    items = {},
    cryBase = "WOOPER",
    palette = {normal = {{165, 107, 74}, {107, 33, 107}}, shiny = {{99, 148, 206}, {148, 66, 90}}},
    dexEntry = {kind = "POISON FISH", heightFt = 1, heightIn = 4, weightLbs = 24.3, text = "They line up in<NEXT>groups of three or<NEXT>four and help each", text2 = "other as they walk<NEXT>across the danger-<NEXT>ous wetlands."},
    entry_key = "pokemon:wooper:paldean:art:paldean",
    source = "polished-crystal data/pokemon/base_stats/wooper_paldean.asm@8f3c7e9651e988d876e32a4c7ad9ef1bb76702a8",
  }
}
