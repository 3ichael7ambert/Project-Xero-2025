// ---------- CONFIG ----------
mode        = "clear";   // "clear","rain","snow","fog","storm"
intensity   = 0.6;       // 0..1
wind_dir    = 20;        // degrees, from west->east-ish
wind_power  = 0.35;      // 0..1 ~ meters/sec-ish
fog_density = 0.0;       // 0..1
fog_col     = make_color_rgb(150,170,190);

spawn_rect_margin = 64;  // how far offscreen we spawn
drop_layer_depth  = depth; // this object’s depth; particles render in Draw

// ---------- PARTICLE SYSTEM ----------
ps = part_system_create();
part_system_depth(ps, drop_layer_depth);

// RAIN STREAK
pt_rain = part_type_create();
part_type_shape(pt_rain, pt_shape_line);
part_type_size (pt_rain, 0.6, 0.8, 0, 0);
part_type_scale(pt_rain, 1, 2);
part_type_color1(pt_rain, make_color_rgb(180, 200, 230));
part_type_alpha2(pt_rain, 0.9, 0.0);
part_type_speed(pt_rain, 11, 15, -0.15, 0);
part_type_direction(pt_rain, 270, 270, 0, 0); // will offset by wind each frame
part_type_gravity(pt_rain, 0.5, 270);         // extra downward accel
part_type_life(pt_rain, 20, 28);

// SNOW FLAKE
pt_snow = part_type_create();
part_type_shape(pt_snow, pt_shape_flare);
part_type_size (pt_snow, 0.7, 1.2, 0, 0);
part_type_color1(pt_snow, c_white);
part_type_alpha2(pt_snow, 0.9, 0.0);
part_type_speed(pt_snow, 0.6, 1.2, 0, 0);
part_type_direction(pt_snow, 260, 280, 0, 0);
part_type_gravity(pt_snow, 0.02, 270);
part_type_life(pt_snow, 140, 200);

// LIGHT MIST (tiny floating dots to help fog feel 3D)
pt_mist = part_type_create();
part_type_shape(pt_mist, pt_shape_pixel);
part_type_size (pt_mist, 0.8, 1.0, 0, 0);
part_type_color1(pt_mist, make_color_rgb(200, 210, 220));
part_type_alpha2(pt_mist, 0.08, 0.0);
part_type_speed(pt_mist, 0.2, 0.6, 0, 0);
part_type_direction(pt_mist, 0, 360, 0, 0);
part_type_gravity(pt_mist, 0.0, 270);
part_type_life(pt_mist, 200, 300);

// ---------- SPLATTER POOL (screen-space) ----------
splats = ds_list_create();
splat_max = 48; // cap to keep it cheap

// ---------- FOG SURFACE ----------
surf_fog = -1;




// Expose globally if you like:
global.weather = id;

// Nice defaults to demo
if (!variable_global_exists("WeatherOnce")) {
    WeatherOnce = true;
    weather_set_mode("rain");
    weather_set_wind(25, 0.4);
    weather_set_fog(0.15, make_color_rgb(120,140,165));
}
