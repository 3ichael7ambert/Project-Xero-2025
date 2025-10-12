# Assets Reference

This document lists notable assets discovered in the project's `sprites/`, `sounds/`, and `rooms/` folders. For a complete visual or audio inventory, open the `.yyp` in GameMaker.

Notable rooms
- `rm_menu` — main menu room.
- `rmCity`, `r_level_infinite`, `r_levelSide_infinite`, `rmMoon`, `rm_Infinite_beach`, `rm_battle_skyline`, `rm_boss` — playable levels and special rooms.

Notable sprites (selection)
- Player & body parts: `sprPlayer_mask`, `sprArm*`, `sprHead*`, `sprHuman_*`, `sprZombie_*` — used to build humanoid characters via parts.
- Weapons & effects: `sprBullet`, `sprRocket`, `sprRocketLauncher`, `sprGrenade`, `sprShotgun`, `sprSniper`, `sprLaser`, `sprFlamethrower`.
- Environments & tiles: `sprCityTree`, `sprSidewalk`, `sprBuilding`, `spr_Floor_bike_*`, `spr_Sky_bike`.
- Particles & effects: `pt_*` prefixed folders like `pt_fire`, `pt_splash`, `pt_spell_*`.

Notable sounds
- UI & feedback: `snd_menu`, `snd_menu_move`, `snd_messagebox_*`, `snd_item_coin`, `snd_item_powerup`.
- Player & enemies: `snd_player_damage`, `snd_player_dead`, `snd_enemy_died`, `snd_explosion`, `snd_walljump`.
- Music & loops: `snd_level_1`, `snd_level_2`.

Tips
- If you change sprite names or add new sprites, update references inside objects (Draw events often reference sprites by name). Use GameMaker's resource tree rename to safely update references.
