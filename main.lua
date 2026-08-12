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
  local VERSION = "0.2.3"
  local MOD_ID = "indigo_conference"

  mod.exports.version = VERSION
  mod.exports.owns = { trainers = {}, maps = {}, tilesets = {} }

  local LOBBY = "POKECENTER_2F"
  local ARENA = "COLOSSEUM"

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
  -- Levels are RELATIVE to the player's strongest mon, not absolute. 0.2.0
  -- shipped a fixed 28->46 curve written for a post-Elite-Four player, and
  -- on device that made round 1 unbeatable -- the venues are badge-gated
  -- per town and Violet is the FIRST gym, so the qualifier there is early
  -- game. A tournament that can be entered anywhere on the curve cannot
  -- carry fixed levels.
  local CARD = {
    { key = "AJ",      class = "BUG_CATCHER",  member = "DON",
      sprite = "SPRITE_YOUNGSTER",
      intro = "A.J.: My gym never\nlost. Neither do I.",
      -- TEST TEAMS (0.2.3): every card is deliberately Bug/Grass/Steel so a
      -- single Fire type can walk the whole bracket. This is a TESTING
      -- convenience for checking round flow, not the intended matchups --
      -- the real team comps come back once the loop is proven. TODO/CONFIRM
      -- before anything is shown to a player.
      party = { { species = "PARASECT", delta = -3 },   -- Bug/Grass, 4x fire
                { species = "BUTTERFREE", delta = -4 } } },

    { key = "GISELLE", class = "BEAUTY",       member = "VICTORIA",
      sprite = "SPRITE_COOLTRAINER_F",
      intro = "GISELLE: Top class,\ntop school.\fDo keep up.",
      party = { { species = "BELLSPROUT", delta = -1 },
                { species = "SCYTHER", delta = -1 },
                { species = "VICTREEBEL", delta = 0 } } },

    { key = "RITCHIE", class = "SCHOOLBOY",    member = "JACK1",
      sprite = "SPRITE_YOUNGSTER",
      intro = "RITCHIE: Sparky's\nbeen waiting for\na match like this!",
      party = { { species = "TANGELA", delta = 1 },
                { species = "PINSIR", delta = 1 },
                { species = "FORRETRESS", delta = 2 } } },  -- Bug/Steel, 4x

    { key = "WES",     class = "COOLTRAINERM", member = "NICK",
      sprite = "SPRITE_COOLTRAINER_M",
      intro = "WES: I came a long\nway from ORRE.\fDon't waste it.",
      party = { { species = "JUMPLUFF", delta = 3 },
                { species = "EXEGGUTOR", delta = 3 },
                { species = "VILEPLUME", delta = 3 },
                { species = "SCIZOR", delta = 5 } } },     -- Bug/Steel, 4x
  }

  -- The player's strongest mon, which the card scales against. Their LEAD
  -- would punish anyone carrying a low-level HM mule in slot 1, and their
  -- average would make a six-mon box team trivial.
  local function topLevel()
    local save = mod.game and mod.game.save
    local best = 5
    for _, mon in ipairs((save and save.party) or {}) do
      local l = tonumber(mon and mon.level)
      if l and l > best then best = l end
    end
    return best
  end

  local function scaled(rows)
    local top = topLevel()
    local out = {}
    for _, row in ipairs(rows) do
      local lv = top + (row.delta or 0)
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
    mod.content.text:register(foe.lossKey, "Come back stronger.")
    foe.round = i
  end

  ----------------------------------------------------------------------
  -- Venues, keyed by the centre whose stairs were climbed. Map ids from
  -- rom_manifest_gold.json, badge keys from Battle.lua:193.
  ----------------------------------------------------------------------
  local VENUES = {
    VIOLET_POKECENTER_1F     = { town = "VIOLET",     title = "QUALIFIER" },
    GOLDENROD_POKECENTER_1F  = { town = "GOLDENROD",  title = "OPEN" },
    ECRUTEAK_POKECENTER_1F   = { town = "ECRUTEAK",   title = "INVITATIONAL" },
    BLACKTHORN_POKECENTER_1F = { town = "BLACKTHORN", title = "MASTERS" },
    INDIGO_PLATEAU_POKECENTER_1F = { town = "INDIGO PLATEAU",
                                     title = "CONFERENCE" },
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

  local function venue()
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

  local function fillLobby(world)
    censusWarps(world, LOBBY)
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
  local function hidePlaceholders(world)
    local def = world and world.maps and world.maps[ARENA]
    for i, obj in ipairs(def and def.objects or {}) do
      local name = tostring(obj.name or "")
      if name ~= FOE_NAME and name ~= EXIT_NAME and name ~= HOST_NAME
         and name:sub(1, 3) == "POK" then
        -- objRef is the object's 1-based index or its extracted name; the
        -- index is used because these names carry a non-ASCII "é".
        pcall(function() mod.world:toggleObject(ARENA, i, false) end)
      end
    end
  end

  local function fillArena(world)
    censusArena(world)
    censusWarps(world, ARENA)
    hidePlaceholders(world)
    local taken = {}
    local out = {}

    if not objectNamed(world, ARENA, EXIT_NAME) then
      local ex, ey = bestCell(world, taken)
      if ex then
        taken[#taken + 1] = { ex, ey }
local eid =         mod.world:spawnNpc(ARENA, {
          name = EXIT_NAME, sprite = SPRITE_HOST,
          x = ex, y = ey, movement = MOVE_STANDING_DOWN,
        })
        spawnedIds[EXIT_NAME] = eid
        out[#out + 1] = "exit ok"
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
  mod.events:on("battle.ended", function(ev)
    local ok, err = pcall(function()
      if not pending() then return end
      setPending(false)
      local res = ev and ev.result
      probe("BATTLE %s", tostring(res))
      -- Anything but a win leaves the same challenger standing.
      if res ~= "win" then return end
      local n = round() + 1
      setRound(n)
      probe(n > ROUNDS and "CARD CLEARED" or ("ROUND %d"):format(n))
    end)
    if not ok then errs("battle.ended\n%s", tostring(err)) end
  end)

  local function place(mapId)
    if VENUES[mapId] then mod.save:set("lastCentre", mapId) end
    local world = mod.world:overworld()
    if not world then return end
    if mapId == LOBBY then
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
  local function enterArena()
    local cur = mod.world:current()
    if cur then
      mod.save:set("backX", cur.x)
      mod.save:set("backY", cur.y)
    end
    -- Arrive on one of the arena's OWN warp tiles: it is guaranteed
    -- walkable and is where the game itself puts a player, so no cell has
    -- to be guessed. Falls back to the middle of a 10x8 room.
    local def = mod.world:overworld()
    def = def and def.maps and def.maps[ARENA]
    local w = def and def.warps and def.warps[1]
    local ok, err = mod.world:warpTo(ARENA, (w and w.x) or 4, (w and w.y) or 6, "up")
    probe("WARP %s\n%s", ok and "OK" or "FAIL", tostring(err or ""))
    return ok
  end

  local function talkHost()
    local v = venue()
    local town = (v and v.town) or "INDIGO"
    local title = (v and v.title) or "CONFERENCE"
    local r = round()
    local rows

    if r > ROUNDS then
      rows = {
        { "text", ("The %s\n%s is\nyours."):format(town, title) },
        { "text", "Come back any time\nand we'll draw a\nnew card." },
      }
      setRound(1)   -- repeatable: clearing the card redraws it
    elseif r == 1 then
      rows = {
        { "text", ("Welcome to the\n%s\n%s!"):format(town, title) },
        { "text", ("%d rounds. One\nchallenger each.\nThrough here."):format(ROUNDS) },
      }
    else
      rows = { { "text", ("Round %d of %d.\nThey're waiting."):format(r, ROUNDS) } }
    end

    local sent, serr = mod.world:queueScript(rows, {
      onDone = function()
        if round() <= ROUNDS then pcall(enterArena) end
      end,
    })
    if not sent then probe("TALK FAIL\n%s", tostring(serr)) end
  end

  local function talkExit()
    local x = tonumber(mod.save:get("backX", nil))
    local y = tonumber(mod.save:get("backY", nil))
    mod.world:queueScript({ { "text", "This way out." } }, {
      onDone = function()
        local ok, err = mod.world:warpTo(LOBBY, x or 4, y or 6, "down")
        if not ok then probe("BACK FAIL\n%s", tostring(err)) end
      end,
    })
  end

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
        local e = objectNamed(world, ARENA, EXIT_NAME)
        if e and e.x == ev.x and e.y == ev.y then return talkExit() end
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
      local built = buildParty(scaled(foe.party))
      if not built then
        -- Keep the vanilla party rather than field an opponent with no
        -- stats. A real battle beats a broken one.
        probe("BUILD FAIL\n%s", foe.key)
        return nil
      end
      setPending(true)
      probe("R%d %s\n%d mons Lv%d", foe.round, foe.key, #built, topLevel())
      return built
    end)
    if ok and res then return res end
    if not ok then probe("HOOK ERR\n%s", tostring(res)) end
    return base
  end)

  mod.log:info("indigo_conference %s loaded", VERSION)
end
