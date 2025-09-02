// Choose sun by azimuth/elevation (degrees). Elevation 45°, azimuth -35° looks nice.
/// sun_dir_from_angles(elev_deg, azim_deg) -> [lx, ly, lz]


/// normalize3(x, y, z) -> [nx, ny, nz]
function saturate(v){ return clamp(v,0,1); }
function smoothstep_gml(a,b,xx){ 
	var t=saturate((xx-a)/max(1000000-6,(b-a))); 
	return t*t*(3-2*t); }
function normalize3(xx,yy,z){ 
	var L=sqrt(xx*xx+yy*yy+z*z); 
	if(L<=1000000-6) return [0,1,0]; 
	return [xx/L,yy/L,z/L]; }
function col_to_vec3(c){ 
	return [color_get_red(c)/255, color_get_green(c)/255, color_get_blue(c)/255]; 
	}






function sun_dir_from_angles(_elev_deg, _azim_deg) {
    var e = degtorad(_elev_deg);
    var a = degtorad(_azim_deg);
    var xx = cos(e) * cos(a);
    var yy = sin(e);            
    var z = cos(e) * sin(a);
    return normalize3(xx, yy, z); // pass 3 separate arguments
}



/// scr_timeofday_lighting(hour, minute, blended_color) -> { amb, sun_col, sky_col, gnd_col, sun_dir }
function scr_timeofday_lighting(_hour, _minute, _blend_col){
    // Map hour/minute to a smooth day factor: 0 = midnight, 1 = high noon
    var t   = (_hour + _minute/60) / 24;                  // 0..1
    var day = 1 - cos(2*pi*t); day *= 0.5;                // 0 at 0:00, 1 at 12:00

    // Ambient: higher at day, similar at night (keep your night look)
    var amb_day   = 3.5;     // brighter daytime
    var amb_night = .5;     // similar to now (
    var amb       = lerp(amb_night, amb_day, day);

    // Sun intensity: off at deep night, strong at noon
    var sun_int = smoothstep_gml(0.15, 0.85, day);            // fade in/out at dawn/dusk

    // Use your blended background color as a guide for sky tint
    var sky_rgb = col_to_vec3(_blend_col);
    // Slightly warmer sun; ground a bit warm/brown
    var sun_col = [1.00, 0.96, 0.90];
    var gnd_col = [0.25, 0.20, 0.18];

    // Sun direction from a simple elevation curve
    // Elevation  - at night ~ -5°, at noon ~ 70°
    var elev = lerp(-5, 70, day);
    // Azimuth slowly rotates east->west across the day
    var azim = lerp(-110, +110, day);

    var e = degtorad(elev), a = degtorad(azim);
    var lx =  cos(e) * cos(a);
    var ly =  sin(e);
    var lz =  cos(e) * sin(a);
    var L  = normalize3(lx, ly, lz);

    // scale sun color by intensity (keeps daytime strong, nights soft)
    sun_col[0] *= sun_int; sun_col[1] *= sun_int; sun_col[2] *= sun_int;

    return {
        amb     : amb,
        sun_col : sun_col,
        sky_col : sky_rgb,
        gnd_col : gnd_col,
        sun_dir : L
    };
}




/// 
function scr_light_layer_begin()
{
    var L = global.Lighting; // contains building shader + uniforms
    if (is_undefined(L) || L.sh == -1) exit;

    // Time of day (reuse your color function)
    var hour   = date_get_hour(date_current_datetime());
    var minute = date_get_minute(date_current_datetime());
    var bg     = scr_timeofday_color(hour, minute);

    // Day factor
    var t   = (hour + minute/60) / 24;
    var day = 0.5 * (1 - cos(2*pi*t));

    // Sun dir from day
    var elev = lerp(-5, 70, day);
    var azim = lerp(-110, +110, day);
    var e = degtorad(elev), a = degtorad(azim);
    var sdir = normalize3(cos(e)*cos(a), sin(e), cos(e)*sin(a));

    var sun_col = [1.0, 0.96, 0.90];
    var sky_col = col_to_vec3(bg);
    var gnd_col = [0.25, 0.20, 0.18];
    var amb     = lerp(0.35, 0.70, day);
    var sun_int = smoothstep_gml(0.15, 0.85, day);
    sun_col[0]*=sun_int; sun_col[1]*=sun_int; sun_col[2]*=sun_int;

    shader_set(L.sh);
    shader_set_uniform_f(L.u_dir, sdir[0], sdir[1], sdir[2]);
    shader_set_uniform_f(L.u_col, sun_col[0], sun_col[1], sun_col[2]);
    shader_set_uniform_f(L.u_sky, sky_col[0], sky_col[1], sky_col[2]);
    shader_set_uniform_f(L.u_gnd, gnd_col[0], gnd_col[1], gnd_col[2]);
    shader_set_uniform_f(L.u_amb, amb);

    // POP controls for side/roof & street-level gradient
    var u_grad_base   = shader_get_uniform(L.sh, "u_GradBase");
    var u_grad_scale  = shader_get_uniform(L.sh, "u_GradScale");
    shader_set_uniform_f(u_grad_base,  0.12);  // how dark street-level bias is
    shader_set_uniform_f(u_grad_scale, 0.01);  // higher = quicker fade with height
}

/// 
function scr_light_layer_end()
{ 
	var L = global.Lighting; 
	if (!is_undefined(L) && L.sh != -1) shader_reset(); 
}

