/// draw stuff
/*
pWeatherRain = scr_setup_part_rain();
pWeatherSnow = scr_setup_part_snow();
pWeatherSlush = scr_setup_part_slush();

part_spawn_count
part_state_player
*/

var _txt = $"Particle Type = {part_state_player}, Spawn number {part_spawn_count}";
_txt += "\nPress [1] for Rain, [2] for snow, [3] for slush, [4] to reset, [+] more particles, [-] less particles"
draw_text(16, 16, _txt);