/// @description Insert description here
// You can write your code in this editor





depth = 0;

var date_time_of_day_color = scr_timeofday_color();

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_cullmode(cull_noculling);
//gpu_set_fog(true, date_time_of_day_color, 0, 1000); 

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




var L = global.Lighting;
if (L.sh != -1) {
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
    shader_reset();
} else {
    builder.submit(); // fallback flat
}



//builder.submit();


///

gpu_set_fog(true, date_time_of_day_color, 0, 1000); 
gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);






