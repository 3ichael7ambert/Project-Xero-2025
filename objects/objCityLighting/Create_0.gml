// --- GPU state once (global defaults)
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_cullmode(cull_noculling);

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
