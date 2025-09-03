// objCityLighting.Step

// 2.1 Ambient from your sky blend
var sky_col = scr_timeofday_color();    // your function returns a GM color
draw_light_define_ambient(sky_col);

// 2.2 Sun direction from time (simple: arcade path across sky)
var elev   = lerp(-10, 75, clamp((current_hour + current_minute/60) / 24, 0, 1));
var azim   = 30; // fixed azimuth (from the left); feel free to animate
var rad    = pi / 180;
var sx     =  cos(azim*rad) * cos(elev*rad);
var sy     =  sin(elev*rad);
var sz     =  sin(azim*rad) * cos(elev*rad);
var s_len  = max(0.000001, sqrt(sx*sx + sy*sy + sz*sz));
sx /= s_len; sy /= s_len; sz /= s_len;

// 2.3 Sun color/intensity from your lighting curve
var sun_col = make_color_rgb(255, 238, 210); // noon-ish; fade it at dusk/dawn if you like

// Re-define or update the directional light
draw_light_define_direction(global.light_sun, sx, sy, sz, sun_col);
