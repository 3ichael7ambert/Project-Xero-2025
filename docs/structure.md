# Project Structure

This page maps the key folders in the repository to their runtime purpose in the GameMaker project. Use this as a quick reference when editing or searching for resources.

- `objects/` — GameMaker objects. These contain events and instance logic (`Create`, `Step`, `Draw`, etc.). Examples: `obj_Player1`, `objControlCity`, `objLevel_infinite`.
- `scripts/` — Reusable GML scripts and helpers. Many higher-level systems call these scripts for AI, level generation, and UI.
- `sprites/` — All sprites and particle templates used by the game.
- `rooms/` — Level rooms. Includes menu room (`rm_menu`), city, infinite levels, and specialized rooms.
- `sounds/` — Sound files and music tracks used in-game.
- `fonts/` — Bitmap fonts and font assets.
- `shaders/` — Shader files used for special effects.
- `particles/` — Particle system templates and emitters.
- `notes/` — Design notes, compatibility reports, and release notes.
- `README.md` — Project overview and short goals (root README).

Mapping of development concerns to folders:
- Gameplay & AI: `objects/` + `scripts/` (look for `objEnemyParent`, `obj_Enemy_Robot`, `scr_enemy_robot`).
- Level generation & infinite modes: `objLevel_infinite`, `obj_fake3Dcontroller`, and scripts like `fake3D_init`, `spawn_wave`.
- UI & Menus: `objMenu`, `scr_menu`, `draw_main_menu`.
- Input/Controller management: `scripts/InputManager/`, `MenuManager/` and `obj_init`/`objMenu`.

If you need to find a symbol quickly, open the `.yyp` in GameMaker or search `scripts/` names in the repository.
