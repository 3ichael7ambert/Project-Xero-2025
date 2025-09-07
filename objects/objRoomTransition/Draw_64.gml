var gw = display_get_gui_width();
var gh = display_get_gui_height();

if (state == "out") {
    if (surface_exists(surf)) {
        if (style == "distort") {
            // optional wobble: draw to a temp surface first if you like
            draw_surface_stretched(surf, 0, 0, gw, gh);
        } else {
            draw_surface_stretched(surf, 0, 0, gw, gh);
        }
    }
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
