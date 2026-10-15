-- Engine-backed load test for 1.1.69's species registration (A-0080).
-- Run from the engine checkout:
--   luajit ../Indigo-Plateau-Conference/tests/species_harness.lua [ipc dir] [expanded-species dir]
-- Proves, on the real Loader and the real embedded runtime:
--   * Gen 1/2 (default): IPC registers NO species and reports nothing;
--   * Expanded: all of species_index.lua registers, nothing in [ERRS];
--   * Expanded beside the Expanded Species framework, in both load orders:
--     same species, no conflict.
package.path = "./?.lua;./?/init.lua;" .. package.path
love = love or require("tests.love_stub")
local GameVersion = require("src.core.GameVersion")
GameVersion.current = "crystal"
require("src.core.Version").engine = "0.3.51"
local Sdk = require("tests.modkit.sdk")
local SaveData = require("src.core.SaveData")
local Runtime = require("src.mods.Runtime")

local IPC = ((arg and arg[1]) or "../Indigo-Plateau-Conference"):gsub("\\", "/")
local ES = ((arg and arg[2]) or "../Expanded-Species"):gsub("\\", "/")
local ROOT = IPC:match("^(.*)/[^/]+$")
local function folder(p) return (p:match("/([^/]+)$")) end

local index = assert(loadfile(IPC .. "/species_index.lua"))()

local pass, fail = 0, 0
local function check(ok, what)
  if ok then pass = pass + 1 else fail = fail + 1; print("FAIL " .. what) end
end

-- The fixture dataset is Gen 1 only, so IPC's vanilla trainer patches would
-- not resolve. Merge into the real imported Crystal data instead: every
-- generated file, keyed by its name (pokemon, moves, trainers, ...).
local CACHE = (os.getenv("APPDATA") or ""):gsub("\\", "/") .. "/pokemon-love2d/crystal/data/generated/"
local function crystalData()
  local data = {}
  local names = { "pokemon", "moves", "trainers", "items", "maps", "events", "sprites",
                  "icons", "palettes", "pokedex", "text", "constants", "encounters",
                  "type_chart", "tilesets", "scripts", "marts", "landmarks",
                  -- data.audio.cries: the derived cries (1.1.76) name vanilla
                  -- bases, which the loader resolves against it
                  "audio" }
  for _, n in ipairs(names) do
    local f = loadfile(CACHE .. n .. ".lua")
    if f then data[n] = f() end
  end
  return data
end

local realLoadOptions = SaveData.loadOptions
local function boot(folders, teamSet)
  SaveData.loadOptions = function(...)
    local o = realLoadOptions(...) or {}
    o.modOptions = o.modOptions or {}
    o.modOptions.indigo_conference = { team_set = teamSet }
    o.mods = o.mods or {}
    for _, f in ipairs(folders) do o.mods[f] = nil end
    return o
  end
  local run
  for _ = 1, 4 do   -- Windows FsIo.isDir flake (memory: harness-mod-absent-flake)
    run = Sdk.loadMods(folders, { generation = 2, root = ROOT, data = crystalData() })
    local m = run.mods.indigo_conference
    if m and m.state == "loaded" then break end
    if #(run.errors or {}) > 0 then break end
    run.release()
  end
  SaveData.loadOptions = realLoadOptions
  return run
end

local function ipcErrors(run)
  local out = {}
  for _, e in ipairs(run.errors or {}) do out[#out + 1] = tostring(e.message or e.msg or e) end
  for _, e in ipairs(Runtime.errors or {}) do
    local who = type(e) == "table" and (e.modId or e.mod) or nil
    if who == "indigo_conference" then out[#out + 1] = tostring(e.message or e.msg or e[2]) end
  end
  return out
end

local function registered(run, id)
  local reg = run.loader.registries and run.loader.registries.pokemon
  if reg and reg.get then return reg:get(id) ~= nil end
  return run.data.pokemon and run.data.pokemon[id] ~= nil
end

local function countRegistered(run)
  local n, missing = 0, {}
  for _, row in ipairs(index) do
    if registered(run, row.id) then n = n + 1 else missing[#missing + 1] = row.id end
  end
  return n, missing
end

-- Every string anywhere under t (depth-limited), for "did this text land".
local function strings(t, out, depth)
  out = out or {}; depth = depth or 0
  if type(t) == "string" then out[t] = true
  elseif type(t) == "table" and depth < 6 then
    for _, v in pairs(t) do strings(v, out, depth + 1) end
  end
  return out
end

-- 1. Gen 1/2: zero footprint.
do
  local run = boot({ folder(IPC) }, "gen12")
  local m = run.mods.indigo_conference
  check(m and m.state == "loaded", "gen12: IPC loaded (" .. tostring(m and m.state) .. ")")
  -- 1.1.74: the developer guests' approved lines reach the merged text, and
  -- the colour-test / sprite-test placeholders are gone from it
  local lines = assert(loadfile(IPC .. "/dev_lines.lua"))()
  -- the text registry's mod-contributed values (on Gen 2 `text` targets
  -- data.gen2Text, not data.text -- engine Schemas.lua R.text)
  local reg = run.loader.content and run.loader.content.text
  local text = strings(reg and reg:items() or {})
  local landed, total = 0, 0
  for _, l in pairs(lines) do
    total = total + 3
    for _, f in ipairs({ "intro", "win", "loss" }) do if text[l[f]] then landed = landed + 1 end end
  end
  check(landed == total, ("dev lines in merged text: %d/%d"):format(landed, total))
  -- the placeholders' seen/win texts (colour tests; sprite tests) -- chat is
  -- spoken by script, never registered, so it cannot be checked here
  check(not text["Let's test art!"] and not text["A fine test!"]
    and not text["Let's test this\nnew look!"] and not text["Thanks for trying!"],
    "placeholder lines no longer registered")
  local n = countRegistered(run)
  check(n == 0, ("gen12: IPC registered %d species (want 0)"):format(n))
  local e = ipcErrors(run)
  check(#e == 0, "gen12: no errors: " .. table.concat(e, " | "))
  run.release()
end

-- 2. Expanded, IPC alone.
do
  local run = boot({ folder(IPC) }, "expanded")
  local m = run.mods.indigo_conference
  check(m and m.state == "loaded", "expanded: IPC loaded (" .. tostring(m and m.state) .. ")")
  local n, missing = countRegistered(run)
  check(n == #index, ("expanded: %d/%d registered; missing %s"):format(n, #index, table.concat(missing, ",")))
  -- 1.1.76: every species has its catalog cry (a derived { base = cryBase })
  local cries = run.loader.content and run.loader.content.cries
  local withCry, noCry = 0, {}
  for _, row in ipairs(index) do
    local def = assert(loadfile(IPC .. "/" .. row.file))()[1]
    local cry = cries and cries:get(row.id)
    if type(cry) == "table" and cry.base == def.cryBase then withCry = withCry + 1
    else noCry[#noCry + 1] = row.id end
  end
  check(withCry == #index, ("expanded: %d/%d cries; missing %s"):format(withCry, #index,
    table.concat(noCry, ",")))
  -- 1.1.78: every species whose catalog definition carries `anim` registers it
  -- with the sheet pointing at IPC's own bundled copy (REQUESTS 132)
  local animOk, animWant = 0, 0
  local pokemon = run.loader.content and run.loader.content.pokemon
  for _, row in ipairs(index) do
    if row.anim then
      animWant = animWant + 1
      local rec = pokemon and pokemon:get(row.id)
      local sheet = rec and type(rec.anim) == "table" and rec.anim.sheet
      if type(sheet) == "string" and sheet:sub(-#row.anim) == row.anim then animOk = animOk + 1 end
    end
  end
  check(animWant > 0 and animOk == animWant, ("expanded: %d/%d animations with IPC's sheet"):format(animOk, animWant))
  local e = ipcErrors(run)
  check(#e == 0, "expanded: no errors: " .. table.concat(e, " | "))
  run.release()
end

-- 3. Expanded beside the framework, both orders.
for _, order in ipairs({ { folder(IPC), folder(ES) }, { folder(ES), folder(IPC) } }) do
  local run = boot(order, "expanded")
  local m = run.mods.indigo_conference
  check(m and m.state == "loaded", "with framework " .. order[1] .. " first: IPC loaded")
  local n, missing = countRegistered(run)
  check(n == #index, ("with framework %s first: %d/%d; missing %s"):format(order[1], n, #index,
    table.concat(missing, ",")))
  local e = ipcErrors(run)
  check(#e == 0, "with framework: no errors: " .. table.concat(e, " | "))
  run.release()
end

print(("%d PASS, %d FAIL"):format(pass, fail))
os.exit(fail == 0 and 0 or 1)
