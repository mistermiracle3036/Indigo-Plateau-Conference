-- Indigo Plateau Conference -- a Colosseum circuit for Johto.
--
-- PREMISE. Gold's Pokemon Center 2F is where trainers go to battle each
-- other. This mod puts a tournament up there, and keys the event off which
-- town's stairs you climbed -- so ONE vanilla room hosts five different
-- events and the mod ships no maps, no tilesets and no warps of its own.
--
-- v0.1.3 -- WHY THE ROOM CHANGED. 0.1.2 put everything in COLOSSEUM (group
-- 20, map 3), the link-battle arena. On device that room turned out to be
-- unreachable: the 2F attendant only opens it once a link partner is
-- connected, which single player never satisfies. POKECENTER_2F is the
-- room the player can actually stand in, so that is where the tournament
-- lives now. Getting into COLOSSEUM is demoted to an EXPERIMENT the host
-- offers, because mod.world:warpTo checks only that the map exists
-- (WorldAPI.lua:58) and never consults the attendant -- so the door may
-- open for us even though it does not for the player.
--
-- Deliberately separated: the warp experiment must NOT be able to block
-- the battle probe. They are two independent questions and this build
-- answers both without either depending on the other.
--
-- WHAT IS PROVEN (all four on device, Gold, 0.1.4 -> 0.1.6)
--   Owned NPCs talk on Gold via the world.interacted kind="none"
--   fall-through plus queueScript (first shown by court_of_noctowl 0.1.2).
--
--   A MOD CAN STAGE A TRAINER BATTLE ON GOLD. queueScript's start_battle
--   is wild-only (WorldAPI.lua:232), but an NPC spawned with def.trainer
--   is picked up by interactBody's trainer arm (World.lua:7331) and run
--   through the cart's own TALK_TO_TRAINER_SCRIPT. Both struct fields are
--   NUMERIC -- a class constant and an array position (Trainers.lua:18-19).
--
--   MOD-REGISTERED TEXT REACHES THE ROM'S OWN POOL. The `text` registry
--   targets gen2Text (Schemas.lua:476), which is what Vm:showText reads,
--   so a trainer's seen/win/loss lines can be written by this mod and
--   delivered by the cart's script. Every roster character can speak.
--
--   trainer.party fires on Gold and substitutes the team wholesale. What
--   it RETURNS must be finished battle mons: Battle.lua:258 says nothing
--   downstream rewrites the hook's result, so raw {species, level} rows
--   arrive with no stats (0.1.6: a Quagsire at 0 HP with a blank bar).
--
-- So the remaining work is content, not feasibility.
--
-- Verified against gen1recomp v0.1.79. Anything not read from source is
-- marked TODO/CONFIRM.

local Runtime = require("src.mods.Runtime")

return function(mod)
  local VERSION = "0.1.7"
  local MOD_ID = "indigo_conference"

  mod.exports.version = VERSION
  mod.exports.owns = { trainers = {}, maps = {}, tilesets = {} }

  local LOBBY = "POKECENTER_2F"   -- reachable; where the tournament runs
  local ARENA = "COLOSSEUM"       -- link-gated; the experiment

  local HOST_NAME = "IPC_HOST"
  local RIVAL_NAME = "IPC_PROBE_OPPONENT"
  local WAYBACK_NAME = "IPC_WAY_BACK"

  -- SPRITEMOVEDATA_STANDING_DOWN, src/world/gen2/Npc.lua MOVE table.
  -- NUMERIC: the Gen 2 arm compares def.movement against numbers and only
  -- the Gen 1 compat arm understands "STAY".
  local MOVE_STANDING_DOWN = 6

  -- constants.spriteOrder, rom_manifest_gold.json
  local SPRITE_HOST = "SPRITE_GENTLEMAN"
  local SPRITE_RIVAL = "SPRITE_COOLTRAINER_M"

  -- The CARRIER: a real class and member from constants.trainerClassOrder /
  -- trainerClassMembers, because startTrainerScript resolves the party
  -- through the cart's own table and a name we invented is not in it. The
  -- team is replaced wholesale by the trainer.party hook below.
  local CARRIER_CLASS = "COOLTRAINERM"
  local CARRIER_MEMBER = "NICK"

  ----------------------------------------------------------------------
  -- 0.1.5 showed the text and then no battle, because the `trainer`
  -- struct is NUMERIC on both fields and this mod was handing it names.
  --
  --   Trainers.lua:18-19 -- "trainers.lua keys classes by name; the
  --   `trainer` struct and `loadtrainer` both carry the class's numeric
  --   constant".
  --   Trainers.lookup does classIndex(data)[class] then
  --   entry.trainers[member]: an index and an array position.
  --
  -- A name misses both, lookupTrainer returns nil, and `startbattle`
  -- yields with trainer = nil -- text, then nothing.
  --
  -- Resolved from the live data rather than hardcoded, because the class
  -- constant is a ROM index and writing 27 here would be exactly the kind
  -- of guessed constant that fails silently after any data change.
  ----------------------------------------------------------------------
  local carrierClassIx, carrierMemberIx

  local function resolveCarrier()
    if carrierClassIx and carrierMemberIx then return true end
    local td = mod.game and mod.game.data and mod.game.data.gen2Trainers
    local cls = td and td.classes and td.classes[CARRIER_CLASS]
    if not (cls and cls.index) then return false, "no class " .. CARRIER_CLASS end
    for i, row in ipairs(cls.trainers or {}) do
      if row.id == CARRIER_MEMBER or row.name == CARRIER_MEMBER then
        carrierClassIx, carrierMemberIx = cls.index, i
        return true
      end
    end
    return false, "no member " .. CARRIER_MEMBER
  end

  ----------------------------------------------------------------------
  -- Pre-battle text. 0.1.4 showed "..." because TALK_TO_TRAINER_SCRIPT
  -- runs `trainertext index=0`, which reads trainerObject.seenText and
  -- looks it up in the Vm's text pool -- and Vm:showText falls back to
  -- the literal "..." when the body is missing or empty (Vm.lua:2357).
  -- The mod never supplied one.
  --
  -- The `text` registry DOES have a Gen 2 target (Schemas.lua:476,
  -- text = "gen2Text"), and that is the same table the Vm reads, so a
  -- mod-registered key is reachable from the cart's own script.
  -- TODO/CONFIRM: Gold's vanilla text ids are ROM pointer strings
  -- ("55:4067") rather than TEXT_* names; an invented key should still
  -- work because the lookup is a plain table index, but this build is
  -- what proves it.
  ----------------------------------------------------------------------
  local SEEN_TEXT = "IPC_PROBE_SEEN"
  local WIN_TEXT  = "IPC_PROBE_WIN"
  local LOSS_TEXT = "IPC_PROBE_LOSS"

  mod.content.text:register(SEEN_TEXT,
    "So you're the one\nthey entered?\fLet's see it.")
  mod.content.text:register(WIN_TEXT,  "...I misjudged you.")
  mod.content.text:register(LOSS_TEXT, "Come back when\nyou're ready.")

  ----------------------------------------------------------------------
  -- The circuit, keyed by the Pokemon Center whose stairs were climbed.
  -- Map ids from rom_manifest_gold.json, badge keys from
  -- src/battle/gen2/Battle.lua:193. None guessed.
  ----------------------------------------------------------------------
  local VENUES = {
    VIOLET_POKECENTER_1F     = { town = "VIOLET",     badge = "ZEPHYR",
                                 title = "QUALIFIER" },
    GOLDENROD_POKECENTER_1F  = { town = "GOLDENROD",  badge = "PLAIN",
                                 title = "OPEN" },
    ECRUTEAK_POKECENTER_1F   = { town = "ECRUTEAK",   badge = "FOG",
                                 title = "INVITATIONAL" },
    BLACKTHORN_POKECENTER_1F = { town = "BLACKTHORN", badge = "RISING",
                                 title = "MASTERS" },
    INDIGO_PLATEAU_POKECENTER_1F = { town = "INDIGO PLATEAU", badge = "RISING",
                                     title = "CONFERENCE" },
  }

  ----------------------------------------------------------------------
  -- Diagnostics. mod.log goes to a console that does not exist on iOS;
  -- Runtime.reportError renders in the manager's [ERRS] screen.
  ----------------------------------------------------------------------
  local function errs(fmt, ...)
    local ok, msg = pcall(string.format, fmt, ...)
    pcall(Runtime.reportError, MOD_ID, ok and msg or tostring(fmt))
  end

  mod.options:define({
    { key = "probe_rows", type = "toggle",
      label = "Diagnostic rows", default = true },
    { key = "try_colosseum", type = "toggle",
      label = "Offer Colosseum warp", default = true },
  })

  -- "unless explicitly false", never "if true": a mod option toggled on a
  -- Gold boot never round-trips (the manager writes Gold's nested options
  -- block, Loader:_loadState reads the top-level one), so this read can
  -- come back nil -- and `if get() then` would silently remove the only
  -- diagnostic channel this build has.
  local function probe(fmt, ...)
    if mod.options:get("probe_rows") == false then return end
    errs(fmt, ...)
  end

  ----------------------------------------------------------------------
  -- Venue memory. The player cannot reach 2F without walking through a
  -- centre, so the last one entered names the event. mod.save because a
  -- save made UPSTAIRS reloads with no 1F visit behind it -- and because
  -- mod.save is what travels with the in-game save, which is the property
  -- run state needs.
  ----------------------------------------------------------------------
  local function rememberCentre(mapId)
    if VENUES[mapId] then mod.save:set("lastCentre", mapId) end
  end

  local function currentVenue()
    local id = mod.save:get("lastCentre", nil)
    return id and VENUES[id] or nil, id
  end

  local function hasBadge(key)
    local save = mod.game and mod.game.save
    local badges = save and save.player and save.player.badges
    return type(badges) == "table" and badges[key] == true
  end

  ----------------------------------------------------------------------
  -- Cell picking. These four helpers are the shape court_of_noctowl
  -- arrived at after stranding Falkner in a one-tile pocket: standing on
  -- open floor is not the requirement, being TALKABLE is, so a candidate
  -- needs somewhere for the player to stand beside it. Warp tiles are
  -- refused outright -- an NPC parked on the stairs would take the way out
  -- away, which is worse than a bad spawn.
  --
  -- All four read the ACTIVE map (world.map), so spawning only ever
  -- happens from map.entered / game.ready while the player is standing
  -- there.
  ----------------------------------------------------------------------
  local NEIGHBOURS = { { 0, -1 }, { 0, 1 }, { -1, 0 }, { 1, 0 } }

  local function walkable(map, x, y)
    local ok, res = pcall(map.isWalkableCell, map, x, y)
    return ok and res == true
  end

  local function openNeighbours(map, world, x, y)
    local n = 0
    for _, d in ipairs(NEIGHBOURS) do
      local nx, ny = x + d[1], y + d[2]
      if walkable(map, nx, ny) and not world:npcAt(nx, ny) then n = n + 1 end
    end
    return n
  end

  local function usable(map, world, x, y)
    if not walkable(map, x, y) then return nil end
    if world:npcAt(x, y) then return nil end
    local okWarp, warp = pcall(map.warpAtCell, map, x, y)
    if okWarp and warp then return nil end
    local n = openNeighbours(map, world, x, y)
    if n < 1 then return nil end
    return n
  end

  -- Best free cell on the active map, most-reachable first. `taken` holds
  -- cells this same pass already claimed, since a spawn made moments ago is
  -- not yet visible to npcAt.
  local function bestCell(world, taken)
    local map = world and world.map
    if not map then return nil end
    local w = (map.width or 5) * 2
    local h = (map.height or 4) * 2
    local bx, by, bn = nil, nil, 0
    for y = 0, h - 1 do
      for x = 0, w - 1 do
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
    return bx, by, bn
  end

  local function objectNamed(world, mapId, name)
    local def = world and world.maps and world.maps[mapId]
    for _, obj in ipairs(def and def.objects or {}) do
      if obj.name == name then return obj end
    end
    return nil
  end

  ----------------------------------------------------------------------
  -- Spawning
  ----------------------------------------------------------------------
  local function fillLobby(world)
    if objectNamed(world, LOBBY, HOST_NAME) then return "already placed" end
    local taken = {}

    local hx, hy = bestCell(world, taken)
    if not hx then return "no usable cell" end
    taken[#taken + 1] = { hx, hy }

    local id, err = mod.world:spawnNpc(LOBBY, {
      name = HOST_NAME, sprite = SPRITE_HOST,
      x = hx, y = hy, movement = MOVE_STANDING_DOWN,
    })
    if not id then return "host fail: " .. tostring(err) end

    -- The probe opponent. def.trainer is the whole experiment.
    local okCarrier, why = resolveCarrier()
    if not okCarrier then
      probe("CARRIER FAIL\n%s", tostring(why))
      return ("host %d,%d\nno carrier"):format(hx, hy)
    end
    local rx, ry = bestCell(world, taken)
    if rx then
      local rid, rerr = mod.world:spawnNpc(LOBBY, {
        name = RIVAL_NAME, sprite = SPRITE_RIVAL,
        x = rx, y = ry, movement = MOVE_STANDING_DOWN,
        -- No `event` flag on purpose. trainerflagaction CHECK reads
        -- trainerObject.event (Vm.lua:1130) and with none it sets
        -- scriptVar 0, so the "already beaten" branch never fires and the
        -- opponent can be fought again -- which is what a REPEATABLE
        -- tournament wants. A real beaten-flag would retire each
        -- challenger permanently after one win.
        trainer = {
          class = carrierClassIx, member = carrierMemberIx,
          seenText = SEEN_TEXT, winText = WIN_TEXT, lossText = LOSS_TEXT,
        },
      })
      if not rid then probe("RIVAL FAIL\n%s", tostring(rerr)) end
      return ("host %d,%d\nrival %d,%d"):format(hx, hy, rx, ry)
    end
    return ("host %d,%d\nno rival cell"):format(hx, hy)
  end

  local function fillArena(world)
    if objectNamed(world, ARENA, WAYBACK_NAME) then return "already placed" end
    local wx, wy = bestCell(world, {})
    if not wx then return "no usable cell" end
    local id, err = mod.world:spawnNpc(ARENA, {
      name = WAYBACK_NAME, sprite = SPRITE_HOST,
      x = wx, y = wy, movement = MOVE_STANDING_DOWN,
    })
    if not id then return "wayback fail: " .. tostring(err) end
    return ("wayback %d,%d"):format(wx, wy)
  end

  local function place(mapId)
    rememberCentre(mapId)
    local world = mod.world:overworld()
    if not world then return end
    if mapId == LOBBY then
      local ok, res = pcall(fillLobby, world)
      probe("IPC v%s\n%s", VERSION, ok and tostring(res) or "ERR " .. tostring(res))
    elseif mapId == ARENA then
      local ok, res = pcall(fillArena, world)
      probe("ARENA OK\n%s", ok and tostring(res) or "ERR " .. tostring(res))
    end
  end

  mod.events:on("map.entered", function(ev)
    local ok, err = pcall(place, ev and ev.mapId)
    if not ok then errs("map.entered\n%s", tostring(err)) end
  end)

  -- setMap skips map.entered on a checkpoint restore.
  mod.events:on("game.ready", function()
    local ok, cur = pcall(function() return mod.world:current() end)
    if ok and cur then pcall(place, cur.mapId) end
  end)

  ----------------------------------------------------------------------
  -- Dialogue, through the kind="none" fall-through. A mod-spawned NPC
  -- carries no scriptKey, so an A press aimed at one falls past every arm
  -- of interactBody and lands here with the faced cell (World.lua:7432).
  ----------------------------------------------------------------------
  local function tryArenaWarp()
    -- Remember where to come back to BEFORE leaving: the return trip is
    -- ours to provide, since nothing in the arena is guaranteed to lead
    -- out. Stored in mod.save so a save made in there still knows.
    local cur = mod.world:current()
    if cur then
      mod.save:set("returnX", cur.x)
      mod.save:set("returnY", cur.y)
    end
    local ok, err = mod.world:warpTo(ARENA, 4, 6, "up")
    probe("WARP %s\n%s", ok and "OK" or "FAIL", tostring(err or "in arena"))
    return ok
  end

  local function talkHost()
    local venue, centreId = currentVenue()
    local rows
    if not venue then
      rows = { { "text", "Step downstairs and\ncome back up --\nI'll find your entry." } }
      probe("NO VENUE\ncentre=%s", tostring(centreId))
    elseif not hasBadge(venue.badge) then
      rows = {
        { "text", ("The %s\n%s is\ninvitation only."):format(venue.town, venue.title) },
        { "text", ("Come back with the\n%s BADGE."):format(venue.badge) },
      }
    else
      rows = {
        { "text", ("Welcome to the\n%s\n%s!"):format(venue.town, venue.title) },
        { "text", "Four rounds. One\nchallenger each.\nNo healing between." },
        { "text", "Your opponent is\nwaiting right here." },
      }
      if mod.options:get("try_colosseum") ~= false then
        rows[#rows + 1] = { "text", "...though the arena\nitself is through\nhere. Mind the step." }
      end
    end

    local sent, serr = mod.world:queueScript(rows, {
      onDone = function()
        if venue and hasBadge(venue.badge)
           and mod.options:get("try_colosseum") ~= false then
          pcall(tryArenaWarp)
        end
      end,
    })
    if not sent then probe("TALK FAIL\n%s", tostring(serr)) end
  end

  local function talkWayBack()
    local x = tonumber(mod.save:get("returnX", nil))
    local y = tonumber(mod.save:get("returnY", nil))
    local sent = mod.world:queueScript({
      { "text", "This way back to\nthe lobby." },
    }, {
      onDone = function()
        local ok, err = mod.world:warpTo(LOBBY, x or 4, y or 6, "down")
        if not ok then probe("BACK FAIL\n%s", tostring(err)) end
      end,
    })
    if not sent then probe("BACK TALK FAIL") end
  end

  mod.events:on("world.interacted", function(ev)
    local ok, err = pcall(function()
      if not ev or ev.kind ~= "none" then return end
      local world = mod.world:overworld()

      if ev.mapId == LOBBY then
        local host = objectNamed(world, LOBBY, HOST_NAME)
        if host and host.x == ev.x and host.y == ev.y then return talkHost() end
      elseif ev.mapId == ARENA then
        local back = objectNamed(world, ARENA, WAYBACK_NAME)
        if back and back.x == ev.x and back.y == ev.y then return talkWayBack() end
      end
    end)
    if not ok then errs("interacted\n%s", tostring(err)) end
  end)

  ----------------------------------------------------------------------
  -- Party substitution, keyed on the CARRIER so it only fires for the
  -- battle this mod staged -- a vanilla COOLTRAINERM NICK elsewhere in
  -- Johto is untouched. next() is called once and its result kept unless
  -- we substitute; skipping it would discard vanilla and every other
  -- mod's contribution.
  ----------------------------------------------------------------------
  -- Roster ROWS, not battle mons. 0.1.6 handed these straight back from the
  -- hook and the opponent arrived with no stats: one Quagsire at 0 HP and a
  -- blank bar. Gen 1's BattleState built the party AFTER the hook; Gen 2
  -- does not -- Battle.lua:258 says outright that "nothing here rewrites
  -- what the hook returned". So whatever we return has to be finished.
  local PROBE_TEAM = {
    { species = "QUAGSIRE", level = 30 },
    { species = "NOCTOWL",  level = 30 },
  }

  -- Built through the engine's OWN party builder rather than Mon.new per
  -- slot, so these mons are constructed exactly like a vanilla trainer's:
  -- level-up movesets via MakeTrainerPartyMon, and the cart's fixed trainer
  -- DVs of 9/8/8/8/8 (Trainers.lua:82-88) which is why a trainer's Rattata
  -- is always the same Rattata. Reimplementing that here would drift.
  --
  -- An internals require, deliberately: there is no mod-facing seam that
  -- turns {species, level} rows into Gen 2 battle mons. Safe for this mod
  -- because it is Gold-only (games: ["gold"]), so the module always exists
  -- when this runs -- a dual-generation mod must NOT copy this.
  local function buildParty(rows)
    local Trainers = require("src.world.gen2.Trainers")
    local data = mod.game and mod.game.data
    if not data then return nil end
    local party = Trainers.party(data, { roster = rows })
    if not party or #party == 0 then return nil end
    return party
  end

  -- :wrap, NOT :on. The loader builds the mod-facing hook api as
  -- `hooks = { wrap = ... }` and nothing else (Loader.lua:929), so
  -- mod.hooks:on is nil -- and calling it throws in the ENTRY CHUNK, which
  -- rolls the whole mod back while the manager still reports Ready. That
  -- is why 0.1.3 spawned nothing at all rather than failing at the hook.
  -- (engine/mods/spanish_ui uses :on; it is wrong, or written against an
  -- older api. Read the loader, not the example mods.)
  -- What arrives here is NOT what the struct carried. Battle.lua:266-267
  -- passes `self.trainer.classId or self.trainer.class` and
  -- `self.trainer.memberId or self.trainer.index or 1`, and the record
  -- Trainers.lookup builds sets classId to the class NAME while carrying
  -- no memberId and no index -- so this hook sees the name and a member
  -- that falls through to 1, not the numbers the struct was given.
  -- Accept either spelling rather than betting on one.
  mod.hooks:wrap("trainer.party", function(next, class, member, party)
    local base = next()
    local ok, res = pcall(function()
      local classHit = (class == CARRIER_CLASS) or (class == carrierClassIx)
      if not classHit then return nil end
      local built = buildParty(PROBE_TEAM)
      if not built then
        -- Returning nil here keeps the vanilla party, which is a real
        -- battle rather than a broken one. A substitution that cannot be
        -- built must never become an opponent with no stats.
        probe("BUILD FAIL\nkeeping vanilla")
        return nil
      end
      probe("PARTY HOOK\n%s / %s\n%d mons", tostring(class), tostring(member), #built)
      return built
    end)
    if ok and res then return res end
    if not ok then probe("HOOK ERR\n%s", tostring(res)) end
    return base
  end)

  mod.log:info("indigo_conference %s loaded", VERSION)
end
