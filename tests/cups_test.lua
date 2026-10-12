-- Save-safety tests for the 1.1.69 track-aware cup rules (A-0080).
-- Run from the repo root:  luajit tests/cups_test.lua
-- Needs `git` on PATH: the 1.1.68 rules are read from git as the baseline.
local function readFile(p)
  local f = assert(io.open(p, "rb")); local s = f:read("*a"); f:close(); return s
end
local function gitShow(spec)
  local h = assert(io.popen('git show "' .. spec .. '"', "r"))
  local s = h:read("*a"); h:close()
  assert(#s > 0, "git show " .. spec .. " returned nothing")
  return s
end
local function chunk(src, name) return assert(loadstring(src, name))() end

local gen12 = chunk(readFile("weighted_teams.lua"), "teams")
local expanded = chunk(readFile("expanded_teams.lua"), "expanded")
local Old = chunk(gitShow("fb321c5:weighted_cups.lua"), "cups-1.1.68")(gen12)
local Cups = chunk(readFile("weighted_cups.lua"), "cups")({ gen12 = gen12, expanded = expanded })

-- BY_KEY stand-in: every table key is a normal (non-dev) trainer.
local byKey = {}
for k in pairs(gen12) do byKey[k] = { key = k } end

local function lcg(seed)        -- deterministic, identical sequence per seed
  local s = seed
  return function()
    s = (s * 1103515245 + 12345) % 2147483648
    return s / 2147483648
  end
end

local function deepEq(a, b, skip)
  if type(a) ~= type(b) then return false end
  if type(a) ~= "table" then return a == b end
  for k, v in pairs(a) do if k ~= skip and not deepEq(v, b[k]) then return false end end
  for k in pairs(b) do if k ~= skip and a[k] == nil then return false end end
  return true
end

local pass, fail = 0, 0
local function check(ok, what)
  if ok then pass = pass + 1 else fail = fail + 1; print("FAIL " .. what) end
end

local venues = {}
for id in pairs(Cups.cups) do venues[#venues + 1] = id end
table.sort(venues)

-- 1. Gen 1/2 draws are unchanged: same RNG, same card as 1.1.68 (track aside).
local same, total = 0, 0
for _, id in ipairs(venues) do
  for seed = 1, 400 do
    local a = Old.draw(id, byKey, {}, lcg(seed))
    local b = Cups.draw(id, byKey, {}, lcg(seed))
    total = total + 1
    if deepEq(a, b, "track") and b.track == "gen12" then same = same + 1 end
  end
end
check(same == total, ("gen12 draws identical to 1.1.68 (%d/%d)"):format(same, total))

-- 2. Every pre-1.1.69 card (no track field) still validates.
local oldOk = 0
for _, id in ipairs(venues) do
  for seed = 1, 100 do
    local card = Old.draw(id, byKey, {}, lcg(seed))
    check(card.track == nil, "1.1.68 cards carry no track")
    if Cups.valid(card, byKey) and Old.valid(card, byKey) then oldOk = oldOk + 1 end
  end
end
check(oldOk == #venues * 100, ("old cards valid under new rules (%d)"):format(oldOk))

-- 3. Expanded draws: identical picks (keys, strengths, legendaries) for the
--    same RNG -- weights, recency, repeats, round bias and legendary odds are
--    untouched -- with parties taken from the expanded table.
local pickSame, expValid, partyOk, n = 0, 0, 0, 0
local sawExpandedSpecies = false
local gen12Species = {}
for _, t in pairs(gen12) do
  for _, v in pairs(t.variants) do for _, p in pairs(v) do for _, m in ipairs(p) do gen12Species[m.species] = true end end end
  for _, p in pairs(t.legendary or {}) do for _, m in ipairs(p) do gen12Species[m.species] = true end end
end
for _, id in ipairs(venues) do
  for seed = 1, 400 do
    n = n + 1
    local g = Cups.draw(id, byKey, {}, lcg(seed))
    local e = Cups.draw(id, byKey, {}, lcg(seed), nil, "expanded")
    local same = e.track == "expanded"
    local parties = true
    for r = 1, 4 do
      local gr, er = g.rounds[r], e.rounds[r]
      same = same and gr.key == er.key and gr.strength == er.strength and gr.legendary == er.legendary
      local size = Cups.cap(id, r)
      local want = er.legendary and expanded[er.key].legendary[size] or expanded[er.key].variants[er.strength][size]
      parties = parties and deepEq(er.party, want)
      for _, m in ipairs(er.party) do if not gen12Species[m.species] then sawExpandedSpecies = true end end
    end
    if same then pickSame = pickSame + 1 end
    if parties then partyOk = partyOk + 1 end
    if Cups.valid(e, byKey) then expValid = expValid + 1 end
  end
end
check(pickSame == n, ("expanded picks match gen12 picks (%d/%d)"):format(pickSame, n))
check(partyOk == n, ("expanded parties come from expanded_teams (%d/%d)"):format(partyOk, n))
check(expValid == n, ("expanded cards validate against their own track (%d/%d)"):format(expValid, n))
check(sawExpandedSpecies, "expanded draws actually field added species")

-- 4. A saved expanded card is NEVER judged against the gen12 table: it stays
--    valid whatever the current setting, and missing() names what it needs.
local addedIds = {}
for _, t in pairs(expanded) do
  for _, v in pairs(t.variants) do for _, p in pairs(v) do for _, m in ipairs(p) do
    if not gen12Species[m.species] then addedIds[m.species] = true end
  end end end
end
local function vanillaOnly(s) return not addedIds[s] end
local function everything() return true end
local blockedSeen, gen12Clear, fullClear = false, true, true
for seed = 1, 400 do
  local e = Cups.draw("BLACKTHORN_POKECENTER_1F", byKey, {}, lcg(seed), nil, "expanded")
  local g = Cups.draw("BLACKTHORN_POKECENTER_1F", byKey, {}, lcg(seed))
  check(Cups.valid(e, byKey), "expanded card valid regardless of availability")
  local miss = Cups.missing(e, vanillaOnly)
  if #miss > 0 then blockedSeen = true end
  for _, s in ipairs(miss) do check(addedIds[s], "missing() names only added species: " .. s) end
  if #Cups.missing(g, vanillaOnly) > 0 then gen12Clear = false end
  if #Cups.missing(e, everything) > 0 then fullClear = false end
end
check(blockedSeen, "an expanded card needing added species is detected")
check(gen12Clear, "gen12 cards never need added species")
check(fullClear, "nothing is missing once every species is available")

-- 5. Legacy string draws (pre-weighted saves) still migrate onto gen12.
local legacy = Cups.parse("AJ,GISELLE,WES,LANCE", byKey)
check(legacy ~= nil, "legacy draw string parses")
if legacy then
  local c = Cups.draw("VIOLET_POKECENTER_1F", byKey, {}, lcg(7), legacy)
  check(c.track == "gen12" and c.keys[1] == "AJ" and c.rounds[1].strength == "Full", "legacy draw migrates to gen12 Full")
  check(Cups.valid(c, byKey), "migrated legacy card validates")
end

-- 6. Tampered / wrong-track cards are rejected rather than trusted.
local e = Cups.draw("INDIGO_PLATEAU_POKECENTER_1F", byKey, {}, lcg(3), nil, "expanded")
local copy = Cups.clone(e); copy.track = "nonsense"
check(not Cups.valid(copy, byKey), "unknown track rejected")

print(("%d PASS, %d FAIL"):format(pass, fail))
os.exit(fail == 0 and 0 or 1)
