# TODO / FIXME scan results

I scanned the repository for literal TODO/FIXME/XXX markers across common text and code filetypes. Results summary below.

Summary
- Total raw matches (TODO/FIXME/XXX regex across .gml, .yy, .md, .txt, .js, .py): 70 matches.
- Most matches are in documentation files (the docs we added reference TODO tasks). There are also meaningful pattern matches inside large object and script `.gml` files (see examples below).

Notable hit locations (representative)
- `docs/overview.md`, `docs/index.md`, `docs/todos_found.md` — doc-level TODO references and notes (expected).
- `options/*.yy` — duplicate/merged option files include repeated keys (likely from platform option copies). These are not TODOs but were captured by the broad regex.
- `scripts/scr_Enemy_Robot_step_weapons/scr_Enemy_Robot_step_weapons.gml` — multiple matches around particle spawn and weapon firing code (lines where particle creation is used or commented-out). May indicate copy/paste or commented debug code.
- `objects/obj_Player1/Step_0.gml` — many matches related to particle creation and commented-out particle positioning lines (e.g., `//part_system_position(global.partSysCharge,xxx,yyy);`). This file is very large and a likely hotspot for optimization work.

Quick patterns worth triage
- Commented-out particle system positioning (e.g., `//part_system_position(...)`) — search these to decide whether to re-enable, remove, or replace with pooled/batched particle calls.
- Repeated particle creation calls (part_particles_create) — consider pooling or moving to a centralized particle manager (`scr_particle_engine`). The `scr_particle_engine` script exists and may be the right single point to drive bursts.
- Large monolithic Step events (e.g., `obj_Player1/Step_0.gml`) — refactor into helper scripts to reduce per-step complexity and ease profiling.

Recommendations / next steps
1. Manual triage: open the top-k largest files (I can find the largest by line count) and add targeted TODO comments where you want changes (pooling, move to particle engine, reset/init safety checks).
2. Run a targeted regex for less-structured keywords like `fix|bug|broken|hack|kludge|XXX` to surface casual notes that the simple TODO/FIXME scan missed.
3. Produce an aggregated `docs/todos_found_detailed.md` listing each match with file path, line preview, and a recommended action (low/med/high effort). I can generate this automatically.

If you'd like, I will now:
- (A) produce the detailed list (`docs/todos_found_detailed.md`) with the 70 matches and short recommendations, or
- (B) run the looser keyword scan (fix|bug|XXX) and merge results into the detailed file.
