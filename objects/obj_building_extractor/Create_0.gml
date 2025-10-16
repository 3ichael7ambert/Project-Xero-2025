/// @description wait

alarm[0] = 1;

builder = new Tile3d();

mesh_dirty  = true;   // set this to true any time sidewalks/buildings change
default_w   = 64;     // fallback width for sidewalk rects
default_h   = 64;     // fallback height for sidewalk rects


mesh_dirty = false;
building_now = false;
/*
global.Lighting = {};
with (global.Lighting) {
    sh = asset_get_index(shd_sun);
    if (sh != -1 && shader_is_compiled(sh)) {
        u_dir = shader_get_uniform(sh, "u_LightDir");
        u_col = shader_get_uniform(sh, "u_LightColor");
        u_sky = shader_get_uniform(sh, "u_SkyColor");
        u_gnd = shader_get_uniform(sh, "u_GroundColor");
        u_amb = shader_get_uniform(sh, "u_Ambient");
        u_gb  = shader_get_uniform(sh, "u_GradBase");
        u_gs  = shader_get_uniform(sh, "u_GradScale");
    } else sh = -1;
}

*/

/// LIGHTING
// Cache shader + uniform locations
/*
sh_sun = asset_get_index("shd_sun");
if (sh_sun != -1 && shader_is_compiled(sh_sun)) {
    u_sun_dir = shader_get_uniform(sh_sun, "u_LightDir");
    u_sun_col = shader_get_uniform(sh_sun, "u_LightColor");
    u_sky_col = shader_get_uniform(sh_sun, "u_SkyColor");
    u_gnd_col = shader_get_uniform(sh_sun, "u_GroundColor");
    u_amb     = shader_get_uniform(sh_sun, "u_Ambient");

    // Optional: sanity check
    if (u_sun_dir == -1) show_debug_message("WARN: u_LightDir not found in shd_sun");
} else {
    sh_sun = -1; // mark unusable
}
*/