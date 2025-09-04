/// spawn particles

/*
pWeatherRain = scr_setup_part_rain();
pWeatherSnow = scr_setup_part_snow();
pWeatherSlush = scr_setup_part_slush();
*/
/*
switch(keyboard_lastchar){
	case "1" : part_state_player = "Rain"; break;
	case "2" : part_state_player = "Snow"; break;
	case "3" : part_state_player = "Slush"; break;
	case "4" : part_state_player = "None"; break;
	case "+" : part_spawn_count += 25; break;
	case "-" : part_spawn_count -= 25; break;
}*/
keyboard_lastchar="";
part_spawn_count = clamp(part_spawn_count, 25, 500);

/// spawn particle effects
var cam = view_camera[0];
//var cam_x = camera_get_view_x(cam);
var cam_x = global.CameraManager.x;
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


/*
/// helper: get current view rect (vx,vy,vw,vh)
function _view_rect() {
    var cam = view_camera[0]; // or your active camera id
    return [
        camera_get_view_x(cam),
        camera_get_view_y(cam),
        camera_get_view_width(cam),
        camera_get_view_height(cam)
    ];
}

/// --- STEP ---

// 1) View rectangle (world space)
var V  = _view_rect();
var vx = V[0], vy = V[1], vw = V[2], vh = V[3];

// 2) Wind (degrees in wind_dir, 0=right, 90=up)
var wind_x = lengthdir_x(1, wind_dir);
var wind_y = lengthdir_y(1, wind_dir);

// Bend angles based on power
var rain_bend = clamp(wind_power, 0, 1) * 40; // ±40°
var snow_bend = clamp(wind_power, 0, 1) * 25; // ±25°
var rain_dir  = angle_wrap(270 + rain_bend * wind_x);
var snow_dir  = angle_wrap(270 + snow_bend * wind_x);

// Apply to types BEFORE spawning (affects new particles)
part_type_direction(pt_rain, rain_dir - 2, rain_dir + 2, 0, 0);
part_type_gravity  (pt_rain, 0.5 * (1 - wind_power * 0.3), 270);

part_type_direction(pt_snow, snow_dir - 6, snow_dir + 6, 0, 0);
part_type_gravity  (pt_snow, 0.02 * (1 - wind_power * 0.4), 270);

// 3) Spawn counts scale with view area
var area_scale = (vw * vh) / (320 * 180);
var base       = max(1, round(8 * intensity * area_scale));

// 4) Spawning per mode
switch (mode) {
	case "clear":
		break;
    case "rain": {
        var drops = base;
        var sx = vx - spawn_rect_margin;
        var sy = vy - spawn_rect_margin;
        var ex = vx + vw + spawn_rect_margin;
        var ey = vy + 8; // top strip
        repeat (drops) {
            part_particles_create(ps, irandom_range(sx, ex), irandom_range(sy, ey), pt_rain, 1);
        }
    } break;

    case "storm": {
        var drops = base * 3;
        var sx = vx - spawn_rect_margin;
        var sy = vy - spawn_rect_margin;
        var ex = vx + vw + spawn_rect_margin;
        var ey = vy + vh * 0.10; // a thicker top band
        repeat (drops) {
            part_particles_create(ps, irandom_range(sx, ex), irandom_range(sy, ey), pt_rain, 1);
        }
        // mist for volume
        if (random(1) < 0.8) {
            part_particles_create(ps, irandom_range(vx, vx + vw), irandom_range(vy, vy + vh), pt_mist, 1);
        }

        // screen-space splats (GUI coordinates, not view!)
        if (irandom(5) == 0) {
            // (unchanged) in storm case:
		var gw = display_get_gui_width();
		var gh = display_get_gui_height();
		var s = {
		    x: irandom_range(8, gw - 8),
		    y: irandom_range(gh * 0.65, gh - 6),
		    r: irandom_range(2, 5),
		    a: 0.9,
		    da: 0.03 + random(0.04),
		    life: 60
		};

            if (ds_list_size(splats) >= splat_max) ds_list_delete(splats, 0);
            ds_list_add(splats, s);
        }
    } break;

    case "snow": {
        var flakes = round(base * 0.8);
        var sx = vx - spawn_rect_margin;
        var sy = vy - spawn_rect_margin;
        var ex = vx + vw + spawn_rect_margin;
        var ey = vy + 8;
        repeat (flakes) {
            part_particles_create(ps, irandom_range(sx, ex), irandom_range(sy, ey), pt_snow, 1);
        }
        if (random(1) < 0.35) {
            part_particles_create(ps, irandom_range(vx, vx + vw), irandom_range(vy, vy + vh), pt_mist, 1);
        }
    } break;

    case "fog": {
        if (random(1) < 0.6) {
            part_particles_create(ps, irandom_range(vx, vx + vw), irandom_range(vy, vy + vh), pt_mist, 1);
        }
    } break;
}

// 5) (Optional) If somewhere else you set part_system_automatic_update(ps,false),
//    then call part_system_update(ps) here. Otherwise do nothing.

// 6) Splats update (GUI space)
for (var i = ds_list_size(splats) - 1; i >= 0; i--) {
    var s = splats[| i];
    s.a -= s.da;
    s.life--;
    if (s.a <= 0 || s.life <= 0) ds_list_delete(splats, i);
}

/// Utility
function angle_wrap(a) {
    while (a < 0)   a += 360;
    while (a >= 360) a -= 360;
    return a;
}
