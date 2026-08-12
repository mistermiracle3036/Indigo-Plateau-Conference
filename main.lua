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
-- WHY CARRIERS RATHER THAN OWN TRAINER RECORDS. Schemas.lua:1083 shows the
-- Gen 2 trainers registry takes a `trainers` list whose members carry their
-- own name and party, which would give each challenger their real name.
-- Appending to an existing class needs `__append` to survive the Gen 2
-- write path, and that is UNVERIFIED -- so this build rides the mechanism
-- already proven on device and uses four different vanilla carriers, which
-- at least makes the four opponents visibly distinct. Real names are the
-- next step, not this one. TODO/CONFIRM.
--
-- Verified against gen1recomp v0.1.79.

local Runtime = require("src.mods.Runtime")

return function(mod)
  local VERSION = "0.5.0"
  local MOD_ID = "indigo_conference"

  mod.exports.version = VERSION
  mod.exports.owns = { trainers = {}, maps = {}, tilesets = {} }

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

  -- SPRITEMOVEDATA_STANDING_DOWN (src/world/gen2/Npc.lua MOVE table).
  -- Numeric: the Gen 2 arm compares def.movement against numbers.
  local MOVE_STANDING_DOWN = 6
  local SPRITE_HOST = "SPRITE_GENTLEMAN"

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
  local CARD = {
    -- REAL TEAM COMPS (0.4.0). The fire-weak test card is gone; these are
    -- the intended matchups. Every species verified against
    -- rom_manifest_gold.json before it was written here.
    --
    -- `delta` is now an offset from the ROUND's base level, and the base
    -- comes from the town's own gym leader -- see levelBase below.
    { key = "AJ",      class = "BUG_CATCHER",  member = "DON",
      sprite = "SPRITE_YOUNGSTER",
      intro = "A.J.: My gym\nnever lost.\fNeither do I.",
      party = { { species = "SANDSLASH", delta = 0 },
                { species = "BUTTERFREE", delta = -1 },
                { species = "PRIMEAPE", delta = 0 } } },

    { key = "GISELLE", class = "BEAUTY",       member = "VICTORIA",
      sprite = "SPRITE_COOLTRAINER_F",
      intro = "GISELLE: Top class,\ntop school.\fDo keep up.",
      party = { { species = "CUBONE", delta = -1 },
                { species = "GRAVELER", delta = 0 },
                { species = "WIGGLYTUFF", delta = 0 } } },

    -- BROCK is a real Gold trainer CLASS with one member, BROCK1, plus a
    -- SPRITE_BROCK overworld sprite. Using a leader as their OWN carrier is
    -- the answer to the naming problem for this whole family: the battle
    -- announces the class's real name and shows the real portrait, with no
    -- registry trick at all. Kanto's leaders and the Elite Four are all in
    -- that table (MISTY, LT_SURGE, ERIKA, JANINE, KOGA, WILL, KAREN, BRUNO,
    -- CHAMPION/LANCE), which is exactly the "shouldn't see them yet" cast
    -- the circuit wants.
    { key = "BROCK",   class = "BROCK",        member = "BROCK1",
      sprite = "SPRITE_BROCK",
      intro = "BROCK: PEWTER's\nleader, out here?\fI travel too.",
      party = { { species = "GRAVELER", delta = -1 },
                { species = "RHYHORN", delta = 0 },
                { species = "KABUTOPS", delta = 0 },
                { species = "ONIX", delta = 1 } } },

    { key = "WES",     class = "COOLTRAINERM", member = "NICK",
      sprite = "SPRITE_COOLTRAINER_M",
      intro = "WES: I came far\nfrom ORRE.\fDon't waste it.",
      -- Espeon and Umbreon are the point of him being here rather than on
      -- Gen 1, where his team had to be the three original Eeveelutions.
      party = { { species = "ESPEON", delta = 0 },
                { species = "UMBREON", delta = 0 },
                { species = "JOLTEON", delta = 0 },
                { species = "PERSIAN", delta = 2 } } },
  }

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

  local function levelBase(foe)
    local v = venue()
    local top = v and v.leader and leaderTop(v.leader)
    -- No venue known yet, or a leader whose party could not be read: fall
    -- back to the player so the bracket is still playable rather than
    -- defaulting to some fixed number that could be wildly off.
    if not top then
      local save = mod.game and mod.game.save
      top = 5
      for _, mon in ipairs((save and save.party) or {}) do
        local l = tonumber(mon and mon.level)
        if l and l > top then top = l end
      end
      probe("NO LEADER\nfell back Lv%d", top)
      return top
    end
    return top + LEADER_STEP + ((foe.round - 1) * ROUND_STEP)
  end

  local function scaled(foe)
    local base = levelBase(foe)
    local out = {}
    for _, row in ipairs(foe.party) do
      local lv = base + (row.delta or 0)
      if lv < 2 then lv = 2 elseif lv > 100 then lv = 100 end
      out[#out + 1] = { species = row.species, level = lv }
    end
    return out
  end

  for i, foe in ipairs(CARD) do
    foe.seenKey = "IPC_SEEN_" .. foe.key
    foe.winKey  = "IPC_WIN_"  .. foe.key
    foe.lossKey = "IPC_LOSS_" .. foe.key
    mod.content.text:register(foe.seenKey, foe.intro)
    mod.content.text:register(foe.winKey,  "...Well fought.")
    -- the loss line carries the elimination rule, so the player is told
    -- in-fiction rather than discovering their bracket reset at the host
    mod.content.text:register(foe.lossKey,
      "You're out of the\nrunning.\fStart over at\nround one.")
    foe.round = i
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
      label = "Diagnostic rows", default = true },
  })

  -- "unless explicitly false", never "if true": an option toggled on a Gold
  -- boot never round-trips (the manager writes Gold's nested block, the
  -- loader reads the top-level one), so this read can come back nil -- and
  -- `if get() then` would remove the only diagnostic channel there is.
  local function probe(fmt, ...)
    if mod.options:get("probe_rows") == false then return end
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
  -- Run state. mod.save, not mod.storage: this has to travel with the
  -- in-game SAVE so loading an earlier file rewinds the tournament too.
  ----------------------------------------------------------------------
  local function round()   return tonumber(mod.save:get("round", 1)) or 1 end
  local function pending() return mod.save:get("pending", false) == true end

  local function setRound(n) mod.save:set("round", n) end
  local function setPending(v) mod.save:set("pending", v and true or false) end

  local function currentFoe() return CARD[round()] end

  -- Assignment, not `local function`: the local is declared up beside
  -- levelBase, which calls this.
  venue = function()
    local id = mod.save:get("lastCentre", nil)
    return id and VENUES[id] or nil, id
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
    for i, row in ipairs(cls.trainers or {}) do
      if row.id == foe.member or row.name == foe.member then
        foe.classIx, foe.memberIx = cls.index, i
        return true
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

  local function despawn(name)
    local id = spawnedIds[name]
    if not id then return end
    spawnedIds[name] = nil
    pcall(function() mod.world:removeNpc(id) end)
  end

  ----------------------------------------------------------------------
  -- Spawning
  ----------------------------------------------------------------------
  -- One-shot warp census. The void bug points at the warp being the wrong
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
  local warpsCensused = {}

  local function censusWarps(world, mapId)
    if warpsCensused[mapId] then return end
    warpsCensused[mapId] = true
    local def = world and world.maps and world.maps[mapId]
    local rows = {}
    for i, w in ipairs(def and def.warps or {}) do
      rows[#rows + 1] = ("%d %d,%d>%s"):format(i, w.x or -1, w.y or -1,
        tostring(w.destMap or w.map or "?"):sub(1, 8))
    end
    if #rows == 0 then probe("%s NO WARPS", mapId:sub(1, 10))
    else probe("%s WARPS\n%s", mapId:sub(1, 8),
               table.concat(rows, "\n", 1, math.min(#rows, 4))) end
  end

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

  local function censusLobbyObjects(world)
    local def = world and world.maps and world.maps[LOBBY]
    local rows = {}
    for i, obj in ipairs(def and def.objects or {}) do
      local name = tostring(obj.name or ("#" .. i))
      if name ~= HOST_NAME then
        rows[#rows + 1] = ("%s %d,%d"):format(name:sub(1, 8), obj.x or -1, obj.y or -1)
      end
    end
    if #rows > 0 then
      probe("2F OBJS\n%s", table.concat(rows, "\n", 1, math.min(#rows, 4)))
    end
  end

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
    censusWarps(world, LOBBY)
    censusLobbyObjects(world)
    -- Redress the arena's link pair NOW, from the lobby: the pool builds
    -- them from the def on the player's first arena entry, and the lobby is
    -- the room every player must cross to get there.
    redressPlaceholders(world)
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

  -- One-shot census of whatever the arena already contains. The developer
  -- reported "the link player" standing in there; before hiding a vanilla
  -- object we need to know what it IS -- toggleObject on Gen 2 sets the
  -- object's MAPOBJECT_EVENT_FLAG, which is real save state and persists,
  -- so it is not something to fire at an unidentified sprite.
  local censused = false

  local function censusArena(world)
    if censused then return end
    censused = true
    local def = world and world.maps and world.maps[ARENA]
    local rows = {}
    for i, obj in ipairs(def and def.objects or {}) do
      local name = tostring(obj.name or ("#" .. i))
      if name ~= FOE_NAME and name ~= EXIT_NAME then
        rows[#rows + 1] = ("%s %s %d,%d"):format(
          name:sub(1, 6), tostring(obj.sprite or "?"):gsub("^SPRITE_", ""):sub(1, 6),
          obj.x or -1, obj.y or -1)
      end
    end
    if #rows == 0 then probe("ARENA EMPTY\nno vanilla obj")
    else probe("ARENA OBJS\n%s", table.concat(rows, "\n", 1, math.min(#rows, 4))) end
  end

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
    censusArena(world)
    censusWarps(world, ARENA)
    -- Order matters: repair the flags first (needs the arena active),
    -- then repaint anything the pool built before the lobby could redress.
    repaintLive(world)
    local taken = {}
    local out = {}

    -- No exit attendant any more: the arena's own bottom door leads out.
    despawn(EXIT_NAME)

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
      return "R" .. foe.round .. " up"
    end
    despawn(FOE_NAME)
    spawnedFoeKey = nil

    local ok, why = resolveCarrier(foe)
    if not ok then probe("CARRIER FAIL\n%s", tostring(why)); return "carrier" end

    local fx, fy = bestCell(world, taken)
    if not fx then return "no foe cell" end
    local id, err = mod.world:spawnNpc(ARENA, {
      name = FOE_NAME, sprite = foe.sprite,
      x = fx, y = fy, movement = MOVE_STANDING_DOWN,
      -- No `event` flag on purpose: with none, trainerflagaction CHECK
      -- reads 0 and the already-beaten branch never fires, so a rematch is
      -- always possible. Round progress is this mod's own state instead --
      -- allocating a ROM event index would be a guessed constant.
      trainer = { class = foe.classIx, member = foe.memberIx,
                  seenText = foe.seenKey, winText = foe.winKey,
                  lossText = foe.lossKey },
    })
    if not id then return "foe fail " .. tostring(err) end
    spawnedIds[FOE_NAME] = id
    spawnedFoeKey = foe.key
    out[#out + 1] = ("R%d %s"):format(foe.round, foe.key)
    return table.concat(out, "\n")
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
      local world = mod.world:overworld()
      if world and world.scriptVars then
        world.scriptVars[VAR_BATTLETYPE] = BATTLETYPE_CANLOSE
        probe("CANLOSE ON")
      end
    end)
    if not ok then errs("engaged\n%s", tostring(err)) end
  end)

  mod.events:on("battle.ended", function(ev)
    local ok, err = pcall(function()
      if not pending() then return end
      setPending(false)
      local res = ev and ev.result
      probe("BATTLE %s", tostring(res))
      if res ~= "win" then
        -- A tournament loss is an elimination, not a wipeout: the battle
        -- was CANLOSE so no blackout is coming, and the party is healed
        -- where they stand -- the developer's Battle Tower reading. hp and
        -- status only; PP stays spent, which keeps a retry from being free.
        for _, mon in ipairs((mod.game and mod.game.save and mod.game.save.party) or {}) do
          if mon and mon.stats and mon.stats.hp then
            mon.hp = mon.stats.hp
            mon.status = nil
          end
        end
        -- ELIMINATION (0.5.0, the developer's call -- and the answer to the
        -- oldest open question in the original design doc): a loss ends the
        -- RUN, not the round. Back to round 1; the next map refresh swaps
        -- the floor via fillArena, since spawnedFoeKey no longer matches.
        -- Pairs with the drawn-card plan: a new run will mean a new field.
        if round() > 1 then
          setRound(1)
          probe("ELIMINATED\nback to R1")
        end
        -- THE ESCORT, and it is the vanilla one. The scene that caused the
        -- void IS the being-walked-out choreography, and it plays correctly
        -- when the player stands at the door. So the loss deliberately does
        -- NOT disarm it: after the map settles (battle.ended is too early --
        -- the battle screen is still coming down), the host's line plays and
        -- the player is warped to the 2F door cell, the same arrival a real
        -- Colosseum exit produces, and the armed scene walks them out past
        -- the counter. Every other non-door exit still disarms via place().
        escortPending = true
        return
      end
      local n = round() + 1
      setRound(n)
      probe(n > ROUNDS and "CARD CLEARED" or ("ROUND %d"):format(n))
    end)
    if not ok then errs("battle.ended\n%s", tostring(err)) end
  end)

  local function place(mapId)
    if VENUES[mapId] then mod.save:set("lastCentre", mapId) end
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
  mod.events:on("map.reloaded", function()
    local ok, err = pcall(function()
      local cur = mod.world:current()
      if cur and cur.mapId == ARENA then
        local world = mod.world:overworld()
        if world then fillArena(world) end
        if escortPending then
          escortPending = false
          -- Host's line, then the warp to the 2F DOOR CELL -- the same
          -- arrival a genuine Colosseum exit produces, so the still-armed
          -- vanilla escort scene fires from the position its choreography
          -- assumes and walks the player out past the counter.
          -- TODO/CONFIRM on device: landing exactly on (9,0) must not
          -- re-trigger the door warp back in; if it does, land on (9,1).
          local sent = mod.world:queueScript({
            { "text", "GENTLEMAN: That's\nthe tournament.\fThis way, please." },
            { "warp", LOBBY, ARENA_DOOR_X, ARENA_DOOR_Y, "down" },
          })
          if not sent then probe("ESCORT FAIL") end
        end
      end
    end)
    if not ok then errs("map.reloaded\n%s", tostring(err)) end
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

  local function talkHost()
    local v = venue()
    local town = (v and v.town) or "INDIGO"
    local title = (v and v.title) or "CONFERENCE"
    local r = round()
    local rows

    if r > ROUNDS then
      rows = {
        { "text", ("The %s\n%s is yours."):format(town, title) },
        { "text", "Come back and\nwe'll draw again." },
      }
      setRound(1)   -- repeatable: clearing the card redraws it
    elseif r == 1 then
      rows = {
        { "text", ("Welcome to the\n%s %s!"):format(town, title) },
        { "text", ("%d rounds. One\nchallenger each."):format(ROUNDS) },
        { "text", "Through the far\ndoor. Good luck." },
      }
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
        -- the floor may be a round out of date if the reload was missed
        pcall(fillArena, world)
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
      local foe = currentFoe()
      if not foe then return nil end
      if class ~= foe.class and class ~= foe.classIx then return nil end
      local built = buildParty(scaled(foe))
      if not built then
        -- Keep the vanilla party rather than field an opponent with no
        -- stats. A real battle beats a broken one.
        probe("BUILD FAIL\n%s", foe.key)
        return nil
      end
      setPending(true)
      -- Report the level actually used, so a wrong anchor is visible on the
      -- screen rather than inferred from how hard the battle felt.
      probe("R%d %s\n%d mons Lv%d", foe.round, foe.key, #built,
            built[1] and built[1].level or -1)
      return built
    end)
    if ok and res then return res end
    if not ok then probe("HOOK ERR\n%s", tostring(res)) end
    return base
  end)

  mod.log:info("indigo_conference %s loaded", VERSION)
end
