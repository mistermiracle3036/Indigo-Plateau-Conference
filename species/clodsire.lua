-- Source: polished-crystal data/pokemon/base_stats/clodsire.asm@8f3c7e9651e988d876e32a4c7ad9ef1bb76702a8
-- Dropped unsupported pinned held item CHESTO_BERRY; no renamed substitute
-- Dex uses pinned Polished Crystal adaptation permitted by order; not claimed verbatim official-game prose
-- Dropped level moves absent from Crystal moveOrder: POISON_JAB, TOXIC_SPIKES, GUNK_SHOT
-- Dropped tmhm moves absent from Crystal moveOrder: HAIL, VENOSHOCK, BULLDOZE, FACADE, FOCUS_BLAST, POISON_JAB, GIGA_IMPACT, STONE_EDGE, AQUA_TAIL, EARTH_POWER
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_MONSTER; cryBase proposal: WOOPER; developer veto applies.
-- Dex source game: Scarlet (Polished Crystal adaptation).
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "CLODSIRE",
    slug = "clodsire",
    name = "CLODSIRE",
    dex = 980,
    types = {"POISON", "GROUND"},
    baseStats = {hp = 130, attack = 75, defense = 60, specialAttack = 45, specialDefense = 100, speed = 20},
    catchRate = 90,
    baseExp = 137,
    growthRate = "GROWTH_MEDIUM_FAST",
    genderRatio = 127,
    eggGroups = {"EGG_WATER_1", "EGG_GROUND"},
    eggGroupsRaw = 37,
    eggSteps = 20,
    levelMoves = {{level = 1, move = "MEGAHORN"}, {level = 1, move = "MUD_SLAP"}, {level = 1, move = "LEER"}, {level = 5, move = "TACKLE"}, {level = 9, move = "POISON_STING"}, {level = 15, move = "HEADBUTT"}, {level = 19, move = "RECOVER"}, {level = 24, move = "AMNESIA"}, {level = 31, move = "BELLY_DRUM"}, {level = 36, move = "EARTHQUAKE"}},
    tmhm = {"DYNAMICPUNCH", "CURSE", "TOXIC", "HIDDEN_POWER", "ICE_BEAM", "BLIZZARD", "HYPER_BEAM", "PROTECT", "SAFEGUARD", "IRON_TAIL", "EARTHQUAKE", "RETURN", "DIG", "ROCK_SMASH", "DOUBLE_TEAM", "SLUDGE_BOMB", "SANDSTORM", "SUBSTITUTE", "REST", "ATTRACT", "THIEF", "ROCK_SLIDE", "FLASH", "SURF", "STRENGTH", "BODY_SLAM", "COUNTER", "DEFENSE_CURL", "DOUBLE_EDGE", "ENDURE", "HEADBUTT", "ICE_PUNCH", "ICY_WIND", "ROLLOUT", "SEISMIC_TOSS", "SLEEP_TALK", "SWAGGER"},
    eggMoves = {"COUNTER", "DOUBLE_KICK", "ENCORE", "RECOVER", "BODY_SLAM", "ANCIENTPOWER", "SAFEGUARD"},
    evolutions = {},
    items = {},
    cryBase = "WOOPER",
    palette = {normal = {{181, 107, 82}, {115, 58, 33}}, shiny = {{90, 115, 156}, {33, 49, 115}}},
    dexEntry = {kind = "SPINY FISH", heightFt = 5, heightIn = 11, weightLbs = 491.6, text = "When attacked, it<NEXT>will retaliate by<NEXT>sticking thick", text2 = "spines out from<NEXT>its body. It's a<NEXT>risky move."},
    entry_key = "pokemon:clodsire:default:art:default",
    source = "polished-crystal data/pokemon/base_stats/clodsire.asm@8f3c7e9651e988d876e32a4c7ad9ef1bb76702a8",
  }
}
