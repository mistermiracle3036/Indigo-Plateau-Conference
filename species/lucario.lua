-- Source: official-stats
-- Dropped level moves absent from Crystal moveOrder: AURASPHERE, AURASPHERE, LIFEDEW, WORKUP, NASTYPLOT, FORCEPALM, HELPINGHAND, COPYCAT, FINALGAMBIT, FEINT, LASERFOCUS, POWERUPPUNCH, CALMMIND, METALSOUND, QUICKGUARD, HEALPULSE, METEORMASH, DRAGONPULSE, CLOSECOMBAT
-- Dropped tmhm moves absent from Crystal moveOrder: DARKPULSE, PAYBACK, FLING, DRAGONPULSE, DUALCHOP, MAGNETRISE, FOCUSPUNCH, FOCUSBLAST, BRICKBREAK, DRAINPUNCH, LOWSWEEP, POWERUPPUNCH, BULKUP, SHADOWCLAW, BULLDOZE, GIGAIMPACT, FACADE, ROUND, CONFIDE, HELPINGHAND, LASERFOCUS, WORKUP, POISONJAB, ZENHEADBUTT, CALMMIND, ROLEPLAY, STONEEDGE, ROCKTOMB, FLASHCANNON, IRONDEFENSE, WATERPULSE, STEELBEAM, BLAZEKICK, COACHING, REVENGE, NASTYPLOT, RETALIATE, CLOSECOMBAT, TERRAINPULSE, AURASPHERE
-- Same-move identifier normalization (accepted batch1 convention): ROCKSMASH=ROCK_SMASH, QUICKATTACK=QUICK_ATTACK, METALCLAW=METAL_CLAW, BONERUSH=BONE_RUSH, SWORDSDANCE=SWORDS_DANCE, LOWKICK=LOW_KICK, SUNNYDAY=SUNNY_DAY, SHADOWBALL=SHADOW_BALL, ICEPUNCH=ICE_PUNCH, HYPERBEAM=HYPER_BEAM, HIDDENPOWER=HIDDEN_POWER, DOUBLETEAM=DOUBLE_TEAM, SLEEPTALK=SLEEP_TALK, PSYCHIC=PSYCHIC_M, ROCKSLIDE=ROCK_SLIDE, IRONTAIL=IRON_TAIL, RAINDANCE=RAIN_DANCE, MEGAKICK=MEGA_KICK, MEGAPUNCH=MEGA_PUNCH, FOCUSENERGY=FOCUS_ENERGY, SCARYFACE=SCARY_FACE
-- Art credit (catalog verbatim): retro_pokesprites (front), koolboyman (back)
-- Shared icon proposal: ICON_FOX; cryBase proposal: HITMONCHAN; developer veto applies.
-- Dex source game: diamond.
-- dex is a National Dex reference/order hint; Expanded Species assigns runtime numbers; no index assigned here.
return {
  {
    id = "LUCARIO",
    slug = "lucario",
    name = "LUCARIO",
    dex = 448,
    types = {"FIGHTING", "STEEL"},
    baseStats = {hp = 70, attack = 110, defense = 70, specialAttack = 115, specialDefense = 70, speed = 90},
    catchRate = 45,
    baseExp = 184,
    growthRate = "GROWTH_MEDIUM_SLOW",
    genderRatio = 31,
    eggGroups = {"EGG_GROUND", "EGG_HUMANSHAPE"},
    eggGroupsRaw = 88,
    eggSteps = 25,
    levelMoves = {{level = 1, move = "ROCK_SMASH"}, {level = 1, move = "SCREECH"}, {level = 1, move = "REVERSAL"}, {level = 1, move = "QUICK_ATTACK"}, {level = 1, move = "DETECT"}, {level = 1, move = "METAL_CLAW"}, {level = 12, move = "COUNTER"}, {level = 36, move = "BONE_RUSH"}, {level = 40, move = "SWORDS_DANCE"}, {level = 56, move = "EXTREMESPEED"}},
    tmhm = {"THUNDERPUNCH", "ROCK_SMASH", "LOW_KICK", "SUNNY_DAY", "SHADOW_BALL", "EARTHQUAKE", "ICE_PUNCH", "HYPER_BEAM", "STRENGTH", "HIDDEN_POWER", "SNORE", "FRUSTRATION", "RETURN", "ATTRACT", "DOUBLE_TEAM", "PROTECT", "ROAR", "SLEEP_TALK", "SUBSTITUTE", "SWAGGER", "SWORDS_DANCE", "TOXIC", "PSYCHIC_M", "REST", "ROCK_SLIDE", "IRON_TAIL", "RAIN_DANCE", "ENDURE", "MEGA_KICK", "MEGA_PUNCH", "SCREECH", "FOCUS_ENERGY", "SWIFT", "SCARY_FACE", "AGILITY", "REVERSAL", "CRUNCH", "DIG"},
    eggMoves = {},
    evolutions = {},
    items = {},
    cryBase = "HITMONCHAN",
    palette = {normal = {{47, 114, 240}, {195, 44, 0}}, shiny = {{248, 200, 72}, {168, 48, 8}}},
    dexEntry = {kind = "AURA", heightFt = 3, heightIn = 11, weightLbs = 119.0, text = "It has the ability<NEXT>to sense the auras<NEXT>of all things. It", text2 = "understands human<NEXT>speech."},
    entry_key = "pokemon:lucario:default:art:default",
    source = "official-stats",
  }
}
