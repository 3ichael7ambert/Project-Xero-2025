# Objects Reference

This is a curated, developer-focused reference of the most important objects in the project. For full behavior inspect the object in GameMaker. The descriptions are based on file names and the root README.

Core player objects
- `obj_Player1`, `obj_Player1Large`, `obj_Player_bike`, `objPlayer360`, `objPlayer_mv` — player controllers for different modes (classic 2D, bike mode, 360-mode).
- `obj_rider_bike`, `obj_NeonBike_bike`, `obj_NeonTire_bike`, `obj_bike_bullet` — bike and vehicle-specific actors.

Enemies & NPCs
- `obj_Enemy_Robot`, `obj_Enemy_Robot_Rayu`, `objRobot`, `objRobotParent`, `objHuman`, `objHumanParent` — enemy and NPC families. Look for `scr_Enemy_Robot_*` scripts for behavior and weapons.
- `objKaiju`, `objKaijuDragon` — large boss-like enemies.

World & Level
- `objLevel_infinite`, `objLevel_1`, `objLevelSide`, `obj_fake3Dcontroller`, `obj_block3D*`, `obj_block_*` — level controllers and block types for infinite and side levels.
- `objParallaxLayer*`, `objCamera*`, `objCamera_Infinite`, `objCameraCity` — camera and parallax systems.

Control & UI
- `objMenu`, `obj_init`, `objController_bike`, `objControlCity`, `objControl_Infinite`, `objControlLava`, `objControlBoss`, `objControl_mv` — menu and high-level mode controllers.
- `obj_hitbox`, `objHitbox` — collision helpers.

Special systems
- `objMissionTarget`, `objCityWeather`, `objCityLighting`, `objMusic_controller`, `objWeatherAPI`, `objWeatherHUD` — mission, weather, and mission-related controllers.
- `obj_particle_weather_tester`, `objFirework` — particle testing and effects.

Tips for contributors
- When modifying AI or enemy behavior, update `scr_Enemy_Robot_*` scripts and search for calls to `scr_enemy_robot`.
- For level visual changes, edit `objParallaxLayer*` and `objCamera*` scripts and sprites in `sprites/`.

If you'd like, I can generate a full CSV listing each object file name and the first 20 lines of its associated code/events to make localization of behavior faster.
