-- Source: official-stats
-- Erratic growth -> GROWTH_FAST, approved batch1 substitute (600,000 vs 800,000 total EXP at level 100)
-- PBS evolution level 0 for DOUBLETEAM -> level 1 (Gen2 schema minimum)
-- PBS evolution level 0 for SCREECH -> level 1 (Gen2 schema minimum)
-- PBS evolution level 0 for FURYCUTTER -> level 1 (Gen2 schema minimum)
-- Duplicate level 1 DOUBLE_TEAM entry removed after minimum-level normalization; distinct learned levels retained
-- Duplicate level 1 SCREECH entry removed after minimum-level normalization; distinct learned levels retained
-- Duplicate level 1 FURY_CUTTER entry removed after minimum-level normalization; distinct learned levels retained
-- Dropped level moves absent from Crystal moveOrder: AERIALACE, BUGBITE, XSCISSOR
-- Dropped tmhm moves absent from Crystal moveOrder: XSCISSOR, UTURN, BUGBITE, STRUGGLEBUG, AERIALACE, ACROBATICS, DEFOG, ROOST, GIGAIMPACT, UPROAR, FACADE, ROUND, CONFIDE, LASERFOCUS, AIRSLASH, DUALWINGBEAT, BUGBUZZ, SKITTERSMACK
-- Same-move identifier normalization (accepted batch1 convention): DOUBLETEAM=DOUBLE_TEAM, FURYCUTTER=FURY_CUTTER, BATONPASS=BATON_PASS, MUDSLAP=MUD_SLAP, METALCLAW=METAL_CLAW, SANDATTACK=SAND_ATTACK, FALSESWIPE=FALSE_SWIPE, FURYSWIPES=FURY_SWIPES, MINDREADER=MIND_READER, SWORDSDANCE=SWORDS_DANCE, LEECHLIFE=LEECH_LIFE, SUNNYDAY=SUNNY_DAY, SHADOWBALL=SHADOW_BALL, GIGADRAIN=GIGA_DRAIN, HYPERBEAM=HYPER_BEAM, HIDDENPOWER=HIDDEN_POWER, SLEEPTALK=SLEEP_TALK
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_BUG; cryBase proposal: PARAS; developer veto applies.
-- Dex source game: black.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "NINJASK",
    slug = "ninjask",
    name = "NINJASK",
    dex = 291,
    types = {"BUG", "FLYING"},
    baseStats = {hp = 61, attack = 90, defense = 45, specialAttack = 50, specialDefense = 50, speed = 160},
    catchRate = 120,
    baseExp = 160,
    growthRate = "GROWTH_FAST",
    genderRatio = 127,
    eggGroups = {"EGG_BUG", "EGG_BUG"},
    eggGroupsRaw = 51,
    eggSteps = 15,
    levelMoves = {{level = 1, move = "DOUBLE_TEAM"}, {level = 1, move = "SCREECH"}, {level = 1, move = "FURY_CUTTER"}, {level = 1, move = "BATON_PASS"}, {level = 1, move = "MUD_SLAP"}, {level = 1, move = "METAL_CLAW"}, {level = 1, move = "DIG"}, {level = 1, move = "SAND_ATTACK"}, {level = 1, move = "SCRATCH"}, {level = 1, move = "HARDEN"}, {level = 1, move = "FALSE_SWIPE"}, {level = 15, move = "AGILITY"}, {level = 23, move = "ABSORB"}, {level = 36, move = "FURY_SWIPES"}, {level = 43, move = "MIND_READER"}, {level = 50, move = "SLASH"}, {level = 57, move = "SWORDS_DANCE"}},
    tmhm = {"LEECH_LIFE", "THIEF", "SUNNY_DAY", "SHADOW_BALL", "SPITE", "SOLARBEAM", "GIGA_DRAIN", "HYPER_BEAM", "HIDDEN_POWER", "CUT", "SNORE", "FALSE_SWIPE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "SWORDS_DANCE", "TOXIC", "REST", "SANDSTORM", "ENDURE", "SCREECH", "SWIFT", "AGILITY", "BATON_PASS", "DIG"},
    eggMoves = {},
    evolutions = {},
    items = {},
    cryBase = "PARAS",
    palette = {normal = {{255, 222, 74}, {132, 66, 41}}, shiny = {{255, 206, 99}, {165, 16, 16}}},
    dexEntry = {kind = "NINJA", heightFt = 2, heightIn = 7, weightLbs = 26.5, text = "Because it moves<NEXT>so quickly, it<NEXT>sometimes becomes", text2 = "unseeable. It<NEXT>congregates around<NEXT>tree sap."},
    entry_key = "pokemon:ninjask:default:art:default",
    source = "official-stats",
  }
}
