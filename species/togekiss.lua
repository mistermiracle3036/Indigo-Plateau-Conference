-- Source: polished-crystal data/pokemon/base_stats/togekiss.asm@8f3c7e9651e988d876e32a4c7ad9ef1bb76702a8
-- Fairy -> pre-Fairy NORMAL/FLYING
-- FEWER THAN FOUR distinct level moves after filtering: 2; left faithful, no padding
-- Dropped level moves absent from Crystal moveOrder: DISARM_VOICE, HURRICANE, AURA_SPHERE, AIR_SLASH, PLAY_ROUGH
-- Dropped tmhm moves absent from Crystal moveOrder: AERIAL_ACE, FACADE, DAZZLINGLEAM, ROOST, FOCUS_BLAST, DRAIN_PUNCH, WATER_PULSE, GIGA_IMPACT, HYPER_VOICE, TRICK, ZEN_HEADBUTT
-- Dropped egg moves absent from Crystal moveOrder: EXTRASENSORY, HEALINGLIGHT, NASTY_PLOT
-- Same-move identifier normalization (accepted batch1 convention): SOLAR_BEAM=SOLARBEAM, PSYCHIC=PSYCHIC_M
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_BIRD; cryBase proposal: TOGETIC; developer veto applies.
-- Dex source game: Platinum.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "TOGEKISS",
    slug = "togekiss",
    name = "TOGEKISS",
    dex = 468,
    types = {"NORMAL", "FLYING"},
    baseStats = {hp = 85, attack = 50, defense = 95, specialAttack = 120, specialDefense = 115, speed = 80},
    catchRate = 30,
    baseExp = 220,
    growthRate = "GROWTH_FAST",
    genderRatio = 31,
    eggGroups = {"EGG_FLYING", "EGG_FAIRY"},
    eggGroupsRaw = 70,
    eggSteps = 10,
    levelMoves = {{level = 1, move = "EXTREMESPEED"}, {level = 1, move = "FUTURE_SIGHT"}},
    tmhm = {"CURSE", "TOXIC", "HIDDEN_POWER", "SUNNY_DAY", "HYPER_BEAM", "LIGHT_SCREEN", "PROTECT", "RAIN_DANCE", "SAFEGUARD", "SOLARBEAM", "RETURN", "PSYCHIC_M", "SHADOW_BALL", "ROCK_SMASH", "DOUBLE_TEAM", "REFLECT", "FLAMETHROWER", "FIRE_BLAST", "SWIFT", "SUBSTITUTE", "REST", "ATTRACT", "STEEL_WING", "FLASH", "THUNDER_WAVE", "FLY", "BATON_PASS", "BODY_SLAM", "CHARM", "DEFENSE_CURL", "DOUBLE_EDGE", "DREAM_EATER", "ENDURE", "HEADBUTT", "ROLLOUT", "SLEEP_TALK", "SWAGGER"},
    eggMoves = {"FORESIGHT", "FUTURE_SIGHT", "PECK"},
    evolutions = {},
    items = {},
    cryBase = "TOGETIC",
    palette = {normal = {{189, 189, 230}, {222, 0, 0}}, shiny = {{255, 222, 90}, {0, 123, 197}}},
    dexEntry = {kind = "JUBILEE", heightFt = 4, heightIn = 11, weightLbs = 83.8, text = "It shares many<NEXT>blessings with<NEXT>people who respect", text2 = "one another's<NEXT>rights and avoid<NEXT>needless strife."},
    entry_key = "pokemon:togekiss:default:art:default",
    source = "polished-crystal data/pokemon/base_stats/togekiss.asm@8f3c7e9651e988d876e32a4c7ad9ef1bb76702a8",
  }
}
