-- Indigo Plateau Conference -- a Colosseum circuit for Johto.
--
-- PREMISE. The host stands in the Pokemon Center's upstairs lobby and lets
-- you into the COLOSSEUM -- the link-battle room single player never sees.
-- Four rounds, one challenger each, then back out. Which town's stairs you
-- climbed decides which event it is, so one vanilla room hosts five
-- tournaments and the mod ships no maps, no tilesets and no warps.
--
-- GETTING INTO THE COLOSSEUM. Vanilla gates it behind the 2F attendant's
-- link check, which single player never satisfies. This mod does not touch
-- her: mod.world:warpTo only checks that the map exists (WorldAPI.lua:58)
-- and never consults the script that guards the door. Hiding or moving her
-- would break vanilla and collide with any other mod on that map; warping
-- past her costs nothing and is reversible.
--
-- WHAT IS PROVEN (all on device, Gold, 0.1.4 -> 0.1.7)
--   Owned NPCs talk via the world.interacted kind="none" fall-through plus
--   queueScript (first shown by court_of_noctowl 0.1.2).
--
--   A MOD CAN STAGE A TRAINER BATTLE. An NPC spawned with def.trainer is
--   picked up by interactBody's trainer arm (World.lua:7331) and run
--   through the cart's own TALK_TO_TRAINER_SCRIPT. Both struct fields are
--   NUMERIC -- a class constant and an array position (Trainers.lua:18-19).
--
--   MOD-REGISTERED TEXT REACHES THE ROM'S POOL. The text registry targets
--   gen2Text (Schemas.lua:476), which is what Vm:showText reads.
--
--   trainer.party substitutes the team, and what it returns must be
--   FINISHED battle mons -- nothing downstream rebuilds them
--   (Battle.lua:258).
--
-- WHY CARRIERS RATHER THAN NEW TRAINER CLASSES. Trainer pictures are keyed by
-- vanilla class constants, so every guest rides a real class. Private member
-- rows are added with `__append`, which preserves every vanilla member and
-- gives the guest its own displayed name. The runtime party hook is a second,
-- positively gated layer and declines all non-Conference battles.
--
-- Verified against gen1recomp v0.1.79.

local Runtime = require("src.mods.Runtime")

return function(mod)
  local VERSION = "1.1.24"
  local MOD_ID = "indigo_conference"

  mod.exports.version = VERSION
  -- Custom art is registered under mod-owned sprite ids. No trainer, party,
  -- map or tileset record is claimed here.
  mod.exports.owns = { trainers = {}, maps = {}, tilesets = {},
                       sprites = { "SPRITE_IPC_BRENDAN",
                                   "SPRITE_IPC_DAWN",
                                   "SPRITE_IPC_GREEN",
                                   "SPRITE_IPC_HILBERT",
                                   "SPRITE_IPC_HILDA",
                                   "SPRITE_IPC_LYRA",
                                   "SPRITE_IPC_MAY",
                                   "SPRITE_IPC_MICHAEL",
                                   "SPRITE_IPC_BEA",
                                   "SPRITE_IPC_MINA",
                                   "SPRITE_IPC_NATE",
                                   "SPRITE_IPC_STADIUM_PLAYER",
                                   "SPRITE_IPC_ROSA",
                                   "SPRITE_IPC_WES",
                                   "SPRITE_IPC_GIOVANNI",
                                   "SPRITE_IPC_LORELEI",
                                   "SPRITE_IPC_AGATHA",
                                   "SPRITE_IPC_ROCKET_EXECUTIVE",
                                   "SPRITE_IPC_ARCHER",
                                   "SPRITE_IPC_ARIANA",
                                   "SPRITE_IPC_PROTON",
                                   "SPRITE_IPC_PETREL",
                                   "SPRITE_IPC_ROCKET_GRUNT_M",
                                   "SPRITE_IPC_ROCKET_GRUNT_F",
                                   "SPRITE_IPC_ROXIE",
                                   "SPRITE_IPC_PIERS" } }

  local LOBBY = "POKECENTER_2F"
  local ARENA = "COLOSSEUM"

  -- POKECENTER_2F warp 3 of 4 -> COLOSSEUM, read off the device census
  -- (1 = 0,7 stairs down; 2 = 5,0 TRADE_CENTER; 4 = 13,2 TIME_CAPSULE).
  -- Declared HERE, above every user: a local declared further down compiles
  -- as a nil global in the functions above it and would silently never
  -- match -- the use-before-declaration trap this project has paid for.
  local ARENA_DOOR_X, ARENA_DOOR_Y = 9, 0

  local HOST_NAME = "IPC_HOST"
  local FOE_NAME = "IPC_FOE"
  local EXIT_NAME = "IPC_EXIT"
  local MC_NAME = "IPC_MC"

  -- SPRITEMOVEDATA_STANDING_DOWN (src/world/gen2/Npc.lua MOVE table).
  -- Numeric: the Gen 2 arm compares def.movement against numbers.
  local MOVE_STANDING_DOWN = 6
  local SPRITE_HOST = "SPRITE_GENTLEMAN"

  -- Restore the original vanilla Link Receptionist announcer. Ash now owns
  -- a separate guest sprite and battle portrait below, so the announcer and
  -- trainer can never repaint one another or any shared trainer class.
  local SPRITE_MC = "SPRITE_OLD_LINK_RECEPTIONIST"

  -- Cleared art test. Every supplied walking set becomes a private six-frame
  -- sprite record. Guest trainer members are appended later; no vanilla
  -- sprite, trainer member, shared portrait or party is replaced.
  local function registerGuestSprite(id, file, palette, paletteId)
    mod.content.sprites:register(id, {
      id = id,
      image = mod.path .. "/assets/" .. file,
      frames = 6,
      walker = true,
      spriteType = "WALKING_SPRITE",
      palette = palette,
      paletteId = paletteId,
    })
  end

  registerGuestSprite("SPRITE_IPC_BRENDAN", "brendan.png", "PAL_OW_RED", 0)
  registerGuestSprite("SPRITE_IPC_DAWN", "dawn.png", "PAL_OW_RED", 0)
  registerGuestSprite("SPRITE_IPC_GREEN", "green.png", "PAL_OW_BROWN", 3)
  registerGuestSprite("SPRITE_IPC_HILBERT", "hilbert.png", "PAL_OW_RED", 0)
  registerGuestSprite("SPRITE_IPC_HILDA", "hilda.png", "PAL_OW_RED", 0)
  registerGuestSprite("SPRITE_IPC_LYRA", "lyra.png", "PAL_OW_BLUE", 1)
  registerGuestSprite("SPRITE_IPC_MAY", "may.png", "PAL_OW_RED", 0)
  registerGuestSprite("SPRITE_IPC_MICHAEL", "michael.png", "PAL_OW_RED", 0)
  registerGuestSprite("SPRITE_IPC_BEA", "bea.png", "PAL_OW_PINK", 4)
  registerGuestSprite("SPRITE_IPC_MINA", "mina.png", "PAL_OW_PINK", 4)
  registerGuestSprite("SPRITE_IPC_NATE", "nate.png", "PAL_OW_RED", 0)
  registerGuestSprite("SPRITE_IPC_STADIUM_PLAYER", "stadium_player.png", "PAL_OW_RED", 0)
  registerGuestSprite("SPRITE_IPC_ROSA", "rosa.png", "PAL_OW_RED", 0)
  registerGuestSprite("SPRITE_IPC_WES", "wes.png", "PAL_OW_BLUE", 1)
  registerGuestSprite("SPRITE_IPC_GIOVANNI", "giovanni.png", "PAL_OW_BROWN", 3)
  registerGuestSprite("SPRITE_IPC_LORELEI", "lorelei.png", "PAL_OW_RED", 0)
  registerGuestSprite("SPRITE_IPC_AGATHA", "agatha.png", "PAL_OW_PINK", 4)
  registerGuestSprite("SPRITE_IPC_ROCKET_EXECUTIVE", "rocket_executive.png", "PAL_OW_RED", 0)
  registerGuestSprite("SPRITE_IPC_ARCHER", "archer.png", "PAL_OW_BLUE", 1)
  registerGuestSprite("SPRITE_IPC_ARIANA", "ariana.png", "PAL_OW_RED", 0)
  registerGuestSprite("SPRITE_IPC_PROTON", "proton.png", "PAL_OW_PINK", 4)
  registerGuestSprite("SPRITE_IPC_PETREL", "petrel.png", "PAL_OW_GREEN", 2)
  registerGuestSprite("SPRITE_IPC_ROCKET_GRUNT_M", "rocket_grunt_m.png", "PAL_OW_BROWN", 3)
  registerGuestSprite("SPRITE_IPC_ROCKET_GRUNT_F", "rocket_grunt_f.png", "PAL_OW_BROWN", 3)
  registerGuestSprite("SPRITE_IPC_ROXIE", "roxie.png", "PAL_OW_PINK", 4)
  registerGuestSprite("SPRITE_IPC_PIERS", "piers.png", "PAL_OW_PINK", 4)

  -- Battle fronts are replaced only on the already-created UI state for a
  -- positively identified Conference battle. Shared class picture tables
  -- stay untouched, which preserves every ordinary trainer battle.
  local BATTLE_FRONTS = {
    BRENDAN = mod.path .. "/assets/brendan_front.png",
    DAWN = mod.path .. "/assets/dawn_front.png",
    GREEN = mod.path .. "/assets/green_front.png",
    HILBERT = mod.path .. "/assets/hilbert_front.png",
    HILDA = mod.path .. "/assets/hilda_front.png",
    LYRA = mod.path .. "/assets/lyra_front.png",
    MAY = mod.path .. "/assets/may_front.png",
    MICHAEL = mod.path .. "/assets/michael_front.png",
    BEA = mod.path .. "/assets/bea_front.png",
    MINA = mod.path .. "/assets/mina_front.png",
    NATE = mod.path .. "/assets/nate_front.png",
    STADIUM_PLAYER = mod.path .. "/assets/stadium_player_front.png",
    ROSA = mod.path .. "/assets/rosa_front.png",
    WES = mod.path .. "/assets/wes_front.png",
    JESSIE_JAMES = mod.path .. "/assets/jessie_james_front.png",
    GIOVANNI = mod.path .. "/assets/giovanni_front.png",
    OAK = mod.path .. "/assets/oak_front.png",
    LORELEI = mod.path .. "/assets/lorelei_front.png",
    AGATHA = mod.path .. "/assets/agatha_front.png",
    ROCKET_EXECUTIVE = mod.path .. "/assets/rocket_executive_front.png",
    ARCHER = mod.path .. "/assets/archer_front.png",
    ARIANA = mod.path .. "/assets/ariana_front.png",
    PROTON = mod.path .. "/assets/proton_front.png",
    PETREL = mod.path .. "/assets/petrel_front.png",
    ROCKET_GRUNT_M = mod.path .. "/assets/rocket_grunt_m_front.png",
    ROCKET_GRUNT_F = mod.path .. "/assets/rocket_grunt_f_front.png",
    ROXIE = mod.path .. "/assets/roxie_front.png",
    PIERS = mod.path .. "/assets/piers_front.png",
  }

  -- These portraits are pre-colored with their chosen Gold palette.
  -- Mark only them true-color so their borrowed trainer classes cannot
  -- remap the art through an unrelated class palette during battle.
  local TRUE_COLOR_FRONTS = {
    LYRA = true,
    MAY = true,
    MICHAEL = true,
    BEA = true,
    MINA = true,
    NATE = true,
    WES = true,
    JESSIE_JAMES = true,
    GIOVANNI = true,
    OAK = true,
    LORELEI = true,
    AGATHA = true,
    ROCKET_EXECUTIVE = true,
    ARCHER = true,
    ARIANA = true,
    PROTON = true,
    PETREL = true,
    ROCKET_GRUNT_M = true,
    ROCKET_GRUNT_F = true,
    ROXIE = true,
    PIERS = true,
  }

  local ROUNDS = 4

  ----------------------------------------------------------------------
  -- The card. Four rounds, escalating. Every carrier is a real vanilla
  -- class + member so the portrait and the class name resolve; the party
  -- is ours, swapped in by the trainer.party hook.
  --
  -- Wes gets ESPEON and UMBREON, which is the whole reason he reads
  -- correctly on Gold: the Gen 1 team had to be Jolteon/Flareon/Vaporeon
  -- because the other two did not exist yet.
  ----------------------------------------------------------------------
  -- Levels are anchored to the TOWN'S GYM LEADER -- see levelBase below.
  -- 0.2.0's fixed 28->46 curve was written for a post-Elite-Four player and
  -- made Violet's round 1 unbeatable; 0.2.1-0.3.3 scaled to the player,
  -- which was playable but rubber-banded so beating it meant nothing. The
  -- leader anchor gives each venue a fixed difficulty a step above the badge
  -- that let you in, consistent town to town by construction.
  ----------------------------------------------------------------------
  -- THE POOL (0.9.0+): 64 challengers across four tiers -- the design
  -- pass's roster draft (ROSTER_NOTES.md), with the four shipped
  -- characters folded in. Each RUN draws one name per tier (newDraw
  -- below), so no two tournaments need repeat.
  --
  -- Every class, member, sprite and species below was verified against
  -- rom_manifest_gold.json THIS session -- the draft's TODO/CONFIRM
  -- placeholders are all resolved. Notable finds: SCHOOLBOY has a real
  -- member JOE, HIKER has ANTHONY1 and MICHAEL, so those three battle
  -- under their actual names; MR__MIME is spelled with TWO underscores;
  -- and Gold has no CAMPER/HIKER/JUGGLER/etc. overworld sprites (trainer
  -- types share the generic sheets), so those are mapped to the closest
  -- real sheet. Tier 4 rides named classes: real name AND real portrait.
  ----------------------------------------------------------------------
  local ROSTER = {

  -- ========================= TIER 1 =========================
  { key = "AJ", tier = 1, class = "BUG_CATCHER", member = "DON",
    sprite = "SPRITE_YOUNGSTER", name = "A.J.",
    chat = "A.J.: I warmed up\non six GEODUDE.",
    intro = "A.J.: My gym\nnever lost.\fNeither do I.",
    win  = "My streak...\fFine. Take it.",
    loss = "The streak lives.\fGo home.",
    afterWin  = "A.J.: Rematch.\fSomeday.",
    afterLoss = "A.J.: 100 wins,\nzero losses.",
    party = { { species = "SANDSLASH", delta = 0 },
              { species = "BUTTERFREE", delta = -1 },
              { species = "PRIMEAPE", delta = 0 } } },

  { key = "TODD", tier = 1, class = "CAMPER", member = "TODD1",
    sprite = "SPRITE_YOUNGSTER", name = "TODD",   -- battles as CAMPER TODD
    chat = "TODD: One shot is\nall I ever need.",
    intro = "TODD: Say cheese!",
    win = "Blurry. Every\nsingle frame.",
    loss = "Perfect focus.\fFront page stuff.",
    afterWin = "TODD: Delete\nthat one.",
    afterLoss = "TODD: I'll frame\nthis feeling.",
    party = { { species = "BUTTERFREE", delta = 1 },
              { species = "PIDGEOTTO",  delta = 0 } } },

  { key = "SEYMOUR", tier = 1, class = "SCIENTIST", member = "ROSS",
    sprite = "SPRITE_SCIENTIST", name = "SEYMOUR",
    chat = "SEYMOUR: The moon\nguides us all!",
    intro = "SEYMOUR: For\nscience!",
    win = "Fascinating\nresults...",
    loss = "Hypothesis:\nconfirmed!",
    afterWin = "SEYMOUR: I must\nrevise my notes.",
    afterLoss = "SEYMOUR: CLEFAIRY\napproves of me.",
    party = { { species = "CLEFAIRY", delta = 1 },
              { species = "STARYU",   delta = 0 } } },

  { key = "DUPLICA", tier = 1, class = "LASS", member = "ALICE",
    sprite = "SPRITE_LASS", name = "DUPLICA",
    chat = "DUPLICA: Guess\nwho I am today!",
    intro = "DUPLICA: Copy\nthis if you can!",
    win = "Even DITTO can't\ncopy that...",
    loss = "Transform!\nInto a winner!",
    afterWin = "DUPLICA: DITTO is\nsulking backstage.",
    afterLoss = "DUPLICA: Want my\nautograph? Whose?",
    party = { { species = "DITTO", delta = 0 },
              { species = "DITTO", delta = 1 } } },

  { key = "TRACEY", tier = 1, class = "CAMPER", member = "ELLIOT",
    sprite = "SPRITE_YOUNGSTER", name = "TRACEY",
    chat = "TRACEY: Hold on,\nI'm sketching you.",
    intro = "TRACEY: Let's see\nyou up close!",
    win = "My pencil\nsnapped...",
    loss = "That pose! Don't\nmove, don't move!",
    afterWin = "TRACEY: The sketch\nstill came out.",
    afterLoss = "TRACEY: I drew you\nfrowning. Sorry.",
    party = { { species = "MARILL",  delta = 0 },
              { species = "VENONAT", delta = 0 },
              { species = "SCYTHER", delta = 1 } } },

  { key = "MICKID", tier = 1, class = "YOUNGSTER", member = "MIKEY",
    sprite = "SPRITE_YOUNGSTER", name = "MIC KID",
    chat = "MIC KID: HEY! YOU!\nCan you hear me?!",
    intro = "MIC KID: PIKACHU!\nUse everything!",
    win = "It never listens\nto me anyway...",
    loss = "IT HEARD ME!\nIT FINALLY HEARD!",
    afterWin = "MIC KID: Speak up!\nI can't hear you!",
    afterLoss = "MIC KID: We talk\nevery day now!",
    party = { { species = "PIKACHU",  delta = 1 },
              { species = "MAGNEMITE", delta = 0 } } },

  { key = "BALLGUY", tier = 1, class = "JUGGLER", member = "FRITZ",
    sprite = "SPRITE_SUPER_NERD", name = "BALL GUY",
    chat = "BALL GUY: Have I\ngot a ball for\fyou! ...Later.",
    intro = "BALL GUY: Let's\nhave a ball!",
    win = "Even my head\nis deflated...",
    loss = "Having a ball\nyet? I sure am!",
    afterWin = "BALL GUY: Take my\nrespect! No ball.",
    afterLoss = "BALL GUY: Who is\nunder the mask?\fGreat question!",
    party = { { species = "VOLTORB",    delta = 0 },
              { species = "JIGGLYPUFF", delta = 0 },
              { species = "ELECTRODE",  delta = 1 } } },

  -- SCHOOLBOY's roster really contains a member named JOE -- verified --
  -- so the TECH student battles under his own name in his own uniform.
  { key = "JOE", tier = 1, class = "SCHOOLBOY", member = "JOE",
    sprite = "SPRITE_YOUNGSTER", name = "JOE",
    chat = "JOE: I memorized\nevery type chart.",
    intro = "JOE: Top of the\nclass... almost.",
    win = "GISELLE can never\nhear about this.",
    loss = "Straight to the\ntop of the class!",
    afterWin = "JOE: Theory and\npractice differ.",
    afterLoss = "JOE: I studied\nyou beforehand.",
    party = { { species = "WEEPINBELL", delta = 1 },
              { species = "SLOWPOKE",   delta = 0 } } },

  { key = "RANGER", tier = 1, class = "CAMPER", member = "DEAN",
    sprite = "SPRITE_YOUNGSTER", name = "RANGER",
    chat = "RANGER: These\nPOKeMON? Wild.\fWe're friends.",
    intro = "RANGER: Nature\nlends a hand!",
    win = "They fought for\nme. That's plenty.",
    loss = "Teamwork! Now\nback to the wild.",
    afterWin = "RANGER: They still\nwent home happy.",
    afterLoss = "RANGER: Capture\ncomplete!",
    party = { { species = "FURRET",   delta = 0 },
              { species = "STANTLER", delta = 0 },
              { species = "NOCTOWL",  delta = 1 } } },

  -- ========================= TIER 2 =========================
  { key = "GISELLE", tier = 2, class = "BEAUTY", member = "VICTORIA",
    sprite = "SPRITE_COOLTRAINER_F", name = "GISELLE",
    chat = "GISELLE: Which\nschool did you\fattend? ...Oh.",
    intro = "GISELLE: Top of\nmy class.\fDo keep up.",
    win  = "Top marks.\fFor today.",
    loss = "Study harder.\fClass dismissed.",
    afterWin  = "GISELLE: It won't\nhappen twice.",
    afterLoss = "GISELLE: ECRUTEAK\nUNIVERSITY, dear.",
    party = { { species = "CUBONE", delta = -1 },
              { species = "GRAVELER", delta = 0 },
              { species = "WIGGLYTUFF", delta = 0 } } },

  { key = "MANDI", tier = 2, class = "JUGGLER", member = "HORTON",
    sprite = "SPRITE_ROCKER", name = "MANDI",
    chat = "MANDI: You may\napplaud now.",
    intro = "MANDI: Behold\nthe astounding!",
    win = "The crowd loves\nan upset...",
    loss = "Ta-daah! Was\nthere ever doubt?",
    afterWin = "MANDI: Even stars\nhave off nights.",
    afterLoss = "MANDI: The magic\nis real, kid.",
    party = { { species = "EXEGGUTOR", delta = 1 },
              { species = "SEADRA",    delta = 0 },
              { species = "GOLBAT",    delta = 0 } } },

  -- HIKER really has ANTHONY1 (the Route 33 phone friend), so the boxer's
  -- battle name is his own, as the notes hoped. BLACK_BELT sprite: a
  -- fighter, not a mountaineer.
  { key = "ANTHONY", tier = 2, class = "HIKER", member = "ANTHONY1",
    sprite = "SPRITE_BLACK_BELT", name = "ANTHONY",
    chat = "ANTHONY: My girl\nthinks I train\ftoo hard. Never.",
    intro = "ANTHONY: Gloves\nup!",
    win = "Down for the\ncount...",
    loss = "And STILL the\nchampion, baby!",
    afterWin = "ANTHONY: Time to\nhit the gym.",
    afterLoss = "ANTHONY: Steak\ntonight, partner!",
    party = { { species = "HITMONCHAN", delta = 1 },
              { species = "MACHOKE",    delta = 0 },
              { species = "MANKEY",     delta = 0 } } },

  { key = "SUZIE", tier = 2, class = "BEAUTY", member = "SAMANTHA",
    sprite = "SPRITE_BEAUTY", name = "SUZIE",
    chat = "SUZIE: Brushed,\nfed, and ready.",
    intro = "SUZIE: Show me\nyour bond.",
    win = "Beauty isn't\neverything...",
    loss = "Raised with\nlove. It shows.",
    afterWin = "SUZIE: VULPIX\nstill looked best.",
    afterLoss = "SUZIE: Groom your\nteam. And spirit.",
    party = { { species = "NINETALES", delta = 0 },
              { species = "VULPIX",    delta = 1 } } },

  { key = "RAYMOND", tier = 2, class = "SAILOR", member = "TERRELL",
    sprite = "SPRITE_SAILOR", name = "RAYMOND",
    chat = "RAYMOND: I lost a\nbig one in thirty\fseconds. Once.",
    intro = "RAYMOND: Ten years\nfor this rematch!",
    win = "Thirty seconds...\nevery time...",
    loss = "HAR HAR! Ten years\nto sink one kid!",
    afterWin = "RAYMOND: Back to\nthe gym. Ten more\fyears if I must.",
    afterLoss = "RAYMOND: DONPHAN,\nwe finally did it.",
    party = { { species = "DONPHAN",  delta = 1 },
              { species = "VENOMOTH", delta = 0 },
              { species = "GOLEM",    delta = 0 } } },

  { key = "CASSIDY", tier = 2, class = "EXECUTIVEF", member = "EXECUTIVEF_1",
    sprite = "SPRITE_ROCKET_GIRL", name = "CASSIDY",
    chat = "CASSIDY: Some\nduos blast off.\fWe get promoted.",
    intro = "CASSIDY: This is\nwhat competence\flooks like.",
    win = "Enjoy the only\nwin you'll get.",
    loss = "Flawless. As the\nboss expects.",
    afterWin = "CASSIDY: I don't\nlose. I gather\fintel. Take care.",
    afterLoss = "CASSIDY: We were\nnever here, dear.",
    party = { { species = "RATICATE", delta = 1 },
              { species = "DROWZEE",  delta = 0 },
              { species = "HOUNDOUR", delta = 0 } } },

  { key = "BUTCH", tier = 2, class = "EXECUTIVEM", member = "EXECUTIVEM_2",
    sprite = "SPRITE_ROCKET", name = "BUTCH",
    chat = "BUTCH: Go on.\nSay the name.\fI'll wait.",
    intro = "BUTCH: Last guy\ncalled me Bill.\fHe regrets it.",
    win = "Lost the match.\nKept the name.",
    loss = "Say it in your\nsleep: BUTCH.",
    afterWin = "BUTCH: Don't\nquote me. You'd\fget it wrong.",
    afterLoss = "BUTCH: For once\nthe right guy won.",
    party = { { species = "PRIMEAPE", delta = 1 },
              { species = "HITMONTOP", delta = 0 },
              { species = "HOUNDOUR",  delta = 0 } } },

  { key = "HELENA", tier = 2, class = "MEDIUM", member = "GRACE",
    sprite = "SPRITE_GRANNY", name = "HELENA",
    chat = "HELENA: Your aura\nis... hee hee hee.",
    intro = "HELENA: The\nspirits hunger.",
    win = "The stars said\nthis would happen.",
    loss = "It is foretold.\nIt is always\fforetold.",
    afterWin = "HELENA: I cursed\nyour shoelaces.",
    afterLoss = "HELENA: The veil\nthins around you.",
    party = { { species = "GASTLY",     delta = 0 },
              { species = "HAUNTER",    delta = 0 },
              { species = "MISDREAVUS", delta = 1 } } },

  { key = "MRTWO", tier = 2, class = "PSYCHIC_T", member = "HERMAN",
    sprite = "SPRITE_SAGE", name = "MR. TWO",
    chat = "MR. TWO: I was\nborn... created...\fwhichever.",
    intro = "MR. TWO: Behold\nperfection.",
    win = "Humans... always\nsurprising.",
    loss = "As inevitable\nas my creation.",
    afterWin = "MR. TWO: The\nreal me would win.",
    afterLoss = "MR. TWO: I am the\nworld's strongest.",
    -- clone-trio starters; the RED echo is intentional
    party = { { species = "VENUSAUR",  delta = 0 },
              { species = "CHARIZARD", delta = 0 },
              { species = "BLASTOISE", delta = 0 } } },

  -- ========================= TIER 3 =========================
  { key = "WES", tier = 3, class = "COOLTRAINERM", member = "NICK",
    sprite = "SPRITE_IPC_WES", name = "WES",
    chat = "WES: ...\fSave it for\nthe ring.",
    intro = "WES: I came far\nfrom ORRE.\fDon't waste it.",
    win  = "...ORRE breeds\ntough trainers.\fSo does JOHTO.",
    loss = "Not even close.\fFind me when\nyou're ready.",
    afterWin  = "WES: JOHTO's\nstronger than\fI heard.",
    afterLoss = "WES: Go train.\fI'll wait.",
    party = { { species = "ESPEON", delta = 0 },
              { species = "UMBREON", delta = 0 },
              { species = "PERSIAN", delta = 2 } } },

  { key = "RITCHIE", tier = 3, class = "COOLTRAINERM", member = "RYAN",
    sprite = "SPRITE_COOLTRAINER_M", name = "RITCHIE",
    chat = "RITCHIE: SPARKY's\nraring to go!",
    intro = "RITCHIE: Win or\nlose, no regrets!",
    win = "No regrets.\nStill stings.",
    loss = "We keep climbing,\nSPARKY and me!",
    afterWin = "RITCHIE: You're\nlike a friend of\fmine. He lost too.",
    afterLoss = "RITCHIE: SPARKY,\ntake a bow!",
    party = { { species = "PIKACHU",    delta = 1 },
              { species = "CHARMELEON", delta = 0 },
              { species = "BUTTERFREE", delta = 0 } } },

  { key = "GREEN", tier = 3, class = "COOLTRAINERF", member = "GWEN",
    sprite = "SPRITE_IPC_GREEN", name = "GREEN",
    chat = "GREEN: Watch your\npockets around me.",
    intro = "GREEN: Nothing up\nmy sleeve. Honest.",
    win = "Fine. I let you\nwin. Obviously.",
    loss = "Thanks for the\nwarm-up, cutie!",
    afterWin = "GREEN: Check your\nbag! ...Kidding.\fMostly.",
    afterLoss = "GREEN: I peeked at\nyour whole team.",
    party = { { species = "BLASTOISE",  delta = 1 },
              { species = "WIGGLYTUFF", delta = 0 },
              { species = "DITTO",      delta = 0 } } },

  { key = "YELLOW", tier = 3, class = "PICNICKER", member = "HOPE",
    sprite = "SPRITE_LASS", name = "YELLOW",
    chat = "YELLOW: The forest\nsays hello.",
    intro = "YELLOW: Let's be\ngentle... mostly.",
    win = "Everyone's ok?\nThen I'm happy.",
    loss = "Sorry! Are you\nhurt? Sorry!",
    afterWin = "YELLOW: Your team\nlikes you a lot.",
    afterLoss = "YELLOW: RATTY says\nno hard feelings.",
    party = { { species = "RATICATE", delta = 0 },
              { species = "DODRIO",   delta = 0 },
              { species = "PIKACHU",  delta = 1 } } },

  -- GENTLEMAN EDWARD -- pleasingly close to "Es Cade" for the mayor act
  { key = "EVICE", tier = 3, class = "GENTLEMAN", member = "EDWARD",
    sprite = "SPRITE_GENTLEMAN", name = "EVICE",
    chat = "EVICE: Welcome!\nA mayor supports\fall his trainers.",
    intro = "EVICE: Allow me to\ndrop the act.",
    win = "Ho ho... how\nvery irritating.",
    loss = "Ho ho ho! Nothing\npersonal, child.",
    afterWin = "EVICE: Smile and\nwave. Smile and\fwave.",
    afterLoss = "EVICE: Re-elect\nme, won't you?",
    party = { { species = "SLOWKING",  delta = 0 },
              { species = "MACHAMP",   delta = 0 },
              { species = "TYRANITAR", delta = 1 } } },

  { key = "GONZAP", tier = 3, class = "HIKER", member = "RUSSELL",
    sprite = "SPRITE_BLACK_BELT", name = "GONZAP",
    chat = "GONZAP: SNAGEM\ntakes what it\fwants.",
    intro = "GONZAP: Crush\nthem!",
    win = "Bah! Keep your\ntrinkets.",
    loss = "Consider yourself\nsnagged.",
    afterWin = "GONZAP: WES put\nyou up to this?!",
    afterLoss = "GONZAP: ORRE's\nfinest, kid.",
    party = { { species = "NIDOKING", delta = 0 },
              { species = "RHYDON",   delta = 0 },
              { species = "SKARMORY", delta = 1 } } },

  { key = "GUZMA", tier = 3, class = "BIKER", member = "ZEKE",
    sprite = "SPRITE_BIKER", name = "GUZMA",
    chat = "GUZMA: Y'all know\nwho it is.",
    intro = "GUZMA: It's your\nboy! Beat down\ftime!",
    win = "What is wrong\nwith me?!",
    loss = "Big bad GUZMA,\nthat's who.",
    afterWin = "GUZMA: Tch. Bugs\ncrawl back up.",
    afterLoss = "GUZMA: SKULL runs\nthis room now.",
    party = { { species = "ARIADOS", delta = 0 },
              { species = "PINSIR",  delta = 0 },
              { species = "SCIZOR",  delta = 1 } } },

  -- HIKER also really has a MICHAEL, so the XD kid keeps his name; only
  -- the class title is off, and the overworld sprite stays a youth.
  { key = "MICHAEL", tier = 3, class = "HIKER", member = "MICHAEL",
    sprite = "SPRITE_IPC_MICHAEL", name = "MICHAEL",
    chat = "MICHAEL: I can see\nwhat you can't.",
    intro = "MICHAEL: For ORRE!",
    win = "There's light in\nthis loss too.",
    loss = "The shadows never\nstood a chance.",
    afterWin = "MICHAEL: JOLTEON,\nback to training.",
    afterLoss = "MICHAEL: Snagged\nthat win cleanly.",
    party = { { species = "URSARING", delta = 0 },
              { species = "HOUNDOOM", delta = 0 },
              { species = "JOLTEON",  delta = 1 } } },

  { key = "KUKUI", tier = 3, class = "SWIMMERM", member = "CHARLIE",
    sprite = "SPRITE_SWIMMER_GUY", name = "KUKUI",
    chat = "KUKUI: Moves tell\nstories, yeah!",
    intro = "KUKUI: Hit me\nwith your best!",
    win = "Oh yeah! THAT's\nthe move I wanted!",
    loss = "Research results:\nI'm still tough!",
    afterWin = "KUKUI: Felt every\nhit. Loved it.",
    afterLoss = "KUKUI: Take notes,\ncousin!",
    party = { { species = "FEAROW",     delta = 0 },
              { species = "SUDOWOODO",  delta = 0 },
              { species = "TYPHLOSION", delta = 1 } } },

  { key = "LAWRENCE", tier = 3, class = "GENTLEMAN", member = "GREGORY",
    sprite = "SPRITE_GENTLEMAN", name = "LAWRENCE",
    chat = "LAWRENCE: My\ncollection lacks\fone thing. You.",
    intro = "LAWRENCE: Consider\nthis an appraisal.",
    win = "Some things can't\nbe collected...",
    loss = "A fine addition\nto my collection.",
    afterWin = "LAWRENCE: It began\nwith one card...",
    afterLoss = "LAWRENCE: Mint\ncondition victory.",
    party = { { species = "PORYGON",    delta = 0 },
              { species = "AERODACTYL", delta = 0 },
              { species = "MOLTRES",    delta = 1 } } },

  { key = "MOLLY", tier = 3, class = "LASS", member = "ELLEN",
    sprite = "SPRITE_LASS", name = "MOLLY",
    chat = "MOLLY: In my house\nwishes come true.",
    intro = "MOLLY: Papa says\nI can win!",
    win = "That's not how\nI dreamed it...",
    loss = "Yay! Just like\nin my dream!",
    afterWin = "MOLLY: The UNOWN\nlike you. I think.",
    afterLoss = "MOLLY: Wanna live\nin my crystal\fcastle?",
    party = { { species = "PHANPY",    delta = 0 },
              { species = "FLAAFFY",   delta = 0 },
              { species = "ENTEI",     delta = 1 } } },

  -- ================== CLEARED CUSTOM-ART ROSTER ==================
  -- These appended guests use private sprite records plus the same
  -- positively gated runtime party path as the core roster.
  { key = "DAWN", tier = 2, class = "PICNICKER", member = "HOPE",
    sprite = "SPRITE_IPC_DAWN", name = "DAWN",
    chat = "DAWN: No need to\nworry!",
    intro = "DAWN: Spotlight on!",
    win = "We'll polish our\nperformance.",
    loss = "That's how we shine!",
    afterWin = "DAWN: We'll make\na comeback.",
    afterLoss = "DAWN: Great show,\neveryone!",
    party = { { species = "TOTODILE",  delta = 0 },
              { species = "PIKACHU",   delta = 0 },
              { species = "AZUMARILL", delta = 1 } } },

  { key = "LYRA", tier = 2, class = "PICNICKER", member = "GINA1",
    sprite = "SPRITE_IPC_LYRA", name = "LYRA",
    chat = "LYRA: JOHTO feels\nlike home!",
    intro = "LYRA: Let's go,\nMARILL!",
    win = "That was a great\nadventure!",
    loss = "We make a great\nteam!",
    afterWin = "LYRA: We'll train\non the next route.",
    afterLoss = "LYRA: MARILL is\nstill bouncing!",
    party = { { species = "MARILL",   delta = 0 },
              { species = "TOGETIC", delta = 0 },
              { species = "MEGANIUM", delta = 1 } } },

  { key = "MAY", tier = 2, class = "BEAUTY", member = "VICTORIA",
    sprite = "SPRITE_IPC_MAY", name = "MAY",
    chat = "MAY: This arena is\nperfect for a show!",
    intro = "MAY: Let's dazzle\nthe judges!",
    win = "That was still a\ngreat performance.",
    loss = "A perfect finish!",
    afterWin = "MAY: We'll work on\nour combinations.",
    afterLoss = "MAY: The crowd\nloved it!",
    party = { { species = "BUTTERFREE", delta = 0 },
              { species = "SNORLAX",    delta = 0 },
              { species = "TYPHLOSION", delta = 1 } } },

  { key = "STADIUM_PLAYER", tier = 2, class = "COOLTRAINERM", member = "RYAN",
    sprite = "SPRITE_IPC_STADIUM_PLAYER", name = "STADIUM TRAINER",
    chat = "STADIUM TRAINER:\nRental team ready!",
    intro = "STADIUM TRAINER:\nBattle mode: GO!",
    win = "Great match!\nBack to selection.",
    loss = "Victory on the\nbig screen!",
    afterWin = "STADIUM TRAINER:\nNew rentals next time.",
    afterLoss = "STADIUM TRAINER:\nChallenge complete!",
    party = { { species = "PIKACHU",  delta = 0 },
              { species = "CHARIZARD", delta = 0 },
              { species = "BLASTOISE", delta = 1 } } },

  { key = "BRENDAN", tier = 3, class = "COOLTRAINERM", member = "RYAN",
    sprite = "SPRITE_IPC_BRENDAN", name = "BRENDAN",
    chat = "BRENDAN: JOHTO has\ngreat terrain!",
    intro = "BRENDAN: Let's see\nhow we compare!",
    win = "You're something else!",
    loss = "HOENN training\npaid off!",
    afterWin = "BRENDAN: Back to\nfieldwork.",
    afterLoss = "BRENDAN: That was\na useful survey!",
    party = { { species = "MEGANIUM",  delta = 0 },
              { species = "FEAROW",    delta = 0 },
              { species = "DRAGONITE", delta = 1 } } },

  { key = "HILBERT", tier = 3, class = "COOLTRAINERM", member = "NICK",
    sprite = "SPRITE_IPC_HILBERT", name = "HILBERT",
    chat = "HILBERT: I've crossed\nUNOVA for battles.",
    intro = "HILBERT: Let's see\nwhose bond is stronger!",
    win = "You earned that win.",
    loss = "We trained for this!",
    afterWin = "HILBERT: I'll keep\nsearching and training.",
    afterLoss = "HILBERT: Good battle.\nNo regrets.",
    party = { { species = "HOUNDOOM",   delta = 0 },
              { species = "SCIZOR",     delta = 0 },
              { species = "FERALIGATR", delta = 1 } } },

  { key = "HILDA", tier = 3, class = "COOLTRAINERF", member = "GWEN",
    sprite = "SPRITE_IPC_HILDA", name = "HILDA",
    chat = "HILDA: I came here\nto battle hard!",
    intro = "HILDA: Try and stop us!",
    win = "Now that was intense!",
    loss = "We never slow down!",
    afterWin = "HILDA: A rematch\nwould be even better.",
    afterLoss = "HILDA: That's the\nenergy I wanted!",
    party = { { species = "HITMONTOP",  delta = 0 },
              { species = "ESPEON",     delta = 0 },
              { species = "TYPHLOSION", delta = 1 } } },

  { key = "ROSA", tier = 3, class = "COOLTRAINERF", member = "GWEN",
    sprite = "SPRITE_IPC_ROSA", name = "ROSA",
    chat = "ROSA: Ready for a\nUNOVA-style battle?",
    intro = "ROSA: All three,\nshow your spirit!",
    win = "That was amazing!",
    loss = "UNOVA training\npaid off!",
    afterWin = "ROSA: We'll try a\nnew strategy.",
    afterLoss = "ROSA: What a\nperfect team!",
    party = { { species = "MEGANIUM",  delta = 0 },
              { species = "TYPHLOSION", delta = 0 },
              { species = "FERALIGATR", delta = 1 } } },

  { key = "BEA", tier = 3, class = "BLACKBELT_T", member = "YOSHI",
    sprite = "SPRITE_IPC_BEA", name = "BEA",
    chat = "BEA: Discipline\nwins battles.",
    intro = "BEA: Show me your\nstrongest stance!",
    win = "Your focus did\nnot waver.",
    loss = "Strength follows\ndiscipline.",
    afterWin = "BEA: I will train\nwith greater focus.",
    afterLoss = "BEA: A clean and\ndecisive match.",
    party = { { species = "HITMONTOP", delta = 0 },
              { species = "PRIMEAPE",  delta = 0 },
              { species = "MACHAMP",   delta = 1 } } },

  { key = "MINA", tier = 2, class = "BEAUTY", member = "SAMANTHA",
    sprite = "SPRITE_IPC_MINA", name = "MINA",
    chat = "MINA: This arena\nneeds more color.",
    intro = "MINA: Let's paint\na great battle!",
    win = "That composition\nwas surprising.",
    loss = "A bright finish!",
    afterWin = "MINA: I'll sketch\nthat last move.",
    afterLoss = "MINA: Perfect!\nHold that pose.",
    party = { { species = "WIGGLYTUFF", delta = 0 },
              { species = "MR__MIME",   delta = 0 },
              { species = "CLEFABLE",   delta = 1 } } },

  { key = "NATE", tier = 3, class = "COOLTRAINERM", member = "AARON",
    sprite = "SPRITE_IPC_NATE", name = "NATE",
    chat = "NATE: UNOVA sent\nits next challenger!",
    intro = "NATE: Let's make\nthis a big match!",
    win = "You read every\nmove I made.",
    loss = "That's a win for\nUNOVA!",
    afterWin = "NATE: Time for\na new strategy.",
    afterLoss = "NATE: What a\nchampionship battle!",
    party = { { species = "FEAROW",     delta = 0 },
              { species = "TYPHLOSION", delta = 0 },
              { species = "DRAGONITE",  delta = 1 } } },

  -- TODO/CONFIRM on device: the Gen III walking source keeps its native
  -- hair/face rows while selected torso/leg rows are removed for 16x16 Gold.
  { key = "ROXIE", tier = 3, class = "JANINE", member = "JANINE1",
    sprite = "SPRITE_IPC_ROXIE", name = "ROXIE",
    chat = "ROXIE: Turn it up!\nPoison has rhythm.",
    intro = "ROXIE: Get ready!\nThis set bites!",
    win = "That finish hit\nlike an encore!",
    loss = "Poison, tempo,\nand total control!",
    afterWin = "ROXIE: Nice one.\nPlay it louder!",
    afterLoss = "ROXIE: The crowd\nknows a knockout!",
    party = { { species = "KOFFING", delta = 0 },
              { species = "MUK",     delta = 0 },
              { species = "CROBAT",  delta = 1 } } },

  -- TODO/CONFIRM on device: Piers uses Drawnamu's upper-body figure crop so
  -- his face, hair, arm and microphone remain readable in Gold's 56x56 slot.
  { key = "PIERS", tier = 3, class = "JANINE", member = "JANINE1",
    sprite = "SPRITE_IPC_PIERS", name = "PIERS",
    chat = "PIERS: No gimmicks.\nJust battle.",
    intro = "PIERS: Let's make\nthis crowd roar!",
    win = "Now that was a\nperformance!",
    loss = "No encore needed.\nThat settled it.",
    afterWin = "PIERS: Not bad.\nKeep your edge.",
    afterLoss = "PIERS: Hear that?\nThey know who won.",
    party = { { species = "UMBREON",  delta = 0 },
              { species = "SNEASEL",  delta = 0 },
              { species = "HOUNDOOM", delta = 1 } } },

  { key = "JESSIE_JAMES", tier = 2, class = "EXECUTIVEM", member = "EXECUTIVEM_1",
    sprite = "SPRITE_ROCKET_GIRL", name = "JESSIE & JAMES",
    chat = "JESSIE & JAMES:\nPrepare for trouble!",
    intro = "JESSIE & JAMES:\nMake it double!",
    win = "Team Rocket's\nblasting off again!",
    loss = "A brilliant win\nfor Team Rocket!",
    afterWin = "JESSIE & JAMES:\nWe'll be back!",
    afterLoss = "JESSIE & JAMES:\nWhat a rare victory!",
    party = { { species = "ARBOK",   delta = 0 },
              { species = "WEEZING", delta = 0 },
              { species = "MEOWTH",  delta = 1 } } },

  { key = "GIOVANNI", tier = 4, customMember = true,
    class = "EXECUTIVEM", member = "EXECUTIVEM_2",
    sprite = "SPRITE_IPC_GIOVANNI", name = "GIOVANNI",
    chat = "GIOVANNI: Power\nis its own reward.",
    intro = "GIOVANNI: Witness\nTeam Rocket's might!",
    win = "So. You are no\nordinary trainer.",
    loss = "This is the power\nof Team Rocket.",
    afterWin = "GIOVANNI: We will\nmeet again.",
    afterLoss = "GIOVANNI: Loyalty\nfollows strength.",
    party = { { species = "PERSIAN",  delta = 0 },
              { species = "NIDOKING", delta = 0 },
              { species = "RHYDON",   delta = 1 } } },

  -- TODO/CONFIRM on device: the MOLLY source grid is unlabeled; cell r5c6
  -- is the Oak-like lab-coat portrait selected for this test build.
  { key = "OAK", tier = 4, customMember = true,
    class = "SCIENTIST", member = "ROSS",
    sprite = "SPRITE_OAK", name = "OAK",
    chat = "OAK: Your journey\nhas taught you much.",
    intro = "OAK: Let me see\nhow far you've come!",
    win = "Remarkable! You\nkeep surprising me.",
    loss = "Experience still\nhas its advantages.",
    afterWin = "OAK: There is\nalways more to learn.",
    afterLoss = "OAK: A fine study\nin preparation.",
    party = { { species = "TAUROS",     delta = 0 },
              { species = "EXEGGUTOR",  delta = 0 },
              { species = "VENUSAUR",   delta = 1 } } },

  { key = "LORELEI", tier = 4, customMember = true,
    class = "COOLTRAINERF", member = "LOIS",
    sprite = "SPRITE_IPC_LORELEI", name = "LORELEI",
    chat = "LORELEI: Ice can\nbe beautiful and cruel.",
    intro = "LORELEI: Your run\nends in deep freeze!",
    win = "Your spirit would\nnot be frozen.",
    loss = "Nothing survives\nthe perfect freeze.",
    afterWin = "LORELEI: I will\nrefine my strategy.",
    afterLoss = "LORELEI: Cold,\ncalm and complete.",
    party = { { species = "DEWGONG",  delta = 0 },
              { species = "CLOYSTER", delta = 0 },
              { species = "LAPRAS",   delta = 1 } } },

  { key = "AGATHA", tier = 4, customMember = true,
    class = "MEDIUM", member = "MARTHA",
    sprite = "SPRITE_IPC_AGATHA", name = "AGATHA",
    chat = "AGATHA: Old tricks\nare often the best.",
    intro = "AGATHA: Come, child.\nMeet my shadows!",
    win = "Hah! You have more\nspirit than I thought.",
    loss = "Your courage fades\nlike all the rest.",
    afterWin = "AGATHA: I am not\nfinished with you.",
    afterLoss = "AGATHA: The dark\nkeeps its secrets.",
    party = { { species = "ARBOK",  delta = 0 },
              { species = "CROBAT", delta = 0 },
              { species = "GENGAR", delta = 1 } } },

  { key = "ROCKET_EXECUTIVE", tier = 3,
    class = "EXECUTIVEM", member = "EXECUTIVEM_1",
    sprite = "SPRITE_IPC_ROCKET_EXECUTIVE", name = "ROCKET EXECUTIVE",
    chat = "EXECUTIVE: This\noperation is classified.",
    intro = "EXECUTIVE: Team\nRocket takes control!",
    win = "This setback will\nbe dealt with.",
    loss = "Exactly according\nto the plan.",
    afterWin = "EXECUTIVE: You\nsaw nothing here.",
    afterLoss = "EXECUTIVE: The\noperation continues.",
    party = { { species = "GOLBAT",   delta = 0 },
              { species = "RATICATE", delta = 0 },
              { species = "HOUNDOOM", delta = 1 } } },

  { key = "ARCHER", tier = 4, customMember = true,
    class = "EXECUTIVEM", member = "EXECUTIVEM_2",
    sprite = "SPRITE_IPC_ARCHER", name = "ARCHER",
    chat = "ARCHER: Team Rocket\nwill rise again.",
    intro = "ARCHER: Witness\nour restored power!",
    win = "I underestimated\nyour resolve.",
    loss = "Team Rocket's\nreturn is inevitable.",
    afterWin = "ARCHER: This is\nonly a delay.",
    afterLoss = "ARCHER: Our\nfuture is assured.",
    party = { { species = "WEEZING",  delta = 0 },
              { species = "CROBAT",   delta = 0 },
              { species = "HOUNDOOM", delta = 1 } } },

  { key = "ARIANA", tier = 4, customMember = true,
    class = "EXECUTIVEF", member = "EXECUTIVEF_1",
    sprite = "SPRITE_IPC_ARIANA", name = "ARIANA",
    chat = "ARIANA: Loyalty\nis rewarded here.",
    intro = "ARIANA: Kneel\nbefore Team Rocket!",
    win = "Such insolence...\nHow irritating.",
    loss = "A graceful victory\nfor Team Rocket.",
    afterWin = "ARIANA: Enjoy\nyour little triumph.",
    afterLoss = "ARIANA: Know\nyour proper place.",
    party = { { species = "ARBOK",     delta = 0 },
              { species = "VILEPLUME", delta = 0 },
              { species = "MURKROW",   delta = 1 } } },

  { key = "PROTON", tier = 2,
    class = "EXECUTIVEM", member = "EXECUTIVEM_3",
    sprite = "SPRITE_IPC_PROTON", name = "PROTON",
    chat = "PROTON: They call\nme the scary one.",
    intro = "PROTON: Let's make\nthis unpleasant!",
    win = "You got lucky.\nVery lucky.",
    loss = "Scared yet? You\nshould be.",
    afterWin = "PROTON: Next time\nI won't play nice.",
    afterLoss = "PROTON: That was\nproperly frightening.",
    party = { { species = "RATICATE", delta = 0 },
              { species = "GOLBAT",   delta = 0 },
              { species = "WEEZING",  delta = 1 } } },

  { key = "PETREL", tier = 2,
    class = "EXECUTIVEM", member = "EXECUTIVEM_4",
    sprite = "SPRITE_IPC_PETREL", name = "PETREL",
    chat = "PETREL: Which face\nshould I wear today?",
    intro = "PETREL: The joke\nis on you!",
    win = "Even I didn't see\nthat coming.",
    loss = "Ha! Fooled you\nfrom the start.",
    afterWin = "PETREL: I'll need\na better disguise.",
    afterLoss = "PETREL: Never\ntrust the obvious face.",
    party = { { species = "KOFFING", delta = 0 },
              { species = "MUK",     delta = 0 },
              { species = "WEEZING", delta = 1 } } },

  { key = "ROCKET_GRUNT_M", tier = 1,
    class = "GRUNTM", member = "GRUNTM_1",
    sprite = "SPRITE_IPC_ROCKET_GRUNT_M", name = "ROCKET GRUNT",
    chat = "GRUNT: Hey! This\nround belongs to us!",
    intro = "GRUNT: Team Rocket,\nattack!",
    win = "I knew this job\nwas trouble!",
    loss = "Promotion, here\nI come!",
    afterWin = "GRUNT: Don't tell\nthe executives.",
    afterLoss = "GRUNT: Finally,\nsome recognition!",
    party = { { species = "RATTATA", delta = 0 },
              { species = "ZUBAT",   delta = 0 },
              { species = "KOFFING", delta = 1 } } },

  { key = "ROCKET_GRUNT_F", tier = 1,
    class = "GRUNTF", member = "GRUNTF_1",
    sprite = "SPRITE_IPC_ROCKET_GRUNT_F", name = "ROCKET GRUNT",
    chat = "GRUNT: The uniform\nmeans business.",
    intro = "GRUNT: Hand over\nthat victory!",
    win = "The boss won't\nlike this...",
    loss = "Another win for\nTeam Rocket!",
    afterWin = "GRUNT: I need\na stronger assignment.",
    afterLoss = "GRUNT: That ought\nto earn a promotion.",
    party = { { species = "EKANS",   delta = 0 },
              { species = "GLOOM",   delta = 0 },
              { species = "MURKROW", delta = 1 } } },

  -- ================== TIER 4 (named classes) ==================
  -- Real name AND real portrait, no carrier compromise.
  { key = "BROCK", tier = 4, class = "BROCK", member = "BROCK1",
    sprite = "SPRITE_BROCK", name = "BROCK",
    chat = "BROCK: The rock\nwork in here is\ftop quality.",
    intro = "BROCK: PEWTER's\nleader, out here?\fI travel too.",
    win  = "Rock solid.\fPEWTER would be\nproud of that.",
    loss = "Sunk like a stone.\fTrain harder.",
    afterWin  = "BROCK: Go say hi\nto MISTY for me.",
    afterLoss = "BROCK: Defense\nwins matches.",
    party = { { species = "GRAVELER", delta = -1 },
              { species = "RHYHORN", delta = 0 },
              { species = "GOLEM", delta = 0 },
              { species = "OMASTAR", delta = 0 },
              { species = "KABUTOPS", delta = 0 },
              { species = "ONIX", delta = 1 } } },

  { key = "BLAINE", tier = 4, class = "BLAINE", member = "BLAINE1",
    sprite = "SPRITE_BLAINE", name = "BLAINE",
    chat = "BLAINE: Quiz time!\nWho wins today?",
    intro = "BLAINE: The answer\nis FIRE! Always!",
    win = "Correct answer!\nWrong old man.",
    loss = "Too hot to\nhandle! Hot! HOT!",
    afterWin = "BLAINE: A burning\nquestion: rematch?",
    afterLoss = "BLAINE: Pop quiz:\nwho's still king?",
    party = { { species = "PONYTA",   delta = -1 },
              { species = "MAGCARGO", delta = 0 },
              { species = "MAGMAR",   delta = 0 },
              { species = "NINETALES", delta = 0 },
              { species = "FLAREON",  delta = 0 },
              { species = "RAPIDASH", delta = 1 } } },

  { key = "MISTY", tier = 4, class = "MISTY", member = "MISTY1",
    sprite = "SPRITE_MISTY", name = "MISTY",
    chat = "MISTY: Finally, a\nreal challenger.",
    intro = "MISTY: The tide is\ncoming in!",
    win = "Washed out...\nthis once.",
    loss = "The tomboyish\nmermaid strikes!",
    afterWin = "MISTY: My STARMIE\ndemands a rematch.",
    afterLoss = "MISTY: Don't be a\nbaby about it.",
    party = { { species = "POLIWHIRL", delta = -1 },
              { species = "GOLDUCK",  delta = 0 },
              { species = "QUAGSIRE", delta = 0 },
              { species = "LAPRAS",   delta = 0 },
              { species = "TOGETIC",  delta = 0 },
              { species = "STARMIE",  delta = 1 } } },

  { key = "SABRINA", tier = 4, class = "SABRINA", member = "SABRINA1",
    sprite = "SPRITE_SABRINA", name = "SABRINA",
    chat = "SABRINA: I knew\nyou'd say that.",
    intro = "SABRINA: I have\nforeseen my win.",
    win = "...The future\ncan be rewritten.",
    loss = "Just as I\nforesaw.",
    afterWin = "SABRINA: Enjoy it.\nI already have.",
    afterLoss = "SABRINA: Your next\nloss comes soon.",
    -- MR__MIME: two underscores in Gold's species table. Verified; the
    -- single-underscore spelling fails silently.
    party = { { species = "WIGGLYTUFF", delta = -1 },
              { species = "SLOWBRO",  delta = 0 },
              { species = "HYPNO",    delta = 0 },
              { species = "ESPEON",   delta = 0 },
              { species = "MR__MIME", delta = 0 },
              { species = "ALAKAZAM", delta = 1 } } },

  { key = "KAREN", tier = 4, class = "KAREN", member = "KAREN1",
    sprite = "SPRITE_KAREN", name = "KAREN",
    chat = "KAREN: Win with\nyour favorites.",
    intro = "KAREN: Show me\nwhat you love.",
    win = "You fight like\nyou mean it.",
    loss = "Try again with\nPOKeMON you love.",
    afterWin = "KAREN: My UMBREON\nwants a rematch.",
    afterLoss = "KAREN: Don't sulk.\nIt's unbecoming.",
    party = { { species = "VILEPLUME", delta = -1 },
              { species = "VICTREEBEL", delta = 0 },
              { species = "MURKROW",  delta = 0 },
              { species = "GENGAR",   delta = 0 },
              { species = "HOUNDOOM", delta = 0 },
              { species = "UMBREON",  delta = 1 } } },

  { key = "BRUNO", tier = 4, class = "BRUNO", member = "BRUNO1",
    sprite = "SPRITE_BRUNO", name = "BRUNO",
    chat = "BRUNO: I train\nhere too. Louder.",
    intro = "BRUNO: HOO HAH!\nWe hone our fists!",
    win = "We will train\neven harder!",
    loss = "HOO HAH! The\nmountain stands!",
    afterWin = "BRUNO: A worthy\nsparring partner.",
    afterLoss = "BRUNO: Push-ups.\nOne thousand. Go.",
    party = { { species = "HITMONLEE",  delta = 0 },
              { species = "HITMONCHAN", delta = 0 },
              { species = "HERACROSS",  delta = 0 },
              { species = "GOLEM",      delta = 0 },
              { species = "ONIX",       delta = 0 },
              { species = "MACHAMP",    delta = 1 } } },

  { key = "CLAIR", tier = 4, class = "CLAIR", member = "CLAIR1",
    sprite = "SPRITE_CLAIR", name = "CLAIR",
    chat = "CLAIR: You're in\nthe wrong room.",
    intro = "CLAIR: I am the\nworld's best. Bow.",
    win = "This changes\nNOTHING.",
    loss = "As expected of\nthe world's best.",
    afterWin = "CLAIR: A fluke.\nA total fluke.",
    afterLoss = "CLAIR: Go earn my\ncousin's respect.",
    party = { { species = "DRATINI",   delta = -1 },
              { species = "DRAGONAIR", delta = 0 },
              { species = "DRAGONAIR", delta = 0 },
              { species = "DRAGONAIR", delta = 0 },
              { species = "GYARADOS",  delta = 0 },
              { species = "KINGDRA",   delta = 1 } } },

  { key = "LANCE", tier = 4, class = "CHAMPION", member = "LANCE",
    sprite = "SPRITE_LANCE", name = "LANCE",
    chat = "LANCE: The best\ngather here now.",
    intro = "LANCE: I will not\nhold back!",
    win = "You could stand\namong champions.",
    loss = "Train. Then find\nme again.",
    afterWin = "LANCE: The league\nwill hear of you.",
    afterLoss = "LANCE: DRAGONITE\nbarely warmed up.",
    party = { { species = "GYARADOS",   delta = 0 },
              { species = "DRAGONITE",  delta = 0 },
              { species = "DRAGONITE",  delta = 0 },
              { species = "AERODACTYL", delta = 0 },
              { species = "CHARIZARD",  delta = 0 },
              { species = "DRAGONITE",  delta = 1 } } },

  { key = "BLUE", tier = 4, class = "BLUE", member = "BLUE1",
    sprite = "SPRITE_BLUE", name = "BLUE",
    chat = "BLUE: Took you\nlong enough.",
    intro = "BLUE: I don't do\nwarm-ups. Come on.",
    win = "Alright, hotshot.\nEnjoy it.",
    loss = "Smell ya later,\nchamp.",
    afterWin = "BLUE: VIRIDIAN is\nopen. If you dare.",
    afterLoss = "BLUE: Gramps would\nlaugh at that one.",
    party = { { species = "PIDGEOT",  delta = 0 },
              { species = "EXEGGUTOR", delta = 0 },
              { species = "ALAKAZAM", delta = 0 },
              { species = "ARCANINE", delta = 0 },
              { species = "GYARADOS", delta = 0 },
              { species = "RHYDON",   delta = 1 } } },

  -- RED never speaks. All six lines are silence, per the design pass.
  { key = "RED", tier = 4, class = "RED", member = "RED1",
    sprite = "SPRITE_RED", name = "RED",
    chat = "RED: ...",
    intro = "RED: ...!",
    win = "......",
    loss = "...",
    afterWin = "RED: ... ...!",
    afterLoss = "RED: ...",
    party = { { species = "CHARIZARD", delta = 0 },
              { species = "BLASTOISE", delta = 0 },
              { species = "VENUSAUR",  delta = 0 },
              { species = "ESPEON",    delta = 0 },
              { species = "SNORLAX",   delta = 0 },
              { species = "PIKACHU",   delta = 2 } } },
  }

  -- key -> entry, and tier -> list of keys, for the draw
  local BY_KEY, TIERS = {}, { {}, {}, {}, {} }
  for _, foe in ipairs(ROSTER) do
    BY_KEY[foe.key] = foe
    local t = TIERS[foe.tier]
    t[#t + 1] = foe.key
  end

  ----------------------------------------------------------------------
  -- REAL BATTLE NAMES (0.9.1). Until now a carried challenger battled as
  -- their carrier -- "COOLTRAINER NICK" instead of WES -- because
  -- def.trainer pointed at a VANILLA member row and the HUD reads that
  -- row's name.
  --
  -- The fix is to give each of them a member row of their own. The Gen 2
  -- trainers registry accepts a `trainers` list whose members carry their
  -- own name and party (Schemas.lua gen2Fields), and a PATCH folds through
  -- Merge.deepMerge, which unwraps the documented `__append` wrapper
  -- (Merge.lua:37-48). So appending leaves every vanilla row -- and every
  -- vanilla row's INDEX -- untouched: no existing trainer in Gold changes.
  -- A bare `trainers = {...}` would have replaced the list and quietly
  -- deleted them, which is why the wrapper matters.
  --
  -- What the player sees is "<CLASS TITLE> <OUR NAME>": the class's `name`
  -- field is the title (Brock's class is literally named LEADER, hence
  -- "LEADER BROCK"), the member's `name` is personal. So Wes becomes
  -- "COOLTRAINER WES" -- generic title, correct name, and the portrait
  -- still resolves because the CLASS is still a vanilla one. Registering a
  -- brand-new class would have given a perfect title and NO portrait at
  -- all: trainerPics is keyed by class constant off gen2MenuGfx, which no
  -- registry targets.
  --
  -- Vanilla tier 4 entries are untouched because their real named members
  -- already are the characters. Cleared-art tier 4 guests opt in with
  -- customMember so their appended identity is private and additive too.
  --
  -- The party written here is a FALLBACK at a nominal level; trainer.party
  -- still substitutes the leader-anchored, level-scaled team at battle
  -- time. Two jobs, cleanly split: the registry owns identity, the hook
  -- owns numbers.
  ----------------------------------------------------------------------
  do
    local appends = {}
    for _, foe in ipairs(ROSTER) do
      if foe.tier < 4 or foe.customMember then
        -- the vanilla member each entry was written with becomes the
        -- FALLBACK: if the append ever fails to land (an engine change to
        -- the wrapper, a merge conflict), resolveCarrier finds this instead
        -- and the battle happens under the carrier's name -- degraded, not
        -- broken. Losing the name is survivable; losing the battle is not.
        foe.fallbackMember = foe.member
        foe.member = "IPC_" .. foe.key
        local party = {}
        for _, row in ipairs(foe.party) do
          party[#party + 1] = { species = row.species, level = 30 }
        end
        local rows = appends[foe.class]
        if not rows then rows = {}; appends[foe.class] = rows end
        rows[#rows + 1] = {
          id = foe.member,
          name = foe.name,
          trainerType = "TRAINERTYPE_NORMAL",
          party = party,
        }
      end
    end
    for class, rows in pairs(appends) do
      mod.content.trainers:patch(class, { trainers = { __append = rows } })
    end
  end

  -- LEVELS COME FROM THE TOWN'S GYM LEADER, not from the player.
  --
  -- Scaling to the player's party (0.2.1-0.3.3) worked but made the circuit
  -- rubber-band: it could never be too hard or too easy, so beating it said
  -- nothing. Anchoring to the local gym instead gives each venue a fixed,
  -- knowable difficulty that sits just above the badge you needed to enter
  -- it -- and it stays consistent town to town by construction.
  --
  -- Read from the leader's OWN party in the live trainer data rather than
  -- written down here. Their levels are ROM content; a table of numbers in
  -- this file would be four guessed constants that rot silently the moment
  -- anything rebalances them.
  local LEADER_STEP = 2      -- the circuit sits this far above the gym
  local ROUND_STEP = 2       -- and each round climbs this much again

  -- Forward declaration. venue() is defined further down with the run state,
  -- and levelBase below calls it: without this the call would compile
  -- against a nil global and the leader anchor would silently never apply.
  -- Assigned there as `venue = function()`, NOT `local function venue()`,
  -- which would create a second local and leave this one nil forever.
  local venue
  -- round() is likewise defined with the run state below; levelBase reads
  -- the CURRENT round now that a challenger's tier no longer fixes their
  -- position (the same character could headline different tiers later)
  local round

  local function leaderTop(class)
    local td = mod.game and mod.game.data and mod.game.data.gen2Trainers
    local cls = td and td.classes and td.classes[class]
    local row = cls and cls.trainers and cls.trainers[1]
    local best
    for _, mon in ipairs((row and row.party) or {}) do
      local l = tonumber(mon and mon.level)
      if l and (not best or l > best) then best = l end
    end
    return best
  end

  -- Returns nil when the anchor cannot be read. Callers must DECLINE, not
  -- substitute.
  --
  -- 0.9.8 deleted a fallback here that walked save.party for the player's
  -- top level and returned it raw. Two things were wrong with it and the
  -- second is worse than the first:
  --
  --   1. It scaled challengers to the player -- the rubber-banding removed
  --      in 0.4.0, reappearing as an error path. The developer's position
  --      is "not a fan of level scaling", and a circuit that matches you
  --      cannot be too hard or too easy, so winning proves nothing.
  --   2. It returned the raw level with NO LEADER_STEP and NO round climb,
  --      so every round came out flat at roughly the player's own level.
  --      Round 4 was as easy as round 1.
  --
  -- And it announced itself only through a probe row -- which goes
  -- invisible the moment diagnostic rows default off for 1.0.0. A silently
  -- flattened, player-scaled bracket is indistinguishable from a working
  -- one until someone notices the tournament is trivial. Declining is
  -- diagnosable; substituting is not.
  --
  -- Reachability: the no-venue half is now unreachable from the host --
  -- talkHost refuses outright without a venue (0.9.6) -- so the live
  -- trigger is leaderTop returning nil: a wrong class constant, another
  -- mod replacing gen2Trainers, or the data shape moving under an engine
  -- update. Rare, and exactly the kind of thing that must not fail quietly.
  local function levelBase(foe)
    local v = venue()
    local top = v and v.leader and leaderTop(v.leader)
    if not top then
      probe("NO ANCHOR\n%s", tostring(v and v.leader or "no venue"))
      return nil
    end
    return top + LEADER_STEP + (((foe.tier or round()) - 1) * ROUND_STEP)
  end

  local function scaled(foe)
    local base = levelBase(foe)
    if not base then return nil end   -- no anchor: decline, never guess
    local out = {}
    for _, row in ipairs(foe.party) do
      local lv = base + (row.delta or 0)
      if lv < 2 then lv = 2 elseif lv > 100 then lv = 100 end
      out[#out + 1] = { species = row.species, level = lv }
    end
    return out
  end

  for _, foe in ipairs(ROSTER) do
    foe.seenKey = "IPC_SEEN_" .. foe.key
    foe.winKey  = "IPC_WIN_"  .. foe.key
    foe.lossKey = "IPC_LOSS_" .. foe.key
    mod.content.text:register(foe.seenKey, foe.intro)
    -- each challenger's own voice at the battle's end; the elimination
    -- rule itself is the ANNOUNCER's line on the way out, so the
    -- characters stay characters
    mod.content.text:register(foe.winKey,  foe.win or "...Well fought.")
    mod.content.text:register(foe.lossKey, foe.loss or "Better luck\nnext time.")
  end

  ----------------------------------------------------------------------
  -- Venues, keyed by the centre whose stairs were climbed. Map ids from
  -- rom_manifest_gold.json, badge keys from Battle.lua:193.
  ----------------------------------------------------------------------
  local VENUES = {
    VIOLET_POKECENTER_1F     = { town = "VIOLET",     title = "QUALIFIER",    leader = "FALKNER" },
    GOLDENROD_POKECENTER_1F  = { town = "GOLDENROD",  title = "OPEN",         leader = "WHITNEY" },
    ECRUTEAK_POKECENTER_1F   = { town = "ECRUTEAK",   title = "INVITATIONAL", leader = "MORTY" },
    BLACKTHORN_POKECENTER_1F = { town = "BLACKTHORN", title = "MASTERS",      leader = "CLAIR" },
    INDIGO_PLATEAU_POKECENTER_1F = { town = "INDIGO PLATEAU",
                                     title = "CONFERENCE", leader = "CHAMPION" },
  }


  ----------------------------------------------------------------------
  -- Diagnostics. mod.log needs a console that does not exist on iOS;
  -- Runtime.reportError renders in the manager's [ERRS] screen.
  ----------------------------------------------------------------------
  local function errs(fmt, ...)
    local ok, msg = pcall(string.format, fmt, ...)
    pcall(Runtime.reportError, MOD_ID, ok and msg or tostring(fmt))
  end

  mod.options:define({
    { key = "probe_rows", type = "toggle",
      label = "Diagnostic rows", default = false },
    { key = "dev_art_guest", type = "choice",
      label = "DEV: Cleared art guest",
      choices = { { "Random", "" }, { "Brendan", "BRENDAN" },
                  { "Dawn", "DAWN" }, { "Green", "GREEN" },
                  { "Hilbert", "HILBERT" }, { "Hilda", "HILDA" },
                  { "Lyra", "LYRA" }, { "May", "MAY" },
                  { "Michael", "MICHAEL" },
                  { "Bea", "BEA" }, { "Mina", "MINA" },
                  { "Nate", "NATE" },
                  { "Stadium Trainer", "STADIUM_PLAYER" },
                  { "Rosa", "ROSA" }, { "Wes", "WES" },
                  { "Jessie & James", "JESSIE_JAMES" },
                  { "Giovanni", "GIOVANNI" }, { "Oak", "OAK" },
                  { "Lorelei", "LORELEI" }, { "Agatha", "AGATHA" },
                  { "Rocket Executive", "ROCKET_EXECUTIVE" },
                  { "Archer", "ARCHER" }, { "Ariana", "ARIANA" },
                  { "Proton", "PROTON" }, { "Petrel", "PETREL" },
                  { "Rocket Grunt M", "ROCKET_GRUNT_M" },
                  { "Rocket Grunt F", "ROCKET_GRUNT_F" },
                  { "Roxie", "ROXIE" }, { "Piers", "PIERS" } },
      default = "" },
  })

  -- 1.0.0 INVERTED THIS, and the inversion is the careful part -- players
  -- should not see DRAW / ARM OK / PARTY HOOK in [ERRS] during normal play.
  --
  -- Through 0.9.9 the default was ON and the read was "unless explicitly
  -- false", never `if get() then`, because an option toggled on a Gold boot
  -- does not round-trip (the manager writes Gold's nested block, the loader
  -- reads the top-level one) and a nil read would have silently removed the
  -- only diagnostic channel there is. Defaulting OFF inverts BOTH halves:
  -- the default, and the polarity of the nil case. "off unless explicitly
  -- true" is the honest mirror -- a nil read now means quiet, which is the
  -- safe direction when quiet is the intent.
  --
  -- Turning it ON still works two ways, which is why defaulting off does not
  -- strand a bug reporter: ManagerState:setOption writes loader.modOptions
  -- in memory immediately and mod.options:get reads exactly that
  -- (Loader.lua:1038), so a toggle takes effect in the SAME session on
  -- Gold; and toggling it on a Red boot persists it across relaunches.
  local function probe(fmt, ...)
    if mod.options:get("probe_rows") ~= true then return end
    errs(fmt, ...)
    -- Mirrored to the log as well. reportError only feeds the in-game
    -- [ERRS] screen, which is the ONLY channel on iOS but cannot be read
    -- off the machine -- so every diagnostic had to be transcribed by hand
    -- from a photograph of the screen. mod.log goes to print, which a
    -- desktop run captures to a file, so the same rows become readable
    -- directly. Both channels on purpose: neither platform loses one.
    local ok, msg = pcall(string.format, fmt, ...)
    pcall(function()
      mod.log:info("PROBE %s", (ok and msg or tostring(fmt)):gsub("\n", " | "))
    end)
  end

  ----------------------------------------------------------------------
  -- BADGE GATES (0.9.9). Decision 1 of briefs/IPC_colosseum_rules_
  -- 2026-08-13.md. The level anchor's premise has always been "just above
  -- the badge you needed to get here"; until now nothing enforced it, so
  -- a two-badge player could walk into Goldenrod's Lv22-28 bracket.
  --
  -- Johto badges only. save.player.badges is Johto; save.player.
  -- kantoBadges is a SEPARATE table (Save.summary counts them separately),
  -- and counting both would let a Kanto-badge player into Blackthorn early.
  ----------------------------------------------------------------------
  local VENUE_GATES = {
    VIOLET_POKECENTER_1F = {
      badge = "ZEPHYR",
      refusal = "Earn the ZEPHYR\nBADGE, then enter\fthe VIOLET\nQUALIFIER.",
    },
    GOLDENROD_POKECENTER_1F = {
      badges = 3,
      refusal = "Three JOHTO BADGES\nopen the GOLDENROD\fOPEN. Come back\nwhen you have all.",
    },
    ECRUTEAK_POKECENTER_1F = {
      badges = 4,
      refusal = "Four JOHTO BADGES\nopen the ECRUTEAK\fINVITATIONAL.\nCome back then.",
    },
    BLACKTHORN_POKECENTER_1F = {
      badges = 8,
      refusal = "Eight JOHTO BADGES\nopen BLACKTHORN'S\fMASTERS. Come back\nwhen you have all.",
    },
    INDIGO_PLATEAU_POKECENTER_1F = {
      hallOfFame = true,
      refusal = "Enter the HALL OF\nFAME first.\fThen the INDIGO\nCONFERENCE awaits.",
    },
  }

  -- Hall of Fame has shipped in two shapes: a wrapper carrying .teams, or
  -- the bare list of entries. Same adapter kanto_ribbons uses, which is
  -- device-proven, plus a nil guard on save.
  local function hofEntries(save)
    local hof = save and save.hallOfFame
    if type(hof) ~= "table" then return {} end
    if type(hof.teams) == "table" then
      local out = {}
      for _, team in ipairs(hof.teams) do
        if type(team) == "table" and type(team.mons) == "table" then
          out[#out + 1] = team.mons
        end
      end
      return out
    end
    return hof
  end

  local function johtoBadgeCount(save)
    local n = 0
    for _, has in pairs(save and save.player and save.player.badges or {}) do
      if has then n = n + 1 end
    end
    return n
  end

  -- FieldMoves.hasBadge is the canonical named reader: a save may key
  -- player.badges by NAME or by BIT POSITION and it accepts both. Required
  -- LAZILY and inside a pcall, matching how this file takes Trainers --
  -- a failed top-level require would throw in the entry chunk and the mod
  -- would simply not load, silently, which is this project's worst
  -- failure shape. If it is ever unavailable the count fallback is
  -- equivalent in real play: ZEPHYR is the first badge Gold can award, so
  -- "has ZEPHYR" and "has at least one Johto badge" only differ on a save
  -- edited by hand.
  local function hasNamedBadge(save, badge)
    local ok, FieldMoves = pcall(require, "src.world.gen2.FieldMoves")
    if ok and FieldMoves and FieldMoves.hasBadge then
      return FieldMoves.hasBadge(save, badge) and true or false
    end
    probe("NO FIELDMOVES\ncounting instead")
    return johtoBadgeCount(save) >= 1
  end

  -- Returns admitted, refusalText. Fails CLOSED: a venue with no gate
  -- entry refuses, so adding a venue without a gate cannot silently ship
  -- an ungated one.
  local function meetsVenueGate(venueId, save)
    local gate = VENUE_GATES[venueId]
    if not gate then return false, "This event is not\nopen right now." end
    if gate.badge then
      return hasNamedBadge(save, gate.badge), gate.refusal
    end
    if gate.badges then
      return johtoBadgeCount(save) >= gate.badges, gate.refusal
    end
    if gate.hallOfFame then
      return #hofEntries(save) > 0, gate.refusal
    end
    return false, gate.refusal
  end

  ----------------------------------------------------------------------
  -- Run state. mod.save, not mod.storage: this has to travel with the
  -- in-game SAVE so loading an earlier file rewinds the tournament too.
  ----------------------------------------------------------------------
  -- assignment, not `local function`: the local is forward-declared up
  -- beside venue, because levelBase above calls it
  round = function() return tonumber(mod.save:get("round", 1)) or 1 end
  local function pending() return mod.save:get("pending", false) == true end

  local function setRound(n) mod.save:set("round", n) end
  local function setPending(v) mod.save:set("pending", v and true or false) end

  ----------------------------------------------------------------------
  -- THE DRAW (0.9.0). Each run fields one challenger per tier, drawn at
  -- random and persisted as a comma-joined key string in mod.save -- so a
  -- run in progress survives quit/reload, which was a requirement in the
  -- original design doc. A fresh draw happens whenever the card is
  -- cleared, the player is eliminated, or the stored draw fails
  -- validation (e.g. a key renamed between versions). Where a tier has
  -- more than one member, the new draw avoids repeating that tier's
  -- previous pick, so back-to-back runs always look different.
  ----------------------------------------------------------------------
  do
    -- one-time seed; LuaJIT's math.random is deterministic per process
    -- otherwise, which would make every session's first draw identical
    local ok = pcall(function() math.randomseed(os.time()) end)
    if not ok then probe("SEED FAIL") end
  end

  local function parseDraw(s)
    if type(s) ~= "string" then return nil end
    local keys = {}
    for k in s:gmatch("[^,]+") do keys[#keys + 1] = k end
    if #keys ~= ROUNDS then return nil end
    for t, k in ipairs(keys) do
      local foe = BY_KEY[k]
      if not foe or foe.tier ~= t then return nil end
    end
    return keys
  end

  -- A first-round art override, deliberately separate from the persisted
  -- tiered draw. Several test guests belong to later tiers, so writing one
  -- into draw slot one would fail parseDraw and repeatedly redraw the bracket.
  -- Returning the selected foe only while r == 1 tests the same NPC/battle
  -- path without corrupting tournament save state.
  local function forcedArtGuest()
    local key = mod.options:get("dev_art_guest")
    if type(key) == "string" and BATTLE_FRONTS[key] and BY_KEY[key] then
      return key
    end
    return nil
  end

  local function newDraw()
    local prev = parseDraw(mod.save:get("draw", nil))
    local picks = {}
    for t = 1, ROUNDS do
      local pool = TIERS[t]
      local pick = pool[math.random(#pool)]
      if prev and #pool > 1 then
        while pick == prev[t] do pick = pool[math.random(#pool)] end
      end
      picks[t] = pick
    end
    mod.save:set("draw", table.concat(picks, ","))
    probe("DRAW %s %s %s %s", picks[1], picks[2], picks[3], picks[4])
    return picks
  end

  local function currentDraw()
    return parseDraw(mod.save:get("draw", nil)) or newDraw()
  end

  local function currentFoe()
    local r = round()
    if r > ROUNDS then return nil end
    if r == 1 then
      local forced = forcedArtGuest()
      if forced then return BY_KEY[forced] end
    end
    return BY_KEY[currentDraw()[r]]
  end

  -- Assignment, not `local function`: the local is declared up beside
  -- levelBase, which calls this.
  -- `lastCentre` is written as `false` on entering a Pokemon Center that
  -- hosts no event (place() below), NOT left alone -- so this returns nil
  -- there rather than the venue the player was at previously. Leaving it
  -- alone is what 0.9.5 did, and it is why the cross-venue fix did not
  -- cover an ordinary centre: the guard compared a stale venue against
  -- itself, saw no mismatch, and let the run continue.
  venue = function()
    local id = mod.save:get("lastCentre", nil)
    if type(id) ~= "string" then return nil, nil end
    return VENUES[id], id
  end

  ----------------------------------------------------------------------
  -- Carrier resolution. The `trainer` struct is numeric on BOTH fields --
  -- a class constant and an array position -- so names are resolved from
  -- the live data rather than hardcoded. A ROM index written into source
  -- is exactly the guessed constant that rots silently.
  ----------------------------------------------------------------------
  local function resolveCarrier(foe)
    if foe.classIx and foe.memberIx then return true end
    local td = mod.game and mod.game.data and mod.game.data.gen2Trainers
    local cls = td and td.classes and td.classes[foe.class]
    if not (cls and cls.index) then return false, "class " .. foe.class end
    -- our appended member first; the vanilla fallback only if it is absent
    for _, want in ipairs({ foe.member, foe.fallbackMember }) do
      for i, row in ipairs(cls.trainers or {}) do
        if row.id == want or row.name == want then
          foe.classIx, foe.memberIx = cls.index, i
          if want ~= foe.member then
            probe("NAME FALLBACK\n%s", foe.key)   -- append did not land
          end
          return true
        end
      end
    end
    return false, "member " .. foe.member
  end

  ----------------------------------------------------------------------
  -- Cell picking. Standing on open floor is not the requirement -- being
  -- TALKABLE is, so a candidate needs somewhere for the player to stand.
  -- Warp tiles are refused: an NPC on the stairs would take the way out
  -- away, which is worse than a bad spawn. All of this reads the ACTIVE
  -- map, so it only runs while the player is standing there.
  ----------------------------------------------------------------------
  local NEIGHBOURS = { { 0, -1 }, { 0, 1 }, { -1, 0 }, { 1, 0 } }

  local function walkable(map, x, y)
    local ok, res = pcall(map.isWalkableCell, map, x, y)
    return ok and res == true
  end

  local function usable(map, world, x, y)
    if not walkable(map, x, y) then return nil end
    if world:npcAt(x, y) then return nil end
    local okWarp, warp = pcall(map.warpAtCell, map, x, y)
    if okWarp and warp then return nil end
    local n = 0
    for _, d in ipairs(NEIGHBOURS) do
      local nx, ny = x + d[1], y + d[2]
      if walkable(map, nx, ny) and not world:npcAt(nx, ny) then n = n + 1 end
    end
    if n < 1 then return nil end
    return n
  end

  local function bestCell(world, taken)
    local map = world and world.map
    if not map then return nil end
    local bx, by, bn = nil, nil, 0
    for y = 0, ((map.height or 4) * 2) - 1 do
      for x = 0, ((map.width or 5) * 2) - 1 do
        local claimed = false
        for _, c in ipairs(taken or {}) do
          if c[1] == x and c[2] == y then claimed = true break end
        end
        if not claimed then
          local n = usable(map, world, x, y)
          if n and n > bn then bx, by, bn = x, y, n end
        end
      end
    end
    return bx, by
  end

  local function objectNamed(world, mapId, name)
    local def = world and world.maps and world.maps[mapId]
    for _, obj in ipairs(def and def.objects or {}) do
      if obj.name == name then return obj end
    end
    return nil
  end

  -- spawnNpc returns the runtime id and that is the ONLY handle removeNpc
  -- takes, so it is kept here rather than read back off the object -- the
  -- object's own id field is not something this mod has verified exists.
  local spawnedIds = {}
  -- which challenger is physically on the floor, so a stale one is
  -- recognised and removed rather than mistaken for the current round
  local spawnedFoeKey = nil
  -- set by a tournament loss, consumed by map.reloaded: walk the loser out
  local escortPending = false
  -- TRUE only between engaging OUR challenger and that battle ending. The
  -- trainer.party hook runs for every trainer battle in Gold, so this is
  -- the difference between substituting a team into the tournament and
  -- substituting it into somebody's Route 34 Camper.
  local ourBattle = false

  -- The tournament's first three rounds are three-on-three. Pass a short
  -- ARRAY to the battle without ever shortening save.party itself: each slot
  -- is the original mon table, so battle damage and experience still land on
  -- the player's real Pokemon and there is nothing to restore after a quit.
  -- Installed from the stashed engine original every load; the World module
  -- survives hot reloads, so a one-time sentinel would retain an old closure.
  local function installPlayerPartyCap()
    local ok, err = pcall(function()
      local World = require("src.world.gen2.World")
      if type(World) ~= "table" or type(World.startBattle) ~= "function" then
        error("World.startBattle unavailable")
      end
      World._ipcOriginals = World._ipcOriginals
        or { startBattle = World.startBattle }
      local original = World._ipcOriginals.startBattle
      if type(original) ~= "function" then
        error("World.startBattle original unavailable")
      end

      World.startBattle = function(self, opts, onDone)
        if ourBattle and round() < ROUNDS then
          local save = self and self.game and self.game.save
          local party = save and save.party
          if type(opts) == "table" and type(party) == "table"
              and #party > 0 then
            local capped = {}
            for i = 1, math.min(3, #party) do
              capped[i] = party[i]
            end
            opts.party = capped
          end
        end
        return original(self, opts, onDone)
      end
    end)
    if not ok then errs("PARTY CAP\n%s", tostring(err)) end
  end

  installPlayerPartyCap()

  -- Private 1.1.4+ battle-front tests. Gold normally resolves trainer pictures
  -- by CLASS, so replacing a class table entry would repaint every vanilla
  -- trainer of that class. Keep every proven class/member carrier and party
  -- completely intact; replace only the already-built UI instance's picture,
  -- and only while our owned arena NPC is starting a mapped guest's fight.
  --
  -- Installed from a stashed original for the same hot-reload reason as the
  -- player-party cap above. A missing or unreadable asset simply leaves the
  -- vanilla Juggler portrait in place.
  local function installGuestBattlePics()
    local ok, err = pcall(function()
      local BattleState = require("src.ui.gen2.BattleState")
      local Assets = require("src.render.Assets")
      if type(BattleState) ~= "table" or type(BattleState.new) ~= "function" then
        error("Gen 2 BattleState.new unavailable")
      end
      BattleState._ipcOriginals = BattleState._ipcOriginals or {}
      BattleState._ipcOriginals.new = BattleState._ipcOriginals.new
        or BattleState.new
      local original = BattleState._ipcOriginals.new
      BattleState.new = function(game, opts)
        local state = original(game, opts)
        local front = ourBattle and BATTLE_FRONTS[spawnedFoeKey]
        if front and state then
          local loaded, image = pcall(Assets.image, front)
          if loaded and image then
            state.enemyTrainerImage = image
            state.enemyTrainerPath = front
            state.enemyTrainerTrueColor = TRUE_COLOR_FRONTS[spawnedFoeKey] == true
            state.showEnemyTrainer = true
          else
            probe("GUEST PIC %s\n%s", tostring(spawnedFoeKey), tostring(image))
          end
        end
        return state
      end
    end)
    if not ok then errs("GUEST PICS\n%s", tostring(err)) end
  end

  installGuestBattlePics()

  local function despawn(name)
    local id = spawnedIds[name]
    if not id then return end
    spawnedIds[name] = nil
    pcall(function() mod.world:removeNpc(id) end)
  end

  ----------------------------------------------------------------------
  -- Spawning
  ----------------------------------------------------------------------
  -- The warp census that established the following was removed in 1.0.0
  -- along with the rest of the development diagnostics; its FINDING is why
  -- this mod warps nobody, so it stays written down.
  --
  -- The void bug pointed at the warp being the wrong
  -- tool: World.lua:8554-8564 says the backup-warp triple is what lets the
  -- shared 2F staircase resolve, and "without it the -1 warp resolves to
  -- nothing and the tile is simply dead". mod.world:warpTo never refreshes
  -- that triple, which is why the stairs die after a whiteout and why a
  -- normal warp (teleporting away and back) repairs them.
  --
  -- The fix is to stop warping and use the doorway the room already has,
  -- with the attendant stepping aside. That needs to know whether 2F
  -- carries a warp to COLOSSEUM at all -- Gen 2 may drive that transition
  -- from the script instead. This prints the table so the next build can be
  -- written against fact rather than a guess.


  -- Who is standing on the Colosseum doorway, and can she be moved?
  --
  -- Her DIALOGUE is not ours to change: talking to a vanilla NPC on Gold
  -- dispatches on npc.def.scriptKey into the cart's decoded bytecode, and
  -- the map_scripts registry has no Gen 2 home -- docs/mod-api-gen2-compat
  -- is explicit that a Lua row list merged into gen2Scripts "is not
  -- something src/script/gen2/Vm.lua can run". There is also no `ask` verb
  -- in queueScript's five (start_battle / warp / text / setflag /
  -- clearflag), so a mod cannot offer a choice box on Gold either -- not on
  -- her, and not on our own host.
  --
  -- What IS available is movement: mod.world:npc returns a handle whose
  -- scriptMove "compiles to the cart's own movement stream and rides
  -- World:beginMovement, the same path an applymovement in a map script
  -- takes" (WorldAPI.lua:161-164). So she steps aside instead of being
  -- silenced or hidden -- and because a scripted move is runtime only, she
  -- is back at her post on the next load, with link play untouched. Hiding
  -- her would have written a persistent MAPOBJECT_EVENT_FLAG and taken link
  -- play away for good.
  local doorCleared = false


  -- Anyone ON the doorway or directly below it is in the way. Moved one cell
  -- LEFT, away from the door, which on a 16x8 room is into open floor.
  local function clearDoor(world)
    if doorCleared then return end
    -- Nearest object to the doorway rather than an exact cell match. 0.3.2
    -- required x == 9 and y in {0,1} and she did not move on device, which
    -- most likely means she simply stands somewhere those two lines did not
    -- predict. A radius is robust to that; the census row prints her real
    -- cell either way.
    local def = world and world.maps and world.maps[LOBBY]
    local best, bestD, bestI
    for i, obj in ipairs(def and def.objects or {}) do
      local name = tostring(obj.name or "")
      if name ~= HOST_NAME and obj.x and obj.y then
        local d = math.abs(obj.x - ARENA_DOOR_X) + math.abs(obj.y - ARENA_DOOR_Y)
        if d <= 3 and (not bestD or d < bestD) then best, bestD, bestI = obj, d, i end
      end
    end
    do
      local obj, i = best, bestI
      if obj then
        local name = tostring(obj.name or "")
        probe("BLOCKER\n%s %d,%d d%d", name:sub(1, 10), obj.x, obj.y, bestD)
        local handle = mod.world:npc(LOBBY, obj.name or i)
        if not handle then
          probe("NO HANDLE\n%s", name:sub(1, 12))
          return false
        end

        -- She is walled in on both sides at the doorway, so one step left
        -- is impossible: she has to come DOWN off the door tile first, then
        -- go left, then turn back to face the room.
        --
        -- Chained through each completion because World.moveState is a
        -- single slot -- "a second call while one is running is refused
        -- rather than silently replacing the first and stranding its
        -- onDone" (WorldAPI.lua:168-170). Each leg reports its own result,
        -- so a refusal names the leg that failed instead of looking like
        -- the whole thing did nothing.
        local function leg3()
          local ok, err = pcall(function() return handle:face("right") end)
          probe("STEP3 %s", ok and "OK" or tostring(err))
          doorCleared = true
        end

        local function leg2()
          local ok, err = handle:scriptMove("left", 1, leg3)
          if not ok then probe("STEP2 FAIL\n%s", tostring(err)) end
        end

        local ok, err = handle:scriptMove("down", 1, leg2)
        probe("STEP1 %s\n%s", ok and "OK" or "FAIL",
              ok and name:sub(1, 12) or tostring(err))
        return ok
      end
    end
    probe("DOOR CLEAR\nnobody at %d,%d", ARENA_DOOR_X, ARENA_DOOR_Y)
    doorCleared = true
  end
  -- indices valid, and the index is all there is to key on with no name.
  -- HIDING IS WITHDRAWN, AND WHAT IT WROTE IS BEING PUT BACK.
  --
  -- Tested with the mod off: the stairs bug does NOT reproduce, so it is
  -- ours. toggleObject is the only PERSISTENT save-state change this mod
  -- makes -- Gen 2 has no save.objectToggles, so an object's visibility IS
  -- its MAPOBJECT_EVENT_FLAG (WorldAPI.lua:68-72) -- and it was being called
  -- with a LIST INDEX as the reference. If that index does not resolve to
  -- the object assumed, the call flips some other event flag entirely, and
  -- Gold gates warps and map scripts on event flags. That fits every symptom:
  -- a dead staircase, surviving across sessions, appearing without a battle.
  --
  -- So this now sets them VISIBLE rather than hidden, which repairs any flag
  -- earlier versions set in the developer's save instead of leaving them to
  -- find a broken game later. Two Chris sprites standing in a battle venue
  -- read as spectators; that is a cosmetic price worth paying and never
  -- worth persistent save writes.
  --
  -- If the pair really must go, the safe route is a spawn-over or a
  -- runtime-only approach -- nothing that writes the event bitfield.
  local PLACEHOLDER_SPRITE = "CHRIS"

  ----------------------------------------------------------------------
  -- THE PAIR BECOME SPECTATORS (0.4.4). A lone figure wearing the player's
  -- own sprite reads as a bug even when it is not, so they get new sheets
  -- and new positions -- through two mechanisms that never touch the event
  -- bitfield, after toggleObject broke the stairs (see 0.4.3):
  --
  -- 1) DEF MUTATION, the main path. World:pooledNpc builds an NPC from the
  --    map def exactly ONCE per session (npcPool, World.lua:6826-6830), and
  --    NPC.new takes cell, home and pixel position straight from objDef.x/y
  --    and the sheet from objDef.sprite (Npc.lua:220+). So rewriting the two
  --    def rows BEFORE the player first enters the arena controls both.
  --    gen2Maps is re-read from the extracted ROM cache on every boot
  --    (Game2/World dataTable), so this is runtime-only by construction --
  --    nothing to persist, nothing to repair, redone each session from the
  --    lobby the player must walk through anyway.
  --
  -- 2) LIVE REPAINT, the fallback for a save restored INSIDE the arena,
  --    where the pool built them before any lobby code ran. NPC:setSpriteDef
  --    is the engine's own `variablesprite` path -- the cart itself reskins
  --    NPCs in place (Fuchsia Gym, Copycat) and the comment above it says
  --    why repainting beats retiring: a new table would strand talkNpc and
  --    any moveState. Position cannot move this way; sprite alone still
  --    breaks the "that's me" read. applySpritePalette follows, because
  --    palettes are only baked on map entry and a repaint without it draws
  --    grey for up to a second.
  --
  -- Spectator cells are fixed guesses from the room layout (10x8 cells,
  -- benches along the top, warps at 4,7/5,7) and are TODO/CONFIRM on
  -- device: walkability cannot be checked from the lobby because
  -- world.maps[ARENA] is the def, not a Map instance, and by the time the
  -- arena IS active the pool has already built. The probe prints where they
  -- actually landed.
  local SPECTATOR_ROWS = {
    { sprite = "SPRITE_TEACHER",   x = 1, y = 2 },
    { sprite = "SPRITE_POKEFAN_M", x = 8, y = 2 },
  }

  local function redressPlaceholders(world)
    local def = world and world.maps and world.maps[ARENA]
    local n = 0
    for _, obj in ipairs(def and def.objects or {}) do
      local name = tostring(obj.name or "")
      local sprite = tostring(obj.sprite or ""):gsub("^SPRITE_", "")
      if name ~= FOE_NAME and name ~= EXIT_NAME and sprite == PLACEHOLDER_SPRITE then
        n = n + 1
        local row = SPECTATOR_ROWS[n]
        if row then
          obj.sprite = row.sprite
          obj.x, obj.y = row.x, row.y
          -- our own marker field, ignored by the engine (same trick as
          -- court_of_noctowl's conVariant): the flag repair below must
          -- still find these rows after the sprite id stops saying CHRIS
          obj.ipcSpectator = true
        end
      end
    end
    if n > 0 then probe("REDRESSED %d", n) end
  end

  ----------------------------------------------------------------------
  -- THE VOID, SOLVED (0.4.5). It was never the event flags -- toggleObject
  -- is exonerated, and the 0.4.3 "flag repair" is deleted rather than kept.
  --
  -- The real mechanism, read out of the extracted scripts in the ROM cache:
  -- COLOSSEUM's entry scene (5c:5514 -> 5c:5529) runs
  --   setscene 1; setmapscene group=20 map=1 scene=2
  -- i.e. entering the arena ARMS a scene on POKECENTER_2F. That scene
  -- (5c:4d51 -> 5c:4f1c) is the link-room escort: applymovement on
  -- OBJECT 0 -- the PLAYER -- walking a fixed path that assumes they are
  -- standing at the Colosseum door, then it resets both scenes.
  --
  -- Walk out through the door and the escort plays correctly and consumes
  -- itself. Leave ANY other way -- blackout after a loss, a teleport, the
  -- old exit-attendant warp -- and the scene stays armed in the SAVE
  -- (save.mapScenes), so the next 2F entry, from the stairs, marches the
  -- player three cells into the void. It self-resets after firing once,
  -- which is why the bug "healed" on re-entry and why a mods-off test on
  -- the same save could come back clean.
  --
  -- Two defences, both below: our battles are CANLOSE so a loss never
  -- blacks out (the trigger the developer hit), and any map entry that is
  -- neither the lobby nor the arena disarms a stale scene 2 (covers
  -- teleports and anything else that skips the door).
  ----------------------------------------------------------------------
  local LEAVE_COLOSSEUM_SCENE = 2

  local function disarmStaleEscort(why)
    local world = mod.world:overworld()
    if not (world and world.mapScenes) then return end
    if world.mapScenes[LOBBY] == LEAVE_COLOSSEUM_SCENE then
      -- both halves, matching what the escort's own tail does
      -- (setscene 0 / setmapscene 20,3,0), so vanilla state is restored
      world.mapScenes[LOBBY] = 0
      world.mapScenes[ARENA] = 0
      probe("ESCORT OFF\n%s", tostring(why))
    end
  end

  -- The fallback: any LIVE arena NPC still wearing the player's sheet gets
  -- repainted where it stands.
  local function repaintLive(world)
    for _, npc in ipairs(world and world.npcs or {}) do
      local id = npc.spriteDef and tostring(npc.spriteDef.id or "")
      if id:gsub("^SPRITE_", "") == PLACEHOLDER_SPRITE and npc.def
         and tostring(npc.def.name or "") ~= FOE_NAME then
        local sheet = world.sprites and world.sprites[SPECTATOR_ROWS[1].sprite]
        if sheet and npc.setSpriteDef and npc:setSpriteDef(sheet) then
          pcall(function() world:applySpritePalette(npc) end)
          probe("REPAINTED\n%d,%d", npc.cellX or -1, npc.cellY or -1)
        end
      end
    end
  end

  local function fillLobby(world)
    -- Redress the arena's link pair NOW, from the lobby: the pool builds
    -- them from the def on the player's first arena entry, and the lobby is
    -- the room every player must cross to get there.
    redressPlaceholders(world)
    -- No event upstairs of an ordinary Pokemon Center, so no host. The
    -- developer's call, and the right one: 0.9.5 tried to fix the
    -- cross-venue leak by guarding the ROUND, but a Gentleman offering a
    -- tournament in Cherrygrove is wrong on its own terms regardless of
    -- what the guard does. Removing the door removes every bug behind it.
    --
    -- Despawn rather than merely skip: POKECENTER_2F is one shared map,
    -- so a host spawned at Violet can still be standing there when the
    -- player climbs the stairs somewhere else within the same map load.
    if not venue() then
      despawn(HOST_NAME)
      return "no event here"
    end
    if objectNamed(world, LOBBY, HOST_NAME) then return "host ok" end
    local hx, hy = bestCell(world, {})
    if not hx then return "no cell" end
    local id, err = mod.world:spawnNpc(LOBBY, {
      name = HOST_NAME, sprite = SPRITE_HOST,
      x = hx, y = hy, movement = MOVE_STANDING_DOWN,
    })
    if not id then return "host fail " .. tostring(err) end
    spawnedIds[HOST_NAME] = id
    return ("host %d,%d"):format(hx, hy)
  end

  -- The arena census that identified the following was removed in 1.0.0
  -- with the other development diagnostics. What it found is load-bearing,
  -- so it stays: the developer reported "the link player" standing in
  -- there, and before hiding a vanilla object we had to know what it IS --
  -- toggleObject on Gen 2 sets the object's MAPOBJECT_EVENT_FLAG, which is
  -- real save state and persists, so it is not something to fire at an
  -- unidentified sprite.


  -- The two vanilla objects the census found: POKé1 and POKé2, both wearing
  -- the CHRIS sprite at (3,4) and (6,4). They are the link colosseum's
  -- placeholders for the two connected players and mean nothing in single
  -- player, so they are hidden while the tournament uses the room.
  --
  -- Gen 2 has no save.objectToggles: an object's visibility IS its
  -- MAPOBJECT_EVENT_FLAG (WorldAPI.lua:68-72), so this writes real,
  -- persistent save state rather than a display flag. Acceptable here
  -- because these two are inert outside a link session and the change is
  -- reversible by toggling them back -- but it is why the census came
  -- first, and why nothing is hidden that has not been identified.
  -- 0.2.2 hid only ONE of the two: it toggled by index while iterating the
  -- very list toggleObject mutates ("appear/disappear additionally take it
  -- off the live map when the map is the active one"), so hiding POKé1
  -- shifted POKé2's index and the second reference pointed at nothing.
  -- Snapshot first, then toggle -- and toggle by the NAME captured from the
  -- data, which also avoids this file having to spell the non-ASCII "é".
  -- Matched on SPRITE, not name. The first census printed them as "POKé1"
  -- and "POKé2" so 0.2.2 matched a name prefix -- but the log now shows them
  -- coming back as "#1"/"#2", which is this file's own fallback for a NIL
  -- name. So the name test could never fire and both stayed visible. Their
  -- sprite is the one thing that has read the same every single time.
  --
  -- Toggled in REVERSE index order because toggleObject takes the object off
  -- the live map, which shifts every index after it -- the exact mutation
  -- that made 0.2.2 hide one of the two. Going backwards keeps the lower

  local function fillArena(world)
    -- Order matters: repair the flags first (needs the arena active),
    -- then repaint anything the pool built before the lobby could redress.
    repaintLive(world)
    local taken = {}
    local out = {}

    -- No exit attendant any more: the arena's own bottom door leads out.
    despawn(EXIT_NAME)

    -- THE ANNOUNCER (0.7.0): the World-Tournament-MC archetype, embodied.
    -- SPRITE_GENTLEMAN is the closest thing Gold owns to a suited,
    -- mustached tournament announcer, and the escort voice has been
    -- "GENTLEMAN" since 0.5.0 -- he finally gets his body. He is the one
    -- who STARTS the rounds; the challengers spawn unarmed.
    if not objectNamed(world, ARENA, MC_NAME) then
      local ax, ay = bestCell(world, taken)
      if ax then
        taken[#taken + 1] = { ax, ay }
        local aid = mod.world:spawnNpc(ARENA, {
          name = MC_NAME, sprite = SPRITE_MC,
          x = ax, y = ay, movement = MOVE_STANDING_DOWN,
        })
        spawnedIds[MC_NAME] = aid
        out[#out + 1] = "mc ok"
      end
    end

    local foe = currentFoe()
    if not foe then
      -- Card cleared: take the last challenger off the floor.
      despawn(FOE_NAME)
      spawnedFoeKey = nil
      return "card done"
    end
    -- "foe already" was 0.2.1's bug in one line: it kept ANY standing foe,
    -- so a beaten challenger blocked his successor forever. Only the one
    -- matching the CURRENT round may stay.
    if spawnedFoeKey == foe.key and objectNamed(world, ARENA, FOE_NAME) then
      return "R" .. round() .. " up"
    end
    despawn(FOE_NAME)
    spawnedFoeKey = nil

    local ok, why = resolveCarrier(foe)
    if not ok then probe("CARRIER FAIL\n%s", tostring(why)); return "carrier" end

    local fx, fy = bestCell(world, taken)
    if not fx then return "no foe cell" end
    -- Spawned UNARMED -- no `trainer` field, so an A press falls through to
    -- our dialogue path and gets their flavour line. The announcer's round
    -- call is what arms them (armFoe below), which is the developer's
    -- talk-to-start structure: every character gets a pre-battle moment.
    local id, err = mod.world:spawnNpc(ARENA, {
      name = FOE_NAME, sprite = foe.sprite,
      x = fx, y = fy, movement = MOVE_STANDING_DOWN,
    })
    if not id then return "foe fail " .. tostring(err) end
    spawnedIds[FOE_NAME] = id
    spawnedFoeKey = foe.key
    out[#out + 1] = ("R%d %s"):format(round(), foe.key)
    return table.concat(out, "\n")
  end

  -- The announcer's round call writes the trainer struct onto the standing
  -- challenger's def row -- the live NPC holds the same table, so
  -- interactBody's trainer arm picks it up on the next A press. The exact
  -- inverse of the post-battle defang, on the same proven mechanism.
  -- No `event` flag on purpose: with none, trainerflagaction CHECK reads 0
  -- and the already-beaten branch never fires; round progress is this
  -- mod's own state, and a ROM event index would be a guessed constant.
  local function armFoe(world, foe)
    local obj = objectNamed(world, ARENA, FOE_NAME)
    if not obj then return false end
    obj.trainer = { class = foe.classIx, member = foe.memberIx,
                    seenText = foe.seenKey, winText = foe.winKey,
                    lossText = foe.lossKey }
    return true
  end

  ----------------------------------------------------------------------
  -- Round reconciliation.
  --
  -- The cart's script owns the battle outcome and does not hand it back,
  -- so the win is inferred: trainer.party fires when the battle STARTS and
  -- sets `pending`. A loss whites the player out to a Pokemon Center, so
  -- if they are still standing in the arena afterwards, they won.
  -- TODO/CONFIRM on device; the alternative is a real beaten-flag, which
  -- needs a ROM event index this mod has no safe way to allocate.
  ----------------------------------------------------------------------
  -- 0.2.1 inferred the win from "are you still standing in the arena", and
  -- on device the round simply never advanced: nothing re-enters the map
  -- after a battle, so the check had no moment to run. battle.ended is the
  -- real signal -- it carries { battle, result } (Battle.lua:396) and fires
  -- on the one choke point every battle passes through.
  --
  -- This handler deliberately does NO world work. battle.ended fires while
  -- the battle screen is still coming down, so spawning from here would
  -- race the map reload; it only moves the counter, and syncArena below
  -- makes the world match whenever the overworld is next in hand.
  ----------------------------------------------------------------------
  -- OUR BATTLES ARE CANLOSE. World:startScriptedBattle skips the blackout
  -- when opts.battleType == BATTLETYPE_CANLOSE (World.lua:5885) -- the
  -- Cherrygrove rival's own mechanism -- and it reads that from
  -- scriptVars[VAR_BATTLETYPE] (slot 3), a ONE-SHOT the battle start takes
  -- and clears. world.trainer_engaged fires in startTrainerScript, before
  -- the VM reaches `startbattle`, so arming it here is exactly the
  -- `writevar VAR_BATTLETYPE / loadvar BATTLETYPE_CANLOSE` the rival's map
  -- script does. Keyed on our object's NAME so a vanilla trainer fought
  -- mid-session keeps vanilla stakes.
  ----------------------------------------------------------------------
  local VAR_BATTLETYPE, BATTLETYPE_CANLOSE = 0x03, 1

  mod.events:on("world.trainer_engaged", function(ev)
    local ok, err = pcall(function()
      local npc = ev and ev.npc
      if not (npc and npc.def and npc.def.name == FOE_NAME) then return end
      -- THIS battle is ours. trainer.party fires for EVERY trainer battle
      -- in the game, so it needs a positive signal rather than guessing
      -- from the class -- see the hook below for what that cost.
      ourBattle = true
      local world = mod.world:overworld()
      if world and world.scriptVars then
        world.scriptVars[VAR_BATTLETYPE] = BATTLETYPE_CANLOSE
        probe("CANLOSE ON")
      end
    end)
    if not ok then errs("engaged\n%s", tostring(err)) end
  end)

  -- After ANY result the challenger stops being battleable: stripping
  -- def.trainer means interactBody's trainer arm no longer claims the A
  -- press, which falls through to kind="none" -- our dialogue path -- and
  -- gets the announcer instead of an instant rebattle. A table-field write,
  -- not world work, so it is safe this early in the teardown. (This is also
  -- the foundation for the planned talk-to-start announcer: post-battle
  -- talk already routes through our handler.)
  local function defangFoe()
    local world = mod.world:overworld()
    local obj = objectNamed(world, ARENA, FOE_NAME)
    if obj then obj.trainer = nil end
  end

  mod.events:on("battle.ended", function(ev)
    local ok, err = pcall(function()
      -- cleared for EVERY battle, before the pending() gate: a battle we
      -- armed but that never reached the hook (a mid-script abort, another
      -- mod bailing out) must not leave the flag set for whoever the player
      -- fights next.
      ourBattle = false
      if not pending() then return end
      setPending(false)
      local res = ev and ev.result
      probe("BATTLE %s", tostring(res))
      defangFoe()
      -- THE ESCORT NOW FOLLOWS EVERY RESULT (the developer's call): win or
      -- lose, the next step -- or an A press on anybody -- plays the
      -- announcer's line and warps the player to the 2F door cell, where
      -- the still-armed vanilla escort scene walks them out past the
      -- counter. The room re-stages on the NEXT entry, which is what makes
      -- "let us set up for the next round" true rather than flavour: the
      -- new challenger is never seen popping in.
      if res ~= "win" then
        -- A tournament loss is an elimination, not a wipeout: the battle
        -- was CANLOSE so no blackout is coming, and the party is healed
        -- where they stand. hp and status only; PP stays spent, which
        -- keeps a fresh run from being free.
        for _, mon in ipairs((mod.game and mod.game.save and mod.game.save.party) or {}) do
          if mon and mon.stats and mon.stats.hp then
            mon.hp = mon.stats.hp
            mon.status = nil
          end
        end
        if round() > 1 then
          setRound(1)
          probe("ELIMINATED\nback to R1")
        end
        -- elimination means a NEW run, and a new run means a new field --
        -- the developer's pairing of the two rules. Redrawn even on a
        -- round-1 loss, so retrying never means grinding the same face.
        newDraw()
        escortPending = "lose"
        return
      end
      local n = round() + 1
      setRound(n)
      probe(n > ROUNDS and "CARD CLEARED" or ("ROUND %d"):format(n))
      escortPending = "win"
    end)
    if not ok then errs("battle.ended\n%s", tostring(err)) end
  end)

  local function place(mapId)
    -- Record which centre the player is actually in, INCLUDING the ones
    -- that host nothing -- those store `false`, which venue() reads as
    -- "no event here". Matching on the map-id suffix rather than a list
    -- of the other centres: POKECENTER_2F is ONE shared map, so the only
    -- thing that can distinguish Violet's upstairs from Cherrygrove's is
    -- the 1F the player climbed from.
    if mapId and mapId:match("POKECENTER_1F$") then
      mod.save:set("lastCentre", VENUES[mapId] and mapId or false)
    end
    -- Any map that is neither the lobby nor the arena means the player has
    -- left the tournament flow by some path other than the 2F door --
    -- teleport, dig, another mod's warp -- so a still-armed escort is stale
    -- by definition. (To reach the 2F stairs legitimately they must cross
    -- the 1F, which lands here and disarms first.)
    if mapId ~= LOBBY and mapId ~= ARENA then disarmStaleEscort(mapId) end
    local world = mod.world:overworld()
    if not world then return end
    if mapId == LOBBY then
      -- Her step aside is a RUNTIME movement, so re-entering the lobby puts
      -- her back on her post -- but doorCleared stayed true from the first
      -- time and clearDoor returned early forever, so a second ask did
      -- nothing. Reset on every arrival: the flag tracks "is she out of the
      -- way right now", and arriving is exactly when that stops being true.
      doorCleared = false
      local ok, res = pcall(fillLobby, world)
      probe("IPC v%s\n%s", VERSION, ok and tostring(res) or "ERR " .. tostring(res))
    elseif mapId == ARENA then
      local ok, res = pcall(fillArena, world)
      probe("ARENA\n%s", ok and tostring(res) or "ERR " .. tostring(res))
    end
  end

  mod.events:on("map.entered", function(ev)
    local ok, err = pcall(place, ev and ev.mapId)
    if not ok then errs("map.entered\n%s", tostring(err)) end
  end)

  mod.events:on("game.ready", function()
    local ok, cur = pcall(function() return mod.world:current() end)
    if ok and cur then pcall(place, cur.mapId) end
  end)

  -- `reloadmapafterbattle` is the step the cart's own trainer script runs
  -- once the battle is over, and it reloads the map WITHOUT re-entering it
  -- -- which is why map.entered never fired and 0.2.1's round never
  -- advanced. This is the moment the next challenger can be put out.
  -- Host's line, then the warp to the 2F DOOR CELL -- the same arrival a
  -- genuine Colosseum exit produces, so the still-armed vanilla escort
  -- scene fires from the position its choreography assumes and walks the
  -- player out past the counter.
  -- TODO/CONFIRM on device: landing exactly on (9,0) must not re-trigger
  -- the door warp back in; if it does, land on (9,1).
  -- The announcer is a disembodied voice for now -- the Gentleman stays in
  -- the lobby, and that reads fine on GB conventions. The planned upgrade
  -- is a real announcer NPC in the arena who STARTS the battles, freeing
  -- the challengers themselves for flavour dialogue.
  -- One hype line per ROUND, not one line forever: the announcer escalating
  -- as the card thins is the whole appeal of the archetype, and hearing the
  -- same sentence four times reads as a bug in the writing. Keyed by round
  -- rather than by challenger so it still works when the field is drawn at
  -- random later. "BEGIN!" stays constant on purpose -- that one IS the
  -- catchphrase.
  -- Three variants per round (the design pass's), drawn at random per
  -- call, so a 64-deep pool doesn't share one fixed sentence per slot.
  local HYPE = {
    { "Round ONE, folks!\nFresh faces!",
      "The card is set!\nHere we GO, folks!",
      "Openers on deck!\nMake some noise!" },
    { "Round TWO! Now\nit gets spicy!",
      "The contenders\nhave arrived!",
      "Still standing?\nProve it, kid!" },
    { "Round THREE! The\nranked are here!",
      "Semifinal, folks!\nI smell an upset!",
      "The air is\nELECTRIC, folks!" },
    { "THE FINAL, folks!\nI'm shaking!",
      "A LEGEND walks\namong us, folks!",
      "History! Right\nhere! Right now!" },
  }

  local ESCORT_LINES = {
    win  = "ANNOUNCER: Please\nlet us set up\ffor the next\nround.",
    lose = "ANNOUNCER: Better\nluck next time.\fYou're out of\nthe running.",
  }

  local function runEscort()
    if not escortPending then return end
    local rows
    if escortPending == "win" and round() > ROUNDS then
      -- Winning round 4 is not "the next round", it is the title. GB names
      -- are at most 7 characters, so "TO %s, folks!" cannot overflow the
      -- 18-column box; save.player.name defaults to "GOLD" on a fresh save
      -- (src/core/gen2/Save.lua:346).
      local who = (mod.game and mod.game.save and mod.game.save.player
                   and mod.game.save.player.name) or "CHAMP"
      rows = {
        { "text", "ANNOUNCER:\nCONGRATULATIONS" },
        { "text", ("TO %s, folks!"):format(tostring(who):upper()) },
        { "text", "That's ALL! We'll\nsee you next time!" },
      }
    else
      rows = { { "text", ESCORT_LINES[escortPending] or ESCORT_LINES.lose } }
    end
    escortPending = false
    rows[#rows + 1] = { "warp", LOBBY, ARENA_DOOR_X, ARENA_DOOR_Y, "down" }
    local sent = mod.world:queueScript(rows)
    if not sent then probe("ESCORT FAIL") end
  end

  -- THE LOSS PATH NEVER RELOADS THE MAP, so map.reloaded cannot carry the
  -- escort. `reloadmapafterbattle`'s own `cp LOSE` branch jumps into the
  -- whiteout INSTEAD of reloading (World.lua:5866-5868); CANLOSE skips the
  -- whiteout but nothing reinstates the reload -- a combination vanilla
  -- never produces, because no generic trainer is CANLOSE. The player's
  -- first step after the battle is the trigger that always exists, on both
  -- results. (The map.reloaded floor swap is gone too: the room now
  -- deliberately re-stages only on the next ENTRY, after the escort.)
  mod.events:on("world.stepped", function()
    if not escortPending then return end
    local ok, err = pcall(function()
      local cur = mod.world:current()
      if cur and cur.mapId == ARENA then runEscort() end
    end)
    if not ok then errs("stepped\n%s", tostring(err)) end
  end)

  ----------------------------------------------------------------------
  -- Dialogue. A mod-spawned NPC carries no scriptKey, so an A press aimed
  -- at one falls past every arm of interactBody and lands on
  -- world.interacted with kind "none" and the faced cell (World.lua:7432).
  -- The challenger is NOT handled here: def.trainer makes his press take
  -- the trainer arm instead, which is the whole point.
  ----------------------------------------------------------------------
  -- THE MOD NO LONGER WARPS ANYBODY. The census found that POKECENTER_2F
  -- carries a real warp tile to COLOSSEUM at (9,0) -- warp 3 of 4, beside
  -- TRADE_CENTER at (5,0) and TIME_CAPSULE at (13,2). So the door already
  -- exists and the player can walk through it.
  --
  -- That matters for more than immersion. Walking a real warp is what banks
  -- wBackupWarpNumber / MapGroup / MapNumber (World.lua:8554-8564), the
  -- triple the ONE shared 2F staircase resolves its -1 destination through.
  -- mod.world:warpTo never refreshes it, so the previous builds left that
  -- staircase dead -- "the player is trapped upstairs in every Pokemon
  -- Center" -- which is the void the developer walked into after a loss,
  -- and why teleporting away repaired it. Using the door fixes the cause
  -- rather than papering over the symptom.

  ----------------------------------------------------------------------
  -- The ribbon contract with kanto_ribbons (mistermiracle3036/Ribbons).
  --
  -- Shaped exactly like Kanto Contests' mon.contestWins: the win is
  -- recorded ON THE MON, keyed by venue, so it survives boxing, evolution
  -- and trading the way the ribbon it earns does -- and so a resolver can
  -- apply it retroactively from save state alone rather than having to
  -- catch a live event.
  --
  -- Written UNCONDITIONALLY, for the reason kanto_ribbons/main.lua:852-854
  -- gives about contestWins: NOT gated on Ribbons being installed, so a
  -- player who installs it later still earns the ribbon for a run already
  -- won, and one who uninstalls it keeps the record. This mod never reads
  -- the field back and nothing anywhere revokes it.
  --
  -- Keyed by MAP ID, not town name: it comes from rom_manifest_gold.json,
  -- it is stable, and "INDIGO PLATEAU" has a space in it. One Conference
  -- ribbon is the agreed design, so the resolver only needs "any venue
  -- count > 0" -- but per-venue counts cost nothing to write here and
  -- leave per-venue ribbons open later without a save migration.
  --
  -- The WHOLE PARTY is credited, following the Winning/Victory tower
  -- ribbons in that mod rather than the single-performer contest one: a
  -- four-round card is won by the team, not by the last mon standing.
  ----------------------------------------------------------------------
  local function recordConferenceWin(venueId)
    if not venueId then probe("RIBBON NOVENUE") return end
    local save  = mod.game and mod.game.save
    local party = save and save.party
    if type(party) ~= "table" then probe("RIBBON NOPARTY") return end
    local n = 0
    for _, mon in ipairs(party) do
      if type(mon) == "table" then
        local wins = mon.conferenceWins
        if type(wins) ~= "table" then wins = {} mon.conferenceWins = wins end
        wins[venueId] = (tonumber(wins[venueId]) or 0) + 1
        n = n + 1
      end
    end
    probe("RIBBON OK\n%d mon", n)
  end

  ----------------------------------------------------------------------
  -- Venue-bound runs (0.9.5).
  --
  -- DEVICE BUG: win round 1 in Violet, walk to Goldenrod, and the host
  -- there says "Round 2 of 4" and runs round 2 at GOLDENROD's levels.
  -- `round` and `draw` are single global keys in mod.save, while venue()
  -- just reads whichever centre was last entered -- so nothing tied a run
  -- to the place it started. Four rounds could be spread across four
  -- towns, each at its own anchor, which defeats the whole point of a
  -- per-venue difficulty.
  --
  -- One tournament at a time: the run remembers its venue, and entering a
  -- different one forfeits it and draws fresh. Deliberately NOT "each
  -- venue keeps its own run" -- five parallel brackets would need five
  -- times the save state and would let a player shop for a favourable
  -- draw by walking between towns.
  --
  -- A save from 0.9.4 or earlier has no runVenue. That reads as nil and
  -- is ADOPTED by the current venue rather than forfeited, so an upgrade
  -- mid-run does not eat the player's progress.
  ----------------------------------------------------------------------
  local function runVenue() return mod.save:get("runVenue", nil) end
  local function setRunVenue(id) mod.save:set("runVenue", id) end

  -- 18 columns, from TextBox.lua's MAX_COLS. Over-length lines soft-wrap
  -- and scroll the page (TextBox.lua:164) rather than clipping, which is
  -- how three venues shipped with wrapped announcer lines through 0.9.2.
  local BOX_COLS = 18

  -- 0.9.3 page-broke town from title unconditionally, which fixed the
  -- three venues that overflow and made the two that fit read badly --
  -- "GOLDENROD OPEN!" is 15 columns and wants to be one line. Reported
  -- from device as an awkward break at Goldenrod. Measure, then choose.
  local function venueWelcome(town, title)
    local oneLine = ("%s %s!"):format(town, title)
    if #oneLine <= BOX_COLS then
      return ("Welcome to the\n%s"):format(oneLine)
    end
    return ("Welcome to the\n%s\f%s!"):format(town, title)
  end

  local function venueSendoff(town, title)
    local tail = ("%s is yours."):format(title)
    if #tail <= BOX_COLS then
      return ("The %s\n%s"):format(town, tail)
    end
    return ("The %s\n%s\fis yours."):format(town, title)
  end

  local function talkHost()
    local v, venueId = venue()
    -- Belt and braces with fillLobby's gate: if there is no event here,
    -- refuse rather than fall through to the INDIGO/CONFERENCE defaults.
    -- Those defaults are what let an ordinary centre run a round of
    -- somebody else's tournament, and a silent wrong venue is exactly the
    -- failure this mod keeps having. Declining is diagnosable.
    if not (v and venueId) then
      probe("NO VENUE\nhost declined")
      return
    end
    -- Badge gate, BEFORE anything reads or writes run state. A turned-away
    -- player keeps whatever run they have going elsewhere: no forfeit, no
    -- redraw, no round change, and the attendant does not step aside
    -- (that lives in the normal path's onDone, which this returns before).
    local admitted, refusal = meetsVenueGate(venueId, mod.game and mod.game.save)
    if not admitted then
      probe("GATE REFUSED\n%s", tostring(venueId))
      local sent, serr = mod.world:queueScript({ { "text", refusal } })
      if not sent then probe("GATE TALK FAIL\n%s", tostring(serr)) end
      return
    end
    local town = v.town
    local title = v.title
    local r = round()
    local rows

    -- Before anything reads the round: a run in progress that belongs to
    -- another venue is forfeit here. Only when a round has actually been
    -- won (r > 1) is there anything to forfeit or to tell the player
    -- about; at round 1 this is a silent re-binding.
    local owner = runVenue()
    local forfeited = false
    if venueId and owner and owner ~= venueId and r > 1 then
      probe("VENUE SWITCH\n%s -> %s", tostring(owner), tostring(venueId))
      setRound(1)
      newDraw()
      forfeited = true
      r = 1
    end
    if venueId then setRunVenue(venueId) end

    if r > ROUNDS then
      rows = {
        { "text", venueSendoff(town, title) },
        { "text", "Come back and\nwe'll draw again." },
      }
      -- Before the redraw, and inside the same branch that only a
      -- completed four-round card can reach, so it fires exactly once
      -- per win. pcall'd: a ribbon record must never cost the player
      -- their send-off.
      pcall(recordConferenceWin, venueId)
      setRound(1)
      newDraw()     -- repeatable: clearing the card genuinely redraws it now
    elseif r == 1 then
      rows = {
        { "text", venueWelcome(town, title) },
        { "text", ("%d rounds. One\nchallenger each."):format(ROUNDS) },
        { "text", "Three per side\nuntil the final." },
        { "text", "Through the far\ndoor. Good luck." },
      }
      -- Said BEFORE the welcome, so the player learns why the bracket
      -- reset rather than silently finding themselves back at round 1.
      if forfeited then
        table.insert(rows, 1,
          { "text", "One tournament\nat a time!\fYour other run\nis forfeit." })
      end
    else
      rows = {
        { "text", ("Round %d of %d.\nThey're waiting."):format(r, ROUNDS) },
      }
    end

    -- She steps aside in onDone, not before: scriptMove refuses a second
    -- movement while one is running, and the host's text box is the natural
    -- beat for it anyway -- he arranges it, then she moves.
    local sent, serr = mod.world:queueScript(rows, {
      onDone = function()
        if round() <= ROUNDS then
          pcall(function() clearDoor(mod.world:overworld()) end)
        end
      end,
    })
    if not sent then probe("TALK FAIL\n%s", tostring(serr)) end
  end

  -- The exit attendant is gone. The arena's own bottom door leads back out
  -- with no help, and walking it banks the backup-warp triple that a
  -- scripted warp does not -- so the mod handing out the way home was both
  -- unnecessary and the source of the dead staircase.

  mod.events:on("world.interacted", function(ev)
    local ok, err = pcall(function()
      if not ev or ev.kind ~= "none" then return end
      local world = mod.world:overworld()
      if ev.mapId == LOBBY then
        local h = objectNamed(world, LOBBY, HOST_NAME)
        if h and h.x == ev.x and h.y == ev.y then return talkHost() end
      elseif ev.mapId == ARENA then
        -- With an escort pending, an A press on the just-fought challenger
        -- -- whose def.trainer was stripped, so the press lands here rather
        -- than in the cart's battle script -- gets THEIR after-battle line,
        -- as many times as the player likes. Only MOVEMENT hands them to
        -- the announcer (world.stepped below): characters first, escort on
        -- the first step. A press on anything else while pending escorts
        -- immediately, so no input path reaches a rematch.
        if escortPending then
          local f = objectNamed(world, ARENA, FOE_NAME)
          if f and f.x == ev.x and f.y == ev.y then
            local foe = spawnedFoeKey and BY_KEY[spawnedFoeKey]
            local line = foe and (escortPending == "win" and foe.afterWin
                                  or foe.afterLoss)
            if line then
              mod.world:queueScript({ { "text", line } })
              return
            end
          end
          return runEscort()
        end
        -- otherwise the floor may be a round out of date; make it match
        pcall(fillArena, world)

        local foe = currentFoe()
        local foeObj = objectNamed(world, ARENA, FOE_NAME)
        local mc = objectNamed(world, ARENA, MC_NAME)

        -- THE ANNOUNCER STARTS THE ROUNDS. His call writes the trainer
        -- struct onto the challenger; until then the challenger only chats.
        -- Personality per the model: loud, superlative, in love with the
        -- spectacle -- the World Tournament Announcer archetype.
        if mc and mc.x == ev.x and mc.y == ev.y then
          if not foe then
            mod.world:queueScript({
              { "text", "ANNOUNCER: WHAT a\ntournament, folks!" },
              { "text", "Rest up. We draw\na new card soon!" },
            })
          elseif foeObj and foeObj.trainer then
            mod.world:queueScript({
              { "text", "ANNOUNCER: The\ncrowd is WAITING!" },
            })
          elseif not levelBase(foe) then
            -- The anchor could not be read, so there is no honest level to
            -- fight at. Decline the ROUND rather than arm a battle that
            -- would fall back to the carrier's vanilla party -- the player
            -- would face a Camper's team under a champion's name and have
            -- no way to know why. levelBase has already put NO ANCHOR in
            -- [ERRS]; this is the player-facing half.
            probe("ROUND REFUSED\n%s", tostring(foe.key))
            mod.world:queueScript({
              { "text", "ANNOUNCER: We have\na problem, folks." },
              { "text", "No round today.\nPlease come back." },
            })
          else
            local armed = armFoe(world, foe)
            probe("ARM %s\n%s", armed and "OK" or "FAIL", tostring(foe.key))
            mod.world:queueScript({
              { "text", ("ANNOUNCER: ROUND\n%d of %d, folks!"):format(round(), ROUNDS) },
              { "text", ("Facing you --\n%s!"):format(foe.name or foe.key) },
              { "text", (function()
                  local vs = HYPE[round()] or HYPE[#HYPE]
                  return vs[math.random(#vs)]
                end)() },
              { "text", "BEGIN!" },
            })
          end
          return
        end

        -- Unarmed challenger: their flavour line, as often as you like.
        if foe and foeObj and not foeObj.trainer
           and foeObj.x == ev.x and foeObj.y == ev.y then
          mod.world:queueScript({ { "text", foe.chat or "..." } })
          return
        end
      end
    end)
    if not ok then errs("interacted\n%s", tostring(err)) end
  end)

  ----------------------------------------------------------------------
  -- Party substitution. What arrives here is NOT what the struct carried:
  -- Battle.lua:266-267 passes `classId or class` and
  -- `memberId or index or 1`, and the record Trainers.lookup builds sets
  -- classId to the class NAME and carries no member index -- so this sees
  -- a name and a member of 1. Match on the class either way and use the
  -- run state, not the arguments, to decide WHICH challenger this is.
  ----------------------------------------------------------------------
  local function buildParty(rows)
    -- An internals require, deliberately: no mod-facing seam turns
    -- {species, level} rows into Gen 2 battle mons. Built through the
    -- engine's OWN builder so these mons match a vanilla trainer's exactly
    -- -- level-up movesets and the cart's fixed 9/8/8/8/8 trainer DVs
    -- (Trainers.lua:82-88). Safe here ONLY because this mod is Gold-only;
    -- a dual-generation mod must not copy it.
    local Trainers = require("src.world.gen2.Trainers")
    local data = mod.game and mod.game.data
    if not data then return nil end
    local party = Trainers.party(data, { roster = rows })
    if not party or #party == 0 then return nil end
    return party
  end

  mod.hooks:wrap("trainer.party", function(next, class, member, party)
    local base = next()
    local ok, res = pcall(function()
      -- ONLY OUR BATTLE. This hook runs for EVERY trainer battle in Gold,
      -- and 0.5.1's class-only scan matched vanilla trainers of a shared
      -- class: on device, Route 34's CAMPER ROLAND fought with TODD's
      -- BUTTERFREE and PIDGEOTTO instead of his own Lv.9 NIDORAN. With 64
      -- challengers that scan covered ~19 classes -- most trainers in
      -- Johto. `ourBattle` is set by world.trainer_engaged only when the
      -- engaged NPC is our own arena challenger, and cleared when the
      -- battle ends, so this is positive knowledge instead of a guess.
      if not ourBattle then return nil end
      -- WHICH challenger: the one physically on the arena floor. 64 entries
      -- share carriers (CAMPER x3, GENTLEMAN x2, HIKER x3), so the class
      -- cannot tell them apart, and after a win the round has already moved
      -- on -- the person standing there is the one being fought.
      local foe = (spawnedFoeKey and BY_KEY[spawnedFoeKey]) or currentFoe()
      if not (foe and (class == foe.class or class == foe.classIx)) then
        probe("HOOK MISMATCH\n%s / %s", tostring(class),
              tostring(foe and foe.key))
        return nil
      end
      -- Belt and braces with the announcer's refusal above: if the anchor
      -- is unreadable, returning nil hands the battle back to the carrier's
      -- vanilla party. That is the least-bad outcome for a battle already
      -- under way, and it is still a REAL battle rather than a stat-less one.
      local rows = scaled(foe)
      if not rows then
        probe("NO ANCHOR\n%s unscaled", foe.key)
        return nil
      end
      local built = buildParty(rows)
      if not built then
        -- Keep the vanilla party rather than field an opponent with no
        -- stats. A real battle beats a broken one.
        probe("BUILD FAIL\n%s", foe.key)
        return nil
      end
      setPending(true)
      -- Report the level actually used, so a wrong anchor is visible on the
      -- screen rather than inferred from how hard the battle felt.
      probe("R%d %s\n%d mons Lv%d", round(), foe.key, #built,
            built[1] and built[1].level or -1)
      return built
    end)
    if ok and res then return res end
    if not ok then probe("HOOK ERR\n%s", tostring(res)) end
    return base
  end)

  mod.log:info("indigo_conference %s loaded", VERSION)
end
