-- Pure cup rules. RNG is injected for deterministic tests; cards are saved once.
-- 1.1.69: a card records the team TRACK it was drawn from ("gen12" or
-- "expanded"). A card with no track predates 1.1.69 and means gen12, so every
-- saved card keeps validating against the table it was actually drawn from --
-- switching IPC's team setting never invalidates (and silently redraws) a cup.
return function(tracks)
  if tracks.gen12 == nil then tracks = { gen12 = tracks } end   -- bare table = gen12
  local teams = tracks.gen12
  local M = { schema = 1 }
  function M.trackOf(card) return type(card) == 'table' and card.track or 'gen12' end
  function M.teams(track) return tracks[track or 'gen12'] end
  M.cups = {
    VIOLET_POKECENTER_1F = {{3,3,3,3},{65,25,8,2},{80,18,2}},
    GOLDENROD_POKECENTER_1F = {{3,3,3,3},{45,35,16,4},{55,40,5}},
    ECRUTEAK_POKECENTER_1F = {{3,3,3,6},{25,40,27,8},{25,60,15}},
    BLACKTHORN_POKECENTER_1F = {{6,6,6,6},{12,28,42,18},{8,47,45}},
    INDIGO_PLATEAU_POKECENTER_1F = {{3,3,6,6},{5,15,40,40},{2,18,80}},
  }
  local tierRound = {{1,1,1,1},{.8,1,1.3,1.6},{.5,.9,1.6,2.5},{.25,.7,2,4}}
  local recency = {.20,.35,.50,.65,.80}
  local legendRate = {.0025,.005,.01,.02}
  local strengths = {'Early','Middle','Full'}
  local function clone(t)
    if type(t) ~= 'table' then return t end
    local out = {}; for k,v in pairs(t) do out[k]=clone(v) end; return out
  end
  M.clone = clone
  function M.cap(id,r) return assert(M.cups[id],'Unknown IPC venue')[1][r] end
  function M.weight(key,history,chosen)
    local w=1
    for age,card in ipairs(history or {}) do
      if age>5 then break end
      for _,old in ipairs(card) do
        if old==key then w=recency[age]; break end
      end
      if w~=1 then break end
    end
    for _,old in ipairs(chosen or {}) do if old==key then w=w*.10; break end end
    return w
  end
  local function pick(weights,rng)
    local total=0; for _,w in ipairs(weights) do total=total+w end
    assert(total>0,'Empty weighted pool')
    local roll=rng()*total
    for i,w in ipairs(weights) do roll=roll-w; if roll<0 then return i end end
    return #weights
  end
  function M.parse(raw,byKey)
    if type(raw)~='string' then return nil end
    local out={}
    for key in raw:gmatch('[^,]+') do
      if not byKey[key] or byKey[key].devOnly or not teams[key] then return nil end
      out[#out+1]=key
    end
    return #out==4 and out or nil
  end
  function M.valid(card,byKey)
    local teams=type(card)=='table' and tracks[M.trackOf(card)]
    if not teams or card.schema~=M.schema or not M.cups[card.venue]
        or type(card.rounds)~='table' or #card.rounds~=4
        or type(card.keys)~='table' or #card.keys~=4 then return false end
    local legends=0
    for r,row in ipairs(card.rounds) do
      if type(row)~='table' or card.keys[r]~=row.key or not teams[row.key] or not byKey[row.key] or byKey[row.key].devOnly
          or not teams[row.key].variants[row.strength] or type(row.party)~='table'
          or #row.party~=M.cap(card.venue,r) then return false end
      local reference=teams[row.key].variants[row.strength][M.cap(card.venue,r)]
      if row.legendary then
        legends=legends+1
        if card.venue~='INDIGO_PLATEAU_POKECENTER_1F' or row.strength~='Full'
            or not teams[row.key].legendary then return false end
        reference=teams[row.key].legendary[M.cap(card.venue,r)]
      end
      for i,mon in ipairs(row.party) do
        if type(mon)~='table' or mon.species~=reference[i].species or mon.delta~=reference[i].delta then return false end
      end
    end
    return legends<=1
  end
  -- Species in a card's parties that isAvailable(species) rejects, sorted.
  -- Empty means the card can be fought exactly as it was drawn.
  function M.missing(card,isAvailable)
    local out,seen={},{}
    for _,row in ipairs(type(card)=='table' and card.rounds or {}) do
      for _,mon in ipairs(type(row)=='table' and row.party or {}) do
        local s=type(mon)=='table' and mon.species
        if s and not seen[s] and not isAvailable(s) then seen[s]=true; out[#out+1]=s end
      end
    end
    table.sort(out)
    return out
  end
  function M.draw(id,byKey,history,rng,legacy,track)
    local teams=assert(tracks[track or 'gen12'],'Unknown IPC team track')
    local cup=assert(M.cups[id]); rng=rng or math.random
    local pools={{},{},{},{}}
    -- Stable ordering means a deterministic RNG is reproducible across platforms.
    for key,def in pairs(teams) do
      if byKey[key] and not byKey[key].devOnly then table.insert(pools[def.tier],key) end
    end
    for _,pool in ipairs(pools) do table.sort(pool) end
    local card={schema=M.schema,venue=id,rounds={},keys={},encountered={},track=track or 'gen12'}
    local hasLegend=false
    for r=1,4 do
      local key=legacy and legacy[r]
      if not key then
        local tw={}; for t=1,4 do tw[t]=#pools[t]>0 and cup[2][t]*tierRound[r][t] or 0 end
        local pool=pools[pick(tw,rng)]
        local weights={}; for i,k in ipairs(pool) do weights[i]=M.weight(k,history,card.keys) end
        key=pool[pick(weights,rng)]
      end
      -- Old saves keep their opponents and progress; Full is a deterministic migration.
      local strength=legacy and 'Full' or strengths[pick(cup[3],rng)]
      local special=not legacy and not hasLegend and id=='INDIGO_PLATEAU_POKECENTER_1F'
        and strength=='Full' and teams[key].legendary and rng()<legendRate[r] or false
      local size=M.cap(id,r)
      local party=special and teams[key].legendary[size] or teams[key].variants[strength][size]
      card.keys[r]=key
      card.rounds[r]={key=key,strength=strength,legendary=special,party=clone(party)}
      if special then hasLegend=true end
    end
    return card
  end
  function M.history(previous,card)
    local out={}
    if card and type(card.encountered)=='table' and #card.encountered>0 then out[1]=clone(card.encountered) end
    for _,row in ipairs(previous or {}) do
      if #out>=5 then break end
      if type(row)=='table' then out[#out+1]=clone(row) end
    end
    return out
  end
  return M
end
