# Changelog

All notable changes to Indigo Plateau Conference are documented here.
Format follows [keep a changelog](https://keepachangelog.com/); the top
heading always equals the version in `manifest.json`.

## 0.1.0

Scaffold. The mod loads, defines a `Show load banner` option, and
announces its version on the first map entry of a session. No Conference
content yet — this build exists to confirm the toolchain (validate,
draft test build, install, on-device version banner) before any feature
can be blamed for a load failure.

Planned build order from here:

- **0.2.0** — registrar NPC on Route 22, Hall-of-Fame gating, lobby map.
  Entry and exit, surviving a save/reload.
- **0.3.0** — the tier-draw engine and `mod.save` state (current run,
  round, drawn opponents, completed-tournament count).
- **0.4.0** — arena map and one opponent end to end, via `trainer.party`.
- **0.5.0+** — roster fill, tier by tier, with vanilla `basePic`
  fallbacks so a character is never blocked on their art.
- Later — rewards and the repeat loop, then Volo, then the Glitch
  Trainer rare draw.
