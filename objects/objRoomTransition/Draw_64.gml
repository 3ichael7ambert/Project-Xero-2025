var gw = display_get_gui_width();
var gh = display_get_gui_height();

draw_set_alpha(1);
draw_set_color(c_white);

// OUT phase: show captured old room + effect overlay
if (state == "out") {
    if (surface_exists(surf)) {
        
		/*if (style == "distort") {
            // simple “wobble” without a custom shader: scale + slight sine offset
            var scale = 1 + 0.02 * sin(k*2);
            var ox = (gw - gw*scale) * 0.5;
            var oy = (gh - gh*scale) * 0.5;
            draw_surface_ext(surf, ox, oy, scale, scale, 0, c_white, 1);
        } else {
            draw_surface(surf, 0, 0);
        }*/
		if (style == "distort" && surface_exists(surf)) {
		    shader_set(shd_distort);
		    var u_time = shader_get_uniform(shd_distort, "u_time");
		    shader_set_uniform_f(u_time, current_time * 0.001);
		    texture_set_stage(0, surface_get_texture(surf));
		    draw_surface(surf, 0, 0);
		    shader_reset();
		} else if (surface_exists(surf)) {
		    draw_surface(surf, 0, 0);
		}

    }

    // fade to black (or shade color)
    var a = t / dur_out;
    if (style == "shade") {
        draw_set_alpha(min(1, a*0.85));
        draw_set_color(shade_col);
    } else {
        draw_set_alpha(a);
        draw_set_color(c_black);
    }
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
}

// IN phase: fade from black over the new room
if (state == "in") {
    var a_in = 1 - (t / dur_in);
    draw_set_alpha(max(0, a_in));
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
}
