/// @desc apply_lighting(lights, tint_color)
/// @param {array} lights          An array of light data arrays. Each light: [x, y, radius, intensity, color]
/// @param {asset.GMColour} tint_color A color for unlit areas (e.g., c_dkgray)
function apply_lighting(lights, tint_color, alpha=1.0) {
    // Cache uniform locations for better performance
    static uniforms = {
        u_tintColor   : shader_get_uniform(shd_lighting, "u_tintColor"),
        u_lightCount  : shader_get_uniform(shd_lighting, "u_lightCount"),
        u_lightProps  : shader_get_uniform(shd_lighting, "u_lightProps"),
        u_lightColors : shader_get_uniform(shd_lighting, "u_lightColors"),
        u_texelSize   : shader_get_uniform(shd_lighting, "u_texelSize") // <-- REPLACED ASPECT RATIO
    };

    var light_count = array_length(lights);
    var surfW = surface_get_width(application_surface);
    var surfH = surface_get_height(application_surface);

    // Set the lighting shader
    shader_set(shd_lighting);

    // --- Set Uniforms ---
    var cr = color_get_red(tint_color)   / 255.0;
    var cg = color_get_green(tint_color) / 255.0;
    var cb = color_get_blue(tint_color)  / 255.0;
    var ca = alpha;
    shader_set_uniform_f(uniforms.u_tintColor, cr, cg, cb, ca);
    shader_set_uniform_i(uniforms.u_lightCount, light_count);
    
    // --- NEW: Set Texel Size Uniform ---
    // Pass the size of one pixel in UV space (0.0 to 1.0)
	var tex = surface_get_texture(application_surface);
    var texel_w = texture_get_texel_width(tex);  // This is 1.0 / surfW
    var texel_h = texture_get_texel_width(tex); // This is 1.0 / surfH
    shader_set_uniform_f(uniforms.u_texelSize, texel_w, texel_h);

    // --- Build and Send Light Data Arrays ---
    if (light_count > 0) {
        // The array data remains the same (still normalized)
        var props_data = array_create(light_count * 4);
        var colors_data = array_create(light_count * 3);

        for (var i = 0; i < light_count; i++) {
            var light = lights[i];
            
            var props_index = i * 4;
            props_data[props_index + 0] = light[0] / surfW;
            props_data[props_index + 1] = light[1] / surfH;
            props_data[props_index + 2] = light[2] / surfW;
            props_data[props_index + 3] = light[3];
            
            var light_color = light[4];
            var color_index = i * 3;
            colors_data[color_index + 0] = color_get_red(light_color) / 255.0;
            colors_data[color_index + 1] = color_get_green(light_color) / 255.0;
            colors_data[color_index + 2] = color_get_blue(light_color) / 255.0;
        }
        
        shader_set_uniform_f_array(uniforms.u_lightProps, props_data);
        shader_set_uniform_f_array(uniforms.u_lightColors, colors_data);
    }

    draw_surface(application_surface, 0, 0);
    shader_reset();
}



