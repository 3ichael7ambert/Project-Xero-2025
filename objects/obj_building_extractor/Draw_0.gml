/// @description Insert description here
// You can write your code in this editor





depth = 0;

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_cullmode(cull_noculling);

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




// repeat for other 3D/world layers as needed
// DO NOT attach to GUI/HUD layers





//builder.submit();


///


gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);






