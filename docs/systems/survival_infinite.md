# Survival / Infinite Mode

Overview
- Uses `objLevel_infinite`, `objControl_Infinite`, `objControl_mv`, and scripts like `spawn_wave` and `scr_infinite_hud`.
- This mode is arcade-style infinite waves with score, waves, and per-player kill counts.

Important files & symbols
- Objects: `objLevel_infinite`, `objControl_Infinite`, `objInfWorld_mv`.
- Scripts: `spawn_wave`, `scr_infinite_hud`, `player_*` scripts for movement and death.

Known issues & checks
- Review `objLevel_infinite` and `objControl_Infinite` for correct reinitialization on restart.
- Large numbers of enemies may accumulate and cause slowdowns; consider object pooling for enemies.

Performance tips
- Batch particle effects via `create_part_levelup` and `clear_partsys` scripts.
- Use hitbox-only collision where possible and avoid heavy per-step logic on many instances.
