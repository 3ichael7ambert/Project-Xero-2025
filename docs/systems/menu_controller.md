# Menu & Controller System

Overview
- The game aims for a dynamic "press start to join" input flow supporting keyboard/mouse and up to four controllers.
- Key contributors: `objMenu`, scripts under `scripts/InputManager/`, `MenuManager/` folder, and `obj_init`.

Important files & symbols
- Objects: `objMenu`, `obj_init`, `obj_Player1`.
- Scripts: `scripts/InputManager/*`, `scr_menu`, `draw_menu`, `draw_main_menu`.

Behavior summary
- Menu entry flow is handled by `objMenu` + `scr_menu`.
- Controllers are assigned dynamically based on input activity; look inside `InputManager` scripts to modify device detection and assignment.

Known issues (from README)
- Menu controller doesn’t always reset properly on re-entry to main menu. Investigate `obj_init` and any Create/Destroy handlers that set global player slots.

Improvement ideas
- Centralize controller state to a single manager object (`objControllerManager`) and emit events when devices join/leave.
- Add unit tests (small GML runners or automated input simulation) for the join/leave flow.
