# Xero — Project Documentation Overview

This docs/ collection provides a developer-oriented, navigable reference for the Xero GameMaker project. It aims to help contributors, maintainers, and future-you find systems quickly, understand architecture, and get productive fast.

Files in this folder:
- `structure.md` — high-level project layout and where to find things in the tree
- `objects.md` — inventory and short descriptions of important in-game objects
- `assets.md` — sprites, sounds, rooms, and scripts inventory and notable assets
- `systems/` — deeper system-by-system explanations (menu/controller, missions/cityscape, survival, lava run, boss mode, weapon system)
- `CONTRIBUTING.md` — how to contribute, style rules, and testing guidelines
- `TODO.md` — prioritized task list derived from the README and repo analysis

How to use these docs:
- If you're looking for where code lives, start with `structure.md`.
- If you're debugging or changing gameplay logic, open the appropriate page under `systems/`.
- For a quick list of objects and assets, check `objects.md` and `assets.md`.

Quick notes about the project:
- Engine: GameMaker (open the `.yyp` project file in GameMaker Studio 2/2022+).
- Project root contains resource files created by GameMaker (`.yyp`, `.resource_order`) and asset folders used inside the engine.
- This documentation intentionally does not modify GameMaker assets — it complements them with developer-level notes.

If something is missing or unclear, please raise an issue in your issue tracker or add a small patch to `docs/` with the missing details.
