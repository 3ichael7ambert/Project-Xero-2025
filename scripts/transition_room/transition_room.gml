/// transition_room(_target_room, _style, _dur_out, _dur_in, _snd)
function transition_room(_rm, _style = "fade", _dur_out = 30, _dur_in = 24, _snd = noone) {
    if (instance_exists(objRoomTransition)) return;
    var tr = instance_create_layer(0, 0, layer, objRoomTransition);
    tr._rm        = _rm;
    tr.style      = _style;     // "fade","shade","distort"
    tr.dur_out    = max(1, _dur_out);
    tr.dur_in     = max(1, _dur_in);
    tr._snd       = _snd;
    return tr;
}

function tr_draw_layer(is_gui)
{
    var gw = is_gui ? display_get_gui_width()  : surface_get_width(application_surface);
    var gh = is_gui ? display_get_gui_height() : surface_get_height(application_surface);

    if (state == "out") {
        if (use_capture && surface_exists(surf)) {
            if (is_gui) draw_surface_stretched(surf, 0, 0, gw, gh);
            else        draw_surface(surf, 0, 0);
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
}
