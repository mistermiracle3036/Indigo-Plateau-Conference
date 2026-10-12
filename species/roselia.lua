-- Source: official-stats
-- PBS evolution level 0 for POISONSTING -> level 1 (Gen2 schema minimum)
-- PBS WildItemUncommon=POISONBARB omitted: no corresponding Gen2 row slot
-- EVOLUTION SUBSTITUTE: Roselia -> Roserade officially uses Shiny Stone; proposed SUN_STONE as supported light-associated stone; developer review
-- Duplicate level 1 POISON_STING entry removed after minimum-level normalization; distinct learned levels retained
-- Dropped level moves absent from Crystal moveOrder: WORRYSEED, MAGICALLEAF, TOXICSPIKES, PETALBLIZZARD, AROMATHERAPY, INGRAIN
-- Dropped tmhm moves absent from Crystal moveOrder: DAZZLINGGLEAM, ENERGYBALL, SEEDBOMB, GRASSKNOT, WORRYSEED, UPROAR, FACADE, COVET, ROUND, CONFIDE, NATUREPOWER, POISONJAB, VENOSHOCK, MAGICALLEAF, GRASSYGLIDE, LEAFSTORM, BULLETSEED, WEATHERBALL, POWERWHIP, TOXICSPIKES
-- Dropped egg moves absent from Crystal moveOrder: LEAFSTORM, SEEDBOMB, NATURALGIFT, GRASSWHISTLE, BULLETSEED, POWERWHIP, EXTRASENSORY, LIFEDEW
-- Same-move identifier normalization (accepted batch1 convention): POISONSTING=POISON_STING, STUNSPORE=STUN_SPORE, MEGADRAIN=MEGA_DRAIN, LEECHSEED=LEECH_SEED, SWEETSCENT=SWEET_SCENT, GIGADRAIN=GIGA_DRAIN, PETALDANCE=PETAL_DANCE, SUNNYDAY=SUNNY_DAY, SHADOWBALL=SHADOW_BALL, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, PSYCHUP=PSYCH_UP, SLEEPTALK=SLEEP_TALK, SWORDSDANCE=SWORDS_DANCE, SLUDGEBOMB=SLUDGE_BOMB, RAINDANCE=RAIN_DANCE, BODYSLAM=BODY_SLAM, PINMISSILE=PIN_MISSILE, COTTONSPORE=COTTON_SPORE, SLEEPPOWDER=SLEEP_POWDER, RAZORLEAF=RAZOR_LEAF, MINDREADER=MIND_READER
-- Art credit (catalog verbatim): Nuuk
-- Shared icon proposal: ICON_ODDISH; cryBase proposal: BELLSPROUT; developer veto applies.
-- Dex source game: diamond.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "ROSELIA",
    slug = "roselia",
    name = "ROSELIA",
    dex = 315,
    types = {"GRASS", "POISON"},
    baseStats = {hp = 50, attack = 60, defense = 45, specialAttack = 100, specialDefense = 80, speed = 65},
    catchRate = 150,
    baseExp = 140,
    growthRate = "GROWTH_MEDIUM_SLOW",
    genderRatio = 127,
    eggGroups = {"EGG_FAIRY", "EGG_PLANT"},
    eggGroupsRaw = 103,
    eggSteps = 20,
    levelMoves = {{level = 1, move = "POISON_STING"}, {level = 1, move = "ABSORB"}, {level = 1, move = "GROWTH"}, {level = 1, move = "STUN_SPORE"}, {level = 5, move = "MEGA_DRAIN"}, {level = 10, move = "LEECH_SEED"}, {level = 25, move = "SWEET_SCENT"}, {level = 30, move = "GIGA_DRAIN"}, {level = 35, move = "SYNTHESIS"}, {level = 40, move = "TOXIC"}, {level = 60, move = "PETAL_DANCE"}},
    tmhm = {"SUNNY_DAY", "SHADOW_BALL", "SOLARBEAM", "GIGA_DRAIN", "SYNTHESIS", "HIDDEN_POWER", "CUT", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "PSYCH_UP", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "SWORDS_DANCE", "SLUDGE_BOMB", "TOXIC", "REST", "RAIN_DANCE", "ENDURE", "BODY_SLAM", "SWIFT", "SPIKES", "PIN_MISSILE"},
    eggMoves = {"SPIKES", "SYNTHESIS", "PIN_MISSILE", "COTTON_SPORE", "SLEEP_POWDER", "RAZOR_LEAF", "MIND_READER", "GIGA_DRAIN"},
    evolutions = {{method = "EVOLVE_ITEM", into = "ROSERADE", item = "SUN_STONE"}},
    items = {},
    cryBase = "BELLSPROUT",
    palette = {normal = {{90, 189, 49}, {230, 82, 115}}, shiny = {{115, 181, 41}, {181, 41, 197}}},
    dexEntry = {kind = "THORN", heightFt = 1, heightIn = 0, weightLbs = 4.4, text = "ROSELIA raised on<NEXT>clean drinking<NEXT>water are known to", text2 = "grow vividly<NEXT>colored flowers."},
    entry_key = "pokemon:roselia:default:art:default",
    source = "official-stats",
  }
}
