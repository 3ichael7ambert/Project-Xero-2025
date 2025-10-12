# Xero

**Xero** is a fast-paced, multi-mode 2D action game made in **GameMaker**, featuring a wide variety of gameplay modes, weapons, AI, and procedural environments. Players take on the role of a customizable human or robot in a futuristic world filled with chaos, cartel robots, and challenging missions.

---

## 🎯 Project Goals

This is a living project with evolving systems. Current development goals include:

### 1. ✅ Menu & Controller System
- Fix current **menu bugs** (e.g., returning to main menu causes conflicts or duplicate menus).
- Refactor player select logic to support **“press start to join”** UX style.
- Move away from static P1–P4 loop to a **dynamic controller manager system**.
- Incorporate **Rick Sanchez’s controller assignment flow** (press L+R to assign input).
- Default control style should allow:
  - Keyboard/Mouse
  - Gamepads 0–3
  - Input reassignment based on **last touched device**
- Finalize UX for **arcade-style setup** or **Smash Bros.-style select screen**.

### 2. 🏙️ Cityscape Mission System
- Expand mission-based gameplay:
  - Examples: “Kill 10 robots,” “Shoot 10 birds,” “Capture a runaway NPC.”
- Add procedural **looping environment** for endless play.
- Add **mission accept / complete UI**, persistent mission tracking.

### 3. 🧟 Survival Mode Fixes
- Review `objLevel_infinite` and `objControl_Infinite` for bugs.
- Polish wave logic, spawn balancing, and difficulty scaling.
- Address performance issues in long runs (enemy buildup, lag spikes).
- Confirm kill counts and wave number track correctly per player.

### 4. 🔥 Boss Mode & Lava Run
- **Boss Mode**: 
  - Fight unique bosses.
  - Unlock bosses via progress in Cityscape.
  - Menu selection for available bosses.
- **Lava Run**:
  - Procedurally climb or dodge lava waves.
  - Add endless scrolling support with hazards and randomized platforms.
  - Improve vertical level generation and challenge scaling.

### 5. 🔫 Weapon System Optimization
- Refactor and optimize **weapon logic**:
  - Address lag during intense shooting sequences.
  - Fix redundant collision or particle code causing slowdowns.
  - Add support for per-class behaviors (e.g., sniper range, shotgun spread).
  - Polish visuals and feedback for hit/miss effects.

---

## 🎮 Game Modes (Current + Planned)

| Mode             | Description |
|------------------|-------------|
| **Cityscape**    | Mission-based open zone. Human/robot NPCs. Future plans include endless procedural city looping and dynamic mission generator. |
| **Survival**     | Arcade-style infinite wave battle against enemies. Track waves, kills, and score. |
| **Lava Run**     | Procedurally generated vertical escape challenge. Player must climb while lava rises. |
| **Boss Fight**   | 1v1 or team vs boss battle. Bosses unlocked from Cityscape missions. |
| **Battle Mode**  | 2-4 player PvP, choose from maps like Skyline and Final Destination. |
| **Streetbike Fury** | High-speed motorcycle shooter. Use axis or mouse to aim and destroy enemies while riding. Endless mode, inspired by arcade shooters. |

---

## 🎮 Controls & UX Discussion

Designing a fluid and adaptable control system is critical for player experience. We're currently working toward:

### Goals
- Smooth UX across keyboard/mouse and gamepads.
- Up to 4-player support with mixed inputs.
- Prioritize **player-driven selection** over hardcoded player slots.

### Challenges
- Not enough Mac-compatible controllers to test.
- Want seamless switching like Fortnite (input swaps based on last used device).
- Mouse + WASD aiming feels great, but must coexist with controller input.

### Solution Plan (Based on Discussion w/ Rick Sanchez)
- **Start-to-Join System**:
  - Any input device can "press start" (or L+R for keyboard/controller) to join.
  - Assigned to player slot and removed from available pool.
  - Order based on who joins first — not fixed to Gamepad 0 or 1.
- **Fallback if less than 4 inputs**:
  - Allow combos like: 2 controllers + keyboard, or 3 controllers + keyboard.
- Menu control defaults to Player 1, but can switch based on device in use.
- Later: Option screen to assign preferred control manually.

---

## 🧠 Key Systems & Objects

| Object | Purpose |
|--------|---------|
| `obj_Player1` | Main player controller. Reads from `global.player`. Used for all human players. |
| `obj_Enemy_Robot` | Primary enemy unit. Behaves like a cartel or robotic police force. |
| `objHuman` | Neutral NPC. May be armed based on their state. |
| `objControlCity` | Controls city missions, NPC behavior, and interactions. |
| `objLevel_infinite` | Controller for endless horizontal levels. |
| `objLevelSide` | Controller for vertical or side-constrained levels (e.g., beach, jungle). |
| `objControl_Infinite` | Used in special cases like beach level. Manages infinite progression. |

---

## ⚙️ Known Issues

- Menu controller doesn’t reset properly on re-entry to main menu.
- Weapons can cause lag in survival and battle modes.
- Some game modes (Boss, Lava Run, Streetbike Fury) are **minimally implemented** and need polishing.
- Certain mission logic in `objControlCity` can conflict or fail to reset.
- Global variables (like health) may not always be properly initialized when switching between modes.

---

## 🛠️ Development Tasks (To-Do)

- [ ] Refactor weapon firing logic and particle effects.
- [ ] Create procedural looping city chunks.
- [ ] Build boss selection screen with unlock logic.
- [ ] Add Streetbike Fury input and enemy AI.
- [ ] Add mission generator system to Cityscape.
- [ ] Fix player HUD for all player slots in multiplayer.
- [ ] Optimize NPC spawning across game modes.
- [ ] Implement better fail state and victory triggers per mode.
- [ ] Finish dynamic input selection system.

---

## 🔗 Credits & References

- Developed by **Michael Lambert Jr.** and **Rick Sanchez*
- Engine: **GameMaker**

---

Further developer documentation has been created in the `docs/` folder. See:
- `docs/QUICKSTART.md` — how to open and run the project quickly.
- `docs/CHANGELOG.md` — project changelog and documentation history.
- `docs/` — full developer docs, systems overview, inventory CSV, and object snippets.
