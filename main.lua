-- Indigo Plateau Conference -- a repeatable post-Elite-Four tournament.
--
-- v0.1.0: scaffold slice. Deliberately registers NO content. Its only job
-- is to prove the toolchain end to end -- modkit validate green, a draft
-- test build, an install on the phone, and a banner that names its own
-- version -- before any feature can be blamed for a load failure.
--
-- The Conference itself (registrar on Route 22, lobby, arena, tier draw)
-- lands from v0.2.0 on; see CHANGELOG.md for the build order.

return function(mod)
  local VERSION = "0.1.0"
  mod.exports.version = VERSION

  -- Declared up front even though nothing is registered yet, so another
  -- mod can check ownership at runtime instead of via a handoff note.
  mod.exports.owns = {
    maps = {},
    tilesets = {},
    trainers = {},
    commands = {},
  }

  -- ------------------------------------------------------------------
  -- on-screen diagnostics (the only output channel on iPhone)
  -- ------------------------------------------------------------------
  local function say(msg)
    local ok = pcall(function()
      local TextBox = require("src.render.TextBox")
      local game = mod.world.game
      if not (game and game.stack) then return end
      game.stack:push(TextBox.new(game, msg))
    end)
    if not ok then mod.log:warn("say failed: %s", tostring(msg)) end
  end

  mod.options:define({
    { key = "show_banner", type = "toggle",
      label = "Show load banner", default = true },
  })

  -- ------------------------------------------------------------------
  -- load banner. NOT on game.ready: Game.lua emits that while nothing is
  -- on the stack yet and pushes the title screen immediately after, so a
  -- TextBox there is discarded (kanto_contests v0.1 lost its banner to
  -- exactly this). First map entry of the session is the first moment a
  -- box survives.
  -- ------------------------------------------------------------------
  local bannerShown = false
  mod.events:on("map.entered", function()
    local ok, err = pcall(function()
      if bannerShown then return end
      if not mod.options:get("show_banner") then return end
      bannerShown = true
      say("INDIGO PLATEAU\nCONFERENCE\nv" .. VERSION .. " ready!")
    end)
    if not ok then mod.log:warn("banner failed: %s", tostring(err)) end
  end)

  mod.log:info("indigo_conference %s loaded", VERSION)
end
