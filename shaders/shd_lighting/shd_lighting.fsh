// Fragment Shader for 2D Point Lights (Realistic Lighting)
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_tintColor;             // Global tint color for unlit areas (RGBA)
uniform int u_lightCount;               // Number of active point lights
uniform vec2 u_texelSize;             // The size of a pixel in UV space (1/W, 1/H)

// Light Data Uniforms
uniform vec4 u_lightProps[16];          // Light Properties: (x, y, radius, intensity)
uniform vec3 u_lightColors[16];         // Light Colors: (R, G, B)

// --- HELPER FUNCTIONS ---
const float GAMMA = 2.2;

vec3 gamma_to_linear(vec3 color) {
    return pow(color, vec3(GAMMA));
}

vec3 linear_to_gamma(vec3 color) {
    return pow(color, vec3(1.0 / GAMMA));
}

void main() {
    // 1. --- CONVERT INPUTS TO LINEAR SPACE ---
    vec4 baseTex_gamma = texture2D(gm_BaseTexture, v_vTexcoord);
    
    if (baseTex_gamma.a == 0.0) {
        gl_FragColor = vec4(0.0);
        return;
    }
    
    vec3 base_linear = gamma_to_linear(baseTex_gamma.rgb);
    vec3 tint_linear = gamma_to_linear(u_tintColor.rgb);
    vec3 total_light_contribution = vec3(0.0);

    // 2. --- PERFORM ALL MATH IN LINEAR SPACE ---
    float aspect_ratio = u_texelSize.x / (u_texelSize.y * 1.5);
    
    for (int i = 0; i < u_lightCount; i++) {
        vec2 lightPos = u_lightProps[i].xy;
        float radius_norm = u_lightProps[i].z;
        float intensity = u_lightProps[i].w;
        vec3 lightColor = gamma_to_linear(u_lightColors[i].rgb); // Convert light color to linear space

        if (radius_norm <= 0.0 || intensity <= 0.0) continue;

        vec2 dist_vec_norm = v_vTexcoord - lightPos;
        dist_vec_norm.y *= aspect_ratio;
        float dist = length(dist_vec_norm);
 if (dist > radius_norm) continue;

        // Improved attenuation with smooth falloff from 25% to 100% radius
        float inner_radius = radius_norm * 0.25;
        float attenuation = 0.0;
        
        if (dist <= inner_radius) {
            attenuation = 1.0;
        } else {
            float falloff_progress = (dist - inner_radius) / (radius_norm - inner_radius);
            attenuation = 1.0 - smoothstep(0.0, 1.0, falloff_progress);
        }
        
        total_light_contribution += lightColor * intensity * attenuation;
    }

    // --- REALISTIC LIGHTING BLENDING (with Soft Edge Correction) ---
    // 1. Calculate the fully vibrant lit color.
    vec3 illuminated_color = base_linear * (1.0 + total_light_contribution);
    vec3 light_overlay = total_light_contribution * 0.75;
    vec3 fully_lit_color = illuminated_color + light_overlay;

    // 2. Temper the light's color by mixing it with the base texture.
    vec3 lit_color_linear = mix(fully_lit_color, base_linear, 0.5);
    
    // 3. Calculate the color if the pixel were fully in shadow (standard alpha blend).
    vec3 shadowed_color_linear = mix(base_linear, tint_linear, u_tintColor.a);
    
    // 4. The mix factor is now the light's actual strength at this pixel.
    //    This correctly uses the smooth falloff from the attenuation calculation.
    float light_factor = clamp(length(total_light_contribution), 0.0, 1.0);
    
    // 5. Smoothly transition between the shadowed and lit states using this factor.
    vec3 final_color_linear = mix(shadowed_color_linear, lit_color_linear, light_factor);
    
    // 3. --- CONVERT FINAL OUTPUT BACK TO GAMMA SPACE ---
    vec3 final_color_gamma = linear_to_gamma(final_color_linear);
    
    gl_FragColor = vec4(final_color_gamma, baseTex_gamma.a);
}
