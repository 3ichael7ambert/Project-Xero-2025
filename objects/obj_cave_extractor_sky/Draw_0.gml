/// @description Insert description here
// You can write your code in this editor

//__background_set_colour(c_black);
//scr_timeofday_background_init();


var date_time_of_day_color = scr_timeofday_color();
var fog_color = merge_colour(date_time_of_day_color,c_black,.5);

 __background_set_colour(fog_color);
    var lay_id = layer_get_id("Colour");
    if (lay_id != -1) {
        var back_id = layer_background_get_id(lay_id);
        if (back_id != -1) layer_background_blend(back_id, fog_color);
    }
	
	gpu_set_fog(true, fog_color, 1000,2000); 
	
	
	
	
//if instance_exists(obj_Player1) {
// ✅ Correct camera light targeting

 var cam = view_camera[0]; // Get the camera ID for view 0
if instance_exists(obj_Player1) {
var vw = (camera_get_view_width(cam)/2)+camera_get_view_x(cam);
var vh = obj_Player1.y;//camera_get_view_height(cam);
light_target_x += vw * 0.5;
light_target_y += vh * 0.5;



	light_target_x = obj_Player1.x;//(cam);
    light_target_y = obj_Player1.y;//(cam);
} else
if (view_enabled)
{
   
    light_target_x = camera_get_view_x(cam);
    light_target_y = camera_get_view_y(cam);
	var vw = (camera_get_view_width(cam)/2)+camera_get_view_x(cam);
	var vh = camera_get_view_height(cam);
}
else
{
    // Fallback if views are disabled (uses default camera position)
    light_target_x = camera_get_view_x(view_camera[0]);
    light_target_y = camera_get_view_y(view_camera[0]);
	var vw = (camera_get_view_width(cam)/2)+camera_get_view_x(cam);
	var vh = camera_get_view_height(cam);
}


	draw_set_lighting(true);
	draw_light_define_ambient(date_time_of_day_color);
	draw_light_get_ambient();
	//draw_light_define_point(0, light_target_x, light_target_y, 50, 2000, c_white);
	//draw_light_define_direction(2, vw, vh, 0, c_white);
	draw_light_define_point(1, vw, vh, -300, 500, c_white);
	//draw_light_define_point(1, 200, 123, 50, 2000, c_white);
	draw_light_enable(1, true);
	draw_light_enable(2, true);
//}

	
	
	
	
	/*
depth = 0;
if instance_exists(objCityWeather){
	var date_time_of_day_color = scr_timeofday_color(objCityWeather.wmo);
	//scr_timeofday_background_init(objCityWeather.wmo);
} else {
	var date_time_of_day_color = scr_timeofday_color();
}
var atmosphere_color = merge_colour(c_black,date_time_of_day_color,.5);
//var date_time_of_day_color = c_aqua;

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_cullmode(cull_noculling);

if (instance_exists(objCityWeather)) {
	gpu_set_fog(true, date_time_of_day_color, 500, 1000); 
} else {
	gpu_set_fog(true, date_time_of_day_color, 500, 1000); 

}

/*
var date_time_of_day_color = scr_timeofday_color();
 
////
// LIGHTING




// Get your blended background color
var bg_col = scr_timeofday_color();

// Compute lighting from that time/color
var Lp = scr_timeofday_lighting(current_hour, current_minute, bg_col);

// If shader present, set uniforms; else just draw
if (sh_sun != -1 && shader_is_compiled(sh_sun)) {
    shader_set(sh_sun);
    shader_set_uniform_f(u_sun_dir, Lp.sun_dir[0], Lp.sun_dir[1], Lp.sun_dir[2]);
    shader_set_uniform_f(u_sun_col, Lp.sun_col[0], Lp.sun_col[1], Lp.sun_col[2]);
    shader_set_uniform_f(u_sky_col, Lp.sky_col[0], Lp.sky_col[1], Lp.sky_col[2]);
    shader_set_uniform_f(u_gnd_col, Lp.gnd_col[0], Lp.gnd_col[1], Lp.gnd_col[2]);
    shader_set_uniform_f(u_amb,     Lp.amb);

    builder.submit();
    shader_reset();
} else {
    builder.submit();
}

///


*/

// repeat for other 3D/world layers as needed
// DO NOT attach to GUI/HUD layers


/*

var L = global.Lighting;
if (L.sh = -1) {
    shader_set(L.sh);

    // Example sun from up-left, slightly forward; must be normalized
    var lx =  0.4, ly = 0.8, lz = 0.3;
    var _ln = 1 / max(0.000001, sqrt(lx*lx + ly*ly + lz*lz));
    shader_set_uniform_f(L.u_dir, lx*_ln, ly*_ln, lz*_ln);

    // Colors (tweak to taste or drive by time-of-day)
    shader_set_uniform_f(L.u_col, 1.0, 0.95, 0.85); // warm sun
    shader_set_uniform_f(L.u_sky, 0.35, 0.45, 0.85);
    shader_set_uniform_f(L.u_gnd, 0.15, 0.12, 0.10);
    shader_set_uniform_f(L.u_amb, 0.6);            // ambient factor
    shader_set_uniform_f(L.u_gb,  0.25);           // gradient base darkening
    shader_set_uniform_f(L.u_gs,  0.02);           // gradient falloff (per world unit)

    builder.submit();
	
	//gpu_set_fog(true, date_time_of_day_color, 100, 1000); 
   
   shader_reset();
} else {
    builder.submit(); // fallback flat
	
//	gpu_set_fog(true, atmosphere_color, 500, 1000); 
}

*/

builder.submit();


///

/*
var fog_a = gpu_get_fog();
fog_a[1] = date_time_of_day_color;
gpu_set_fog(fog_a);
*/

gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);

gpu_set_fog(false, date_time_of_day_color, 500, 1000); 






