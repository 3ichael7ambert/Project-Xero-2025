// --- GPU state once (global defaults)

depth=-99999;
var sun_col = scr_timeofday_color();

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_cullmode(cull_noculling);


wmo=0;

//gpu_set_fog(true,sun_col,0,9999);
/*
// --- Cache shader + uniforms into a global struct
global.Lighting = {
    sh   : asset_get_index("shd_sun"),
    u_dir: -1, u_col: -1, u_sky: -1, u_gnd: -1, u_amb: -1
};

if (global.Lighting.sh != -1 && shader_is_compiled(global.Lighting.sh)) {
    global.Lighting.u_dir = shader_get_uniform(global.Lighting.sh, "u_LightDir");
    global.Lighting.u_col = shader_get_uniform(global.Lighting.sh, "u_LightColor");
    global.Lighting.u_sky = shader_get_uniform(global.Lighting.sh, "u_SkyColor");
    global.Lighting.u_gnd = shader_get_uniform(global.Lighting.sh, "u_GroundColor");
    global.Lighting.u_amb = shader_get_uniform(global.Lighting.sh, "u_Ambient");
} else {
    // shader missing; scripts will early-exit gracefully
    global.Lighting.sh = -1;
}

// --- Attach layer scripts ONCE
if (!variable_global_exists("__lighting_layers_set")) {
    global.__lighting_layers_set = false;
}

if (!global.__lighting_layers_set) {
    var layers = [
        "Instances",
        "InstancesMain",
        "Enemies",
        "InstancesBuildings"
        // add more world/3D layers here, NOT GUI
    ];

    for (var i = 0; i < array_length(layers); i++) {
        var lay_id = layer_get_id(layers[i]);
        if (lay_id != -1) {
            layer_script_begin(lay_id, scr_light_layer_begin);
            layer_script_end(lay_id,   scr_light_layer_end);
        }
    }
    global.__lighting_layers_set = true;
}
*/
// warm-ish sunlight color


draw_set_lighting(true);
//draw_light_define_direction(1, 0, 1, 0, sun_col);


// Set a default ambient (soft sky fill)
draw_light_define_ambient(sun_col); // tweak later by time-of-day

// Define a “sun” directional light (index 0)
global.light_sun = 0;

// start with a sensible sun direction (normalized)
var lx = 0.4, ly = 0.8, lz = 0.3;
var len = max(0.000001, sqrt(lx*lx + ly*ly + lz*lz));
lx /= len; ly /= len; lz /= len;



// Directional light (by index)
//draw_light_define_direction(global.light_sun, lx, ly, lz, sun_col);
//light_enable_index(global.light_sun, true);
draw_light_enable(0, true);
draw_light_enable(1, true);



