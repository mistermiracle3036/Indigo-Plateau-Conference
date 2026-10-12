-- Source: official-stats
-- PBS WildItemUncommon=METALCOAT omitted: no corresponding Gen2 row slot
-- FEWER THAN FOUR distinct level moves after filtering: 1; left faithful, no padding
-- Dropped tmhm moves absent from Crystal moveOrder: ZENHEADBUTT, IRONHEAD, IRONDEFENSE, STEELBEAM
-- Art credit (catalog verbatim): RainbowDevs/Prism Team
-- Shared icon proposal: ICON_GEODUDE; cryBase proposal: MAGNEMITE; developer veto applies.
-- Dex source game: black-2.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "BELDUM",
    slug = "beldum",
    name = "BELDUM",
    dex = 374,
    types = {"STEEL", "PSYCHIC_TYPE"},
    baseStats = {hp = 40, attack = 55, defense = 80, specialAttack = 35, specialDefense = 60, speed = 30},
    catchRate = 3,
    baseExp = 60,
    growthRate = "GROWTH_SLOW",
    genderRatio = 255,
    eggGroups = {"EGG_MINERAL", "EGG_MINERAL"},
    eggGroupsRaw = 170,
    eggSteps = 40,
    levelMoves = {{level = 1, move = "TACKLE"}},
    tmhm = {},
    eggMoves = {},
    evolutions = {{method = "EVOLVE_LEVEL", into = "METANG", level = 20}},
    items = {},
    cryBase = "MAGNEMITE",
    palette = {normal = {{96, 128, 208}, {0, 64, 168}}, shiny = {{152, 152, 152}, {80, 80, 80}}},
    dexEntry = {kind = "IRON BALL", heightFt = 2, heightIn = 0, weightLbs = 209.9, text = "Its cells are all<NEXT>magnetic, and it<NEXT>communicates with", text2 = "others by using<NEXT>magnetic pulses."},
    entry_key = "pokemon:beldum:default:art:default",
    source = "official-stats",
  }
}
