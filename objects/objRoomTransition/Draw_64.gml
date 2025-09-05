var gw = display_get_gui_width();
var gh = display_get_gui_height();

if (state == "out") {
    // draw captured old room with optional wobble
    if (surface_exists(surf)) {
        if (style == "distort") {
            var scale = 1 + 0.02 * sin(k*2);
            var ox = (gw - gw*scale) * 0.5;
            var oy = (gh - gh*scale) * 0.5;
            draw_surface_ext(surf, ox, oy, scale, scale, 0, c_white, 1);
        } else {
            draw_surface(surf, 0, 0);
        }
    }

    // overlay fade
    var a = t / max(1, dur_out);
    draw_set_alpha(style == "shade" ? min(1, a*0.85) : a);
    draw_set_color(style == "shade" ? shade_col : c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
}
else if (state == "in") {
    var a_in = 1 - (t / max(1, dur_in));
    draw_set_alpha(clamp(a_in, 0, 1));
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
}
