# Weapon System

Overview
- Weapon logic is spread between weapon sprites, weapon scripts (e.g., `sprGun`, `sprShotgun`) and enemy/player scripts such as `scr_setup_part_explode`, `scr_particle_engine` and `scr_setup_part_rain`.

Performance areas
- Particle creation, redundant collision checks, and per-instance heavy logic cause slowdowns during high-intensity sequences.
- Consider consolidating weapon effects into pooled particle systems and minimizing per-bullet step code.

Where to look
- Scripts: `scr_particle_engine`, `scr_setup_part_explode`, `scr_setup_part_rain`, `scr_setup_part_slush`.
- Objects: `objBullet`, `objBullet_Enemy`, `objBullet_Human`, `objBullet_Kaiju`.
