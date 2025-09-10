function shader_hue_start(_color) {
		var u_position = shader_get_uniform(shd_hue, "u_Position"); // control shader
	// radians: pi - half a hue circle, 2 * pi - full circle
	var hue = color_get_hue(_color);
	var pos = (255-hue) / 128 * pi;
	
	shader_set(shd_hue);
	shader_set_uniform_f(u_position, pos);
}