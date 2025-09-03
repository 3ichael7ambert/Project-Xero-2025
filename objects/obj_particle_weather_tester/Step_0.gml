/// spawn particles

/*
pWeatherRain = scr_setup_part_rain();
pWeatherSnow = scr_setup_part_snow();
pWeatherSlush = scr_setup_part_slush();
*/

switch(keyboard_lastchar){
	case "1" : part_state_player = "Rain"; break;
	case "2" : part_state_player = "Snow"; break;
	case "3" : part_state_player = "Slush"; break;
	case "4" : part_state_player = "None"; break;
	case "+" : part_spawn_count += 25; break;
	case "-" : part_spawn_count -= 25; break;
}
keyboard_lastchar="";
part_spawn_count = clamp(part_spawn_count, 25, 500);

/// spawn particle effects
var cam = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_w = camera_get_view_width(cam);
var height = 64;

var _part = -1;
switch(part_state_player){
	case "Rain":
		_part = PARTICLE_ENGINE.pWeatherRain
	break;
	case "Snow":
		_part = PARTICLE_ENGINE.pWeatherSnow
	break;
	case "Slush":
		_part = PARTICLE_ENGINE.pWeatherSlush
	break;
}

if(_part != -1){
	burst_particle_box(cam_x-100, -height, cam_x + cam_w + 100, 0, false, _part, part_spawn_count);

}