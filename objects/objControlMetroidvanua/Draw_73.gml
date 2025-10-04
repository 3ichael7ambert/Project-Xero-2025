/// In obj_PostFX (Draw End event)
//if (!surface_exists(application_surface)) exit;

// --- Get/compute your sky color (from your init function) ---
if instance_exists(objCityWeather){
	var sky_col = scr_timeofday_color(objCityWeather.wmo);
} else {
		var sky_col = blended_color; // or however you store it globally
	}
// Convert 24-bit color to normalized rgb
var r = color_get_red(sky_col)   / 255;
var g = color_get_green(sky_col) / 255;
var b = color_get_blue(sky_col)  / 255;


// Grading strength (tweak live). 0.0=no grade, 0.35=gentle, 0.6=strong
var strength = 0.35;

// Optional contrast tweak (-1..+1). Try small values like 0.05
var contrast = 0.05;

// --- Bind shader and set uniforms ---
shader_set(shd_tone_color);

var u_tone      = shader_get_uniform(shd_tone_color, "u_tone_rgb");
var u_strength  = shader_get_uniform(shd_tone_color, "u_strength");
var u_contrast  = shader_get_uniform(shd_tone_color, "u_contrast");

shader_set_uniform_f(u_tone, r, g, b);
shader_set_uniform_f(u_strength, strength);
shader_set_uniform_f(u_contrast, contrast);

// Draw the scene through the shader
draw_surface(application_surface, 0, 0);

shader_reset();
