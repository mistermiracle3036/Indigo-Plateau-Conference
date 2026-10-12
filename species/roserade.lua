-- Source: official-stats
-- PBS WildItemUncommon=POISONBARB omitted: no corresponding Gen2 row slot
-- Dropped level moves absent from Crystal moveOrder: GRASSYTERRAIN, VENOMDRENCH, MAGICALLEAF, TOXICSPIKES, PETALBLIZZARD, AROMATHERAPY, INGRAIN, WORRYSEED
-- Dropped tmhm moves absent from Crystal moveOrder: DAZZLINGGLEAM, ENERGYBALL, SEEDBOMB, GRASSKNOT, WORRYSEED, GIGAIMPACT, UPROAR, FACADE, COVET, ROUND, CONFIDE, LASERFOCUS, NATUREPOWER, POISONJAB, VENOSHOCK, MAGICALLEAF, GRASSYGLIDE, LEAFSTORM, GRASSYTERRAIN, BULLETSEED, WEATHERBALL, VENOMDRENCH, POWERWHIP, TOXICSPIKES
-- Same-move identifier normalization (accepted batch1 convention): POISONSTING=POISON_STING, MEGADRAIN=MEGA_DRAIN, LEECHSEED=LEECH_SEED, SWEETSCENT=SWEET_SCENT, GIGADRAIN=GIGA_DRAIN, PETALDANCE=PETAL_DANCE, STUNSPORE=STUN_SPORE, SUNNYDAY=SUNNY_DAY, SHADOWBALL=SHADOW_BALL, HYPERBEAM=HYPER_BEAM, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, PSYCHUP=PSYCH_UP, SLEEPTALK=SLEEP_TALK, SWORDSDANCE=SWORDS_DANCE, SLUDGEBOMB=SLUDGE_BOMB, RAINDANCE=RAIN_DANCE, BODYSLAM=BODY_SLAM, PINMISSILE=PIN_MISSILE
-- Art credit (catalog verbatim): bloodless (front), COMBOY (back)
-- Shared icon proposal: ICON_ODDISH; cryBase proposal: BELLSPROUT; developer veto applies.
-- Dex source game: sword.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "ROSERADE",
    slug = "roserade",
    name = "ROSERADE",
    dex = 407,
    types = {"GRASS", "POISON"},
    baseStats = {hp = 60, attack = 70, defense = 65, specialAttack = 125, specialDefense = 105, speed = 90},
    catchRate = 75,
    baseExp = 232,
    growthRate = "GROWTH_MEDIUM_SLOW",
    genderRatio = 127,
    eggGroups = {"EGG_FAIRY", "EGG_PLANT"},
    eggGroupsRaw = 103,
    eggSteps = 20,
    levelMoves = {{level = 1, move = "POISON_STING"}, {level = 1, move = "MEGA_DRAIN"}, {level = 1, move = "LEECH_SEED"}, {level = 1, move = "SWEET_SCENT"}, {level = 1, move = "GIGA_DRAIN"}, {level = 1, move = "SYNTHESIS"}, {level = 1, move = "TOXIC"}, {level = 1, move = "PETAL_DANCE"}, {level = 1, move = "ABSORB"}, {level = 1, move = "GROWTH"}, {level = 1, move = "STUN_SPORE"}},
    tmhm = {"SUNNY_DAY", "SHADOW_BALL", "SOLARBEAM", "GIGA_DRAIN", "SYNTHESIS", "HYPER_BEAM", "HIDDEN_POWER", "CUT", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "PSYCH_UP", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "SWORDS_DANCE", "SLUDGE_BOMB", "TOXIC", "REST", "RAIN_DANCE", "ENDURE", "BODY_SLAM", "SWIFT", "SPIKES", "PIN_MISSILE"},
    eggMoves = {},
    evolutions = {},
    items = {},
    cryBase = "BELLSPROUT",
    palette = {normal = {{216, 72, 98}, {0, 181, 72}}, shiny = {{208, 112, 240}, {104, 192, 40}}},
    dexEntry = {kind = "BOUQUET", heightFt = 2, heightIn = 11, weightLbs = 32.0, text = "After captivating<NEXT>opponents with its<NEXT>sweet scent, it", text2 = "lashes them with<NEXT>its thorny whips."},
    entry_key = "pokemon:roserade:default:art:default",
    source = "official-stats",
  }
}
