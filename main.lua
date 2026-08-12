-- Indigo Plateau Conference -- a Colosseum circuit for Johto.
--
-- PREMISE (v0.1.1 rebuild). Gold's COLOSSEUM map (group 20, map 3) is the
-- link-battle room reached by the stairs in every Pokemon Center. In a
-- single-player recomp nothing uses it. This mod puts a tournament in it:
-- which town's stairs you climbed decides which bracket you get, so ONE
-- vanilla map hosts five different events and the mod ships no maps, no
-- tilesets and no warps of its own.
--
-- WHY THIS BUILD IS A PROBE, NOT CONTENT. Three things had to be true. Two
-- are proven, one is not:
--
--   PROVEN  Owned NPCs with dialogue work on Gold, via the
--           world.interacted kind="none" fall-through plus queueScript --
--           court_of_noctowl 0.1.2 did it on device 2026-08-11.
--   PROVEN  The trainer.party hook fires on Gold with the same three
--           arguments as Gen 1, and src/battle/gen2/Battle.lua:258 states
--           that rows a mod builds itself are kept verbatim.
--   NOT     That a mod can START a trainer battle at all. queueScript's
--           start_battle verb is WILD ONLY and says so
--           (src/world/gen2/WorldAPI.lua:228) -- the trainer arm "needs a
--           party out of the extracted trainer table and an OPP_CLASS the
--           mod cannot name". The only other door found in source is
--           World:interactBody:7330: an object whose def.trainer is set
--           engages via startTrainerScript, which reads record.class and
--           record.member (World.lua:7200-7206) and pulls the party out of
--           the cart's own table.
--
-- So the route this build tests is: spawn an NPC carrying a VANILLA class
-- and member as a CARRIER, let the cart start its battle, and use
-- trainer.party to substitute our own roster. If that works, every
-- remaining question is content. If it does not, the mod needs a different
-- foundation and no roster work has been wasted -- which is exactly why no
-- roster is written yet.
--
-- Verified against gen1recomp 0.1.78. Anything not read from source is
-- marked TODO/CONFIRM.

local Runtime = require("src.mods.Runtime")

return function(mod)
  local VERSION = "0.1.1"
  local MOD_ID = "indigo_conference"

  mod.exports.version = VERSION
  mod.exports.owns = { trainers = {}, maps = {}, tilesets = {} }

  local VENUE_MAP = "COLOSSEUM"
  local HOST_NAME = "IPC_HOST"
  local RIVAL_NAME = "IPC_PROBE_OPPONENT"

  -- SPRITEMOVEDATA_STANDING_DOWN. src/world/gen2/Npc.lua MOVE table.
  -- NUMERIC on purpose: the Gen 2 arm of NPC.new compares def.movement
  -- against numbers and only the Gen 1 compat arm reads "STAY".
  local MOVE_STANDING_DOWN = 6

  -- constants.spriteOrder, rom_manifest_gold.json.
  local SPRITE_HOST = "SPRITE_GENTLEMAN"
  local SPRITE_RIVAL = "SPRITE_COOLTRAINER_M"

  -- The CARRIER. A real class and member out of constants.trainerClassOrder
  -- / trainerClassMembers, because startTrainerScript resolves the party
  -- through the cart's table and a name we invented is not in it. The team
  -- is replaced wholesale by the trainer.party hook below, so the only
  -- thing inherited is the battle intro -- whether THAT can be overridden
  -- is TODO/CONFIRM and is one of the things this build reports.
  local CARRIER_CLASS = "COOLTRAINERM"
  local CARRIER_MEMBER = "NICK"

  ----------------------------------------------------------------------
  -- The circuit. Keyed by the Pokemon Center whose stairs were climbed.
  -- Every map id and badge key below was read from
  -- rom_manifest_gold.json / src/battle/gen2/Battle.lua:193 -- none guessed.
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
    -- The capstone, and why the mod still carries its name.
    INDIGO_PLATEAU_POKECENTER_1F = { town = "INDIGO PLATEAU", badge = "RISING",
                                     title = "CONFERENCE", capstone = true },
  }

  ----------------------------------------------------------------------
  -- Diagnostics. mod.log goes to a console that does not exist on iOS;
  -- Runtime.reportError renders in the manager's [ERRS] screen, which is
  -- the only channel the developer can actually read on device.
  ----------------------------------------------------------------------
  local function errs(fmt, ...)
    local ok, msg = pcall(string.format, fmt, ...)
    pcall(Runtime.reportError, MOD_ID, ok and msg or tostring(fmt))
  end

  mod.options:define({
    { key = "probe_rows", type = "toggle",
      label = "Diagnostic rows", default = true },
  })

  local function probe(fmt, ...)
    if mod.options:get("probe_rows") then errs(fmt, ...) end
  end

  ----------------------------------------------------------------------
  -- Which venue is this? The player cannot reach COLOSSEUM without walking
  -- through a Pokemon Center, so remembering the last one entered is
  -- enough. Persisted through mod.save because a save made UPSTAIRS
  -- reloads straight into the Colosseum with no 1F visit behind it.
  --
  -- The engine keeps its own equivalent -- the backup-warp triple that
  -- lets the shared staircase find the right way down (World.lua:8554) --
  -- but that lives on the World, and reading it would mean an internals
  -- reach this mod deliberately does not need.
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
  -- Spawning. Runtime objects are never serialized and never enter the
  -- map-data merge, so no other mod's `maps` patch can clobber these and
  -- this mod clobbers nobody. addRuntimeObject appends to a run-lifetime
  -- table, so every spawn MUST check the live list first or map.entered
  -- stacks a new copy on each visit.
  ----------------------------------------------------------------------
  local function objectNamed(world, name)
    local def = world and world.maps and world.maps[VENUE_MAP]
    for _, obj in ipairs(def and def.objects or {}) do
      if obj.name == name then return obj end
    end
    return nil
  end

  -- COLOSSEUM is 5x4 blocks. Rather than hardcode a cell, take the first
  -- walkable one that also has a walkable neighbour -- an NPC the player
  -- cannot stand beside cannot be talked to, which is how court_of_noctowl
  -- 0.1.1 stranded Falkner in a one-tile pocket.
  local NEIGHBOURS = { { 0, -1 }, { 0, 1 }, { -1, 0 }, { 1, 0 } }

  local function freeCell(world, skip)
    local map = world and world.maps and world.maps[VENUE_MAP]
    if not map then return nil end
    local w = (map.width or 5) * 2
    local h = (map.height or 4) * 2
    local live = world.maps[VENUE_MAP].objects or {}
    for y = 0, h - 1 do
      for x = 0, w - 1 do
        local taken = (skip and skip[1] == x and skip[2] == y)
        if not taken then
          for _, o in ipairs(live) do
            if o.x == x and o.y == y then taken = true break end
          end
        end
        if not taken then
          for _, d in ipairs(NEIGHBOURS) do
            local nx, ny = x + d[1], y + d[2]
            if nx >= 0 and ny >= 0 and nx < w and ny < h then
              return x, y
            end
          end
        end
      end
    end
    return nil
  end

  local function spawnAll()
    local world = mod.world:overworld()
    if not world then return "no overworld" end
    if objectNamed(world, HOST_NAME) then return "already placed" end

    local hx, hy = freeCell(world, nil)
    if not hx then return "no usable cell" end

    local id, err = mod.world:spawnNpc(VENUE_MAP, {
      name = HOST_NAME, sprite = SPRITE_HOST,
      x = hx, y = hy, movement = MOVE_STANDING_DOWN,
    })
    if not id then return "host spawn failed: " .. tostring(err) end

    -- The probe opponent. def.trainer is the whole experiment: if
    -- interactBody's trainer arm picks this up, a mod CAN start a trainer
    -- battle on Gold.
    local rx, ry = freeCell(world, { hx, hy })
    if rx then
      local rid, rerr = mod.world:spawnNpc(VENUE_MAP, {
        name = RIVAL_NAME, sprite = SPRITE_RIVAL,
        x = rx, y = ry, movement = MOVE_STANDING_DOWN,
        trainer = { class = CARRIER_CLASS, member = CARRIER_MEMBER },
      })
      if not rid then probe("RIVAL FAIL\n%s", tostring(rerr)) end
    end

    return ("host %d,%d"):format(hx, hy)
  end

  local function place(mapId)
    rememberCentre(mapId)
    if mapId ~= VENUE_MAP then return end
    local ok, res = pcall(spawnAll)
    probe("IPC v%s\n%s", VERSION, ok and tostring(res) or "ERR " .. tostring(res))
  end

  mod.events:on("map.entered", function(ev)
    local ok, err = pcall(place, ev and ev.mapId)
    if not ok then errs("map.entered\n%s", tostring(err)) end
  end)

  -- setMap skips map.entered on a checkpoint restore, so a save loaded
  -- while already standing in the Colosseum needs this second path.
  mod.events:on("game.ready", function()
    local ok, cur = pcall(function() return mod.world:current() end)
    if ok and cur then pcall(place, cur.mapId) end
  end)

  ----------------------------------------------------------------------
  -- The host's dialogue, through the kind="none" fall-through. A
  -- mod-spawned NPC carries no scriptKey, so an A press aimed at one falls
  -- past every arm of interactBody and lands here with the faced cell's
  -- coordinates (World.lua:7432).
  ----------------------------------------------------------------------
  mod.events:on("world.interacted", function(ev)
    local ok, err = pcall(function()
      if not ev or ev.mapId ~= VENUE_MAP or ev.kind ~= "none" then return end
      local world = mod.world:overworld()
      local host = objectNamed(world, HOST_NAME)
      if not (host and host.x == ev.x and host.y == ev.y) then return end

      local venue, centreId = currentVenue()
      local rows
      if not venue then
        -- Saved upstairs before ever passing a listed centre.
        rows = { { "text", "Step downstairs and\ncome back up -- I'll\nfind your entry." } }
        probe("NO VENUE\ncentre=%s", tostring(centreId))
      elseif not hasBadge(venue.badge) then
        rows = {
          { "text", ("The %s\n%s is invitation\nonly."):format(venue.town, venue.title) },
          { "text", ("Come back with the\n%s BADGE."):format(venue.badge) },
        }
      else
        rows = {
          { "text", ("Welcome to the\n%s\n%s!"):format(venue.town, venue.title) },
          { "text", "Four rounds. One\nchallenger each.\nNo healing between." },
          { "text", "Your opponent is\nwaiting. Talk to\nthem when ready." },
        }
      end

      local sent, serr = mod.world:queueScript(rows)
      if not sent then probe("TALK FAIL\n%s", tostring(serr)) end
    end)
    if not ok then errs("interacted\n%s", tostring(err)) end
  end)

  ----------------------------------------------------------------------
  -- The party substitution. Keyed on the CARRIER, so it only ever fires
  -- for the battle this mod started -- a vanilla COOLTRAINERM NICK
  -- elsewhere in Johto is untouched.
  --
  -- next() is called once and its result kept unless we substitute:
  -- skipping it would discard vanilla and every other mod's contribution.
  ----------------------------------------------------------------------
  local PROBE_TEAM = {
    { species = "QUAGSIRE", level = 30 },
    { species = "NOCTOWL",  level = 30 },
  }

  mod.hooks:on("trainer.party", function(next, class, member, party)
    local base = next()
    local ok, res = pcall(function()
      if class ~= CARRIER_CLASS or member ~= CARRIER_MEMBER then return nil end
      probe("PARTY HOOK\n%s %s", tostring(class), tostring(member))
      return PROBE_TEAM
    end)
    if ok and res then return res end
    if not ok then probe("HOOK ERR\n%s", tostring(res)) end
    return base
  end)

  mod.log:info("indigo_conference %s loaded", VERSION)
end
