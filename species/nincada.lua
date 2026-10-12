-- Source: official-stats
-- Erratic growth -> GROWTH_FAST, approved batch1 substitute (600,000 vs 800,000 total EXP at level 100)
-- PBS WildItemUncommon=SOFTSAND omitted: no corresponding Gen2 row slot
-- Nincada -> Ninjask: official level-20 primary evolution represented as EVOLVE_LEVEL; secondary Shedinja evolution deferred
-- Dropped tmhm moves absent from Crystal moveOrder: XSCISSOR, BUGBITE, STRUGGLEBUG, AERIALACE, FACADE, ROUND, CONFIDE, BUGBUZZ, SKITTERSMACK
-- Dropped egg moves absent from Crystal moveOrder: FEINTATTACK, SILVERWIND, BUGBUZZ, NIGHTSLASH, BUGBITE, FINALGAMBIT
-- Same-move identifier normalization (accepted batch1 convention): SANDATTACK=SAND_ATTACK, FALSESWIPE=FALSE_SWIPE, MUDSLAP=MUD_SLAP, METALCLAW=METAL_CLAW, FURYSWIPES=FURY_SWIPES, MINDREADER=MIND_READER, LEECHLIFE=LEECH_LIFE, SUNNYDAY=SUNNY_DAY, SHADOWBALL=SHADOW_BALL, GIGADRAIN=GIGA_DRAIN, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_BUG; cryBase proposal: PARAS; developer veto applies.
-- Dex source game: firered.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "NINCADA",
    slug = "nincada",
    name = "NINCADA",
    dex = 290,
    types = {"BUG", "GROUND"},
    baseStats = {hp = 31, attack = 45, defense = 90, specialAttack = 30, specialDefense = 30, speed = 40},
    catchRate = 255,
    baseExp = 53,
    growthRate = "GROWTH_FAST",
    genderRatio = 127,
    eggGroups = {"EGG_BUG", "EGG_BUG"},
    eggGroupsRaw = 51,
    eggSteps = 15,
    levelMoves = {{level = 1, move = "SAND_ATTACK"}, {level = 1, move = "SCRATCH"}, {level = 5, move = "HARDEN"}, {level = 10, move = "FALSE_SWIPE"}, {level = 15, move = "MUD_SLAP"}, {level = 21, move = "ABSORB"}, {level = 25, move = "METAL_CLAW"}, {level = 30, move = "FURY_SWIPES"}, {level = 35, move = "MIND_READER"}, {level = 40, move = "DIG"}},
    tmhm = {"LEECH_LIFE", "SUNNY_DAY", "SHADOW_BALL", "SPITE", "SOLARBEAM", "GIGA_DRAIN", "HIDDEN_POWER", "CUT", "SNORE", "FALSE_SWIPE", "FRUSTRATION", "RETURN", "DOUBLE_TEAM", "PROTECT", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "TOXIC", "REST", "SANDSTORM", "ENDURE", "DIG"},
    eggMoves = {"ENDURE", "GUST", "FLAIL"},
    -- DEFERRED EVOLUTION (restore when the target species is added):
    --   NINCADA -> SHEDINJA, official method: Nincada evolves at level 20 with an empty party slot and a spare Poke Ball (generation-dependent details)
    evolutions = {{method = "EVOLVE_LEVEL", into = "NINJASK", level = 20}},
    items = {},
    cryBase = "PARAS",
    palette = {normal = {{99, 181, 33}, {206, 132, 99}}, shiny = {{41, 173, 8}, {197, 165, 41}}},
    dexEntry = {kind = "TRAINEE", heightFt = 1, heightIn = 8, weightLbs = 12.1, text = "Because it lived<NEXT>almost entirely<NEXT>underground, it is", text2 = "nearly blind. It<NEXT>uses its antennae<NEXT>instead."},
    entry_key = "pokemon:nincada:default:art:default",
    source = "official-stats",
  }
}
