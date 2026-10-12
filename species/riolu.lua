-- Source: official-stats
-- Riolu -> Lucario: official high friendship in daytime represented by EVOLVE_HAPPINESS/MORNDAY (Crystal engine threshold/window)
-- Dropped level moves absent from Crystal moveOrder: FEINT, WORKUP, NASTYPLOT, QUICKGUARD, FORCEPALM, HELPINGHAND, COPYCAT, FINALGAMBIT
-- Dropped tmhm moves absent from Crystal moveOrder: PAYBACK, FLING, DUALCHOP, MAGNETRISE, FOCUSPUNCH, FOCUSBLAST, BRICKBREAK, DRAINPUNCH, LOWSWEEP, POWERUPPUNCH, BULKUP, SHADOWCLAW, BULLDOZE, FACADE, ROUND, CONFIDE, HELPINGHAND, LASERFOCUS, WORKUP, POISONJAB, ZENHEADBUTT, ROLEPLAY, ROCKTOMB, IRONDEFENSE, BLAZEKICK, COACHING, REVENGE, NASTYPLOT, RETALIATE
-- Dropped egg moves absent from Crystal moveOrder: SKYUPPERCUT, HIGHJUMPKICK, VACUUMWAVE, IRONDEFENSE, BLAZEKICK, BULLETPUNCH, FOLLOWME, CIRCLETHROW, METEORMASH, HOWL
-- Same-move identifier normalization (accepted batch1 convention): QUICKATTACK=QUICK_ATTACK, METALCLAW=METAL_CLAW, ROCKSMASH=ROCK_SMASH, SWORDSDANCE=SWORDS_DANCE, LOWKICK=LOW_KICK, SUNNYDAY=SUNNY_DAY, ICEPUNCH=ICE_PUNCH, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, ROCKSLIDE=ROCK_SLIDE, IRONTAIL=IRON_TAIL, RAINDANCE=RAIN_DANCE, MEGAKICK=MEGA_KICK, MEGAPUNCH=MEGA_PUNCH, CROSSCHOP=CROSS_CHOP, MINDREADER=MIND_READER
-- Art credit (catalog verbatim): retro_pokesprites (front), koolboyman (back)
-- Shared icon proposal: ICON_FOX; cryBase proposal: HITMONCHAN; developer veto applies.
-- Dex source game: alpha-sapphire.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "RIOLU",
    slug = "riolu",
    name = "RIOLU",
    dex = 447,
    types = {"FIGHTING"},
    baseStats = {hp = 40, attack = 70, defense = 40, specialAttack = 35, specialDefense = 40, speed = 60},
    catchRate = 75,
    baseExp = 57,
    growthRate = "GROWTH_MEDIUM_SLOW",
    genderRatio = 31,
    eggGroups = {"EGG_NONE", "EGG_NONE"},
    eggGroupsRaw = 255,
    eggSteps = 25,
    levelMoves = {{level = 1, move = "QUICK_ATTACK"}, {level = 1, move = "ENDURE"}, {level = 8, move = "METAL_CLAW"}, {level = 12, move = "COUNTER"}, {level = 20, move = "ROCK_SMASH"}, {level = 28, move = "SCREECH"}, {level = 40, move = "SWORDS_DANCE"}, {level = 56, move = "REVERSAL"}},
    tmhm = {"THUNDERPUNCH", "ROCK_SMASH", "LOW_KICK", "SUNNY_DAY", "EARTHQUAKE", "ICE_PUNCH", "STRENGTH", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "ROAR", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "SWORDS_DANCE", "TOXIC", "REST", "ROCK_SLIDE", "IRON_TAIL", "RAIN_DANCE", "ENDURE", "MEGA_KICK", "MEGA_PUNCH", "SCREECH", "SWIFT", "AGILITY", "REVERSAL", "CRUNCH", "DIG"},
    eggMoves = {"CROSS_CHOP", "DETECT", "BITE", "MIND_READER", "AGILITY", "CRUNCH", "LOW_KICK"},
    evolutions = {{method = "EVOLVE_HAPPINESS", into = "LUCARIO", time = "MORNDAY"}},
    items = {},
    cryBase = "HITMONCHAN",
    palette = {normal = {{47, 114, 240}, {195, 44, 0}}, shiny = {{248, 200, 72}, {168, 48, 8}}},
    dexEntry = {kind = "EMANATION", heightFt = 2, heightIn = 4, weightLbs = 44.5, text = "The aura that<NEXT>emanates from its<NEXT>body intensifies", text2 = "to alert others if<NEXT>it is afraid or<NEXT>sad."},
    entry_key = "pokemon:riolu:default:art:default",
    source = "official-stats",
  }
}
