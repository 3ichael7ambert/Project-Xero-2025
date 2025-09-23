/// transition_room(_target_room, _style, _dur_out, _dur_in, _snd)
function transition_room(_rm, _style = "fade", _dur_out = 30, _dur_in = 24, _snd = noone) {
    if (instance_exists(objRoomTransition)) return;
    var tr = instance_create_layer(0, 0, layer, objRoomTransition);
    tr._rm     = _rm;
    tr.style   = _style;      // set BEFORE init
    tr.dur_out = max(1, _dur_out);
    tr.dur_in  = max(1, _dur_in);
    tr._snd    = _snd;

    with (tr) event_user(0);  // <-- init now that fields are set
    return tr;
}


function tr_draw_layer(is_gui)
{
    // Target area we’re drawing into (Room B)
    var tw = is_gui ? display_get_gui_width()  : surface_get_width(application_surface);
    var th = is_gui ? display_get_gui_height() : surface_get_height(application_surface);

	var cap_w = surface_get_width(application_surface);
	var cap_h = surface_get_height(application_surface);
    // If no capture (fallback), just fade
    var have_cap = (use_capture && surface_exists(surf) && cap_w > 0 && cap_h > 0);

    // Compute scale to preserve aspect of the captured frame
    var sx = tw / cap_w;
    var sy = th / cap_h;
    var s  = have_cap ? min(sx, sy) : 1;

    // Center with letterbox/pillarbox
    var dw = have_cap ? cap_w * s : tw;
    var dh = have_cap ? cap_h * s : th;
    var ox = (tw - dw) * 0.5;
    var oy = (th - dh) * 0.5;
	
		// Draw (world) — optional safety in case GUI isn’t visible
	// Draw (world) — optional
	if (state == "out" && use_capture && surface_exists(surf) && application_surface_is_enabled()) {
	    var R = _tr_target_area(false);
	    var xs = R.w / cap_w;
	    var ys = R.h / cap_h;
	    draw_surface_part_ext(surf, 0, 0, cap_w, cap_h, R.x, R.y, xs, ys, c_white, 1);
	}



    if (state == "out") {
        if (have_cap) {
            // draw captured frame from Room A, scaled and centered
            if (is_gui) draw_surface_stretched(surf, ox, oy, dw, dh);
            else        draw_surface_ext(surf, ox, oy, s, s, 0, c_white, 1);

            // (Optional) paint black bars behind to hide edges if any
            // Not strictly needed if you fill background elsewhere.
        }

        // Fade overlay
        var a = t / max(1, dur_out);
        draw_set_alpha(style == "shade" ? min(1, a*0.85) : a);
        draw_set_color(style == "shade" ? shade_col : c_black);
        draw_rectangle(0, 0, tw, th, false);
        draw_set_alpha(1);
    }
    else if (state == "in") {
        var a_in = 1 - (t / max(1, dur_in));
        draw_set_alpha(clamp(a_in, 0, 1));
        draw_set_color(c_black);
        draw_rectangle(0, 0, tw, th, false);
        draw_set_alpha(1);
    }
}

/// @func _tr_target_area(is_gui)
/// @return {struct} {x,y,w,h} to draw captured frame into
function _tr_target_area(is_gui) {
    // Target size in the *current* room
    var tw = is_gui ? display_get_gui_width()  : surface_get_width(application_surface);
    var th = is_gui ? display_get_gui_height() : surface_get_height(application_surface);

    // Guard
    if (cap_w <= 0 || cap_h <= 0) return { x:0, y:0, w:tw, h:th };

    // Preserve aspect of captured frame
    var sx = tw / cap_w;
    var sy = th / cap_h;
    var s  = min(sx, sy);

    var dw = cap_w * s;
    var dh = cap_h * s;
    var ox = (tw - dw) * 0.5;
    var oy = (th - dh) * 0.5;

    return { x:ox, y:oy, w:dw, h:dh };
}

function _tr_start_fx_for_style(_style) {
	// Reset to safe defaults every time
    filter_name     = "";
    param_name      = "";
    param_min_value = 0;
    param_max_value = 1;
    param_speed     = 0.1;
    switch (_style) {
        case "pixelate_fx":
            filter_name = "_filter_pixelate";
            param_name  = "g_CellSize";
            param_min_value = 1;
            param_max_value = 24;
            param_speed = max(0.1, (param_max_value - param_min_value) / dur_out);
        break;

        case "blur_fx":
            filter_name = "_filter_linear_blur";
            param_name  = "g_LinearBlurVector"; // X component used
            param_min_value = 0;
            param_max_value = 20;
            param_speed = max(0.5, (param_max_value - param_min_value) / dur_out);
        break;

		/*
		// RADIAL WIPE (clockwise or ccw) — no special blend modes needed
		case "radial_wipe":
		case "radial_wipe_ccw": {
		    var tw = display_get_gui_width();
		    var th = display_get_gui_height();

		    // how much of the circle to cover with black (0..360)
		    var sweep = a_out * 360;
		    if (style == "radial_wipe_ccw") sweep = -sweep;

		    // draw a black triangle fan from the center
		    draw_set_alpha(1);
		    draw_set_color(c_black);

		    var steps = 64;
		    var ang0  = -90; // start pointing up
		    var R     = max(tw, th); // long enough to cover edges

		    draw_primitive_begin(pr_trianglefan);
		    draw_vertex(tw*0.5, th*0.5); // center
		    for (var i = 0; i <= steps; i++) {
		        var ang = ang0 + (i/steps) * sweep;
		        var vx  = tw*0.5 + lengthdir_x(R, ang);
		        var vy  = th*0.5 + lengthdir_y(R, ang);
		        draw_vertex(vx, vy);
		    }
		    draw_primitive_end();
		} break;
		case "iris": {
		    // scale captured frame toward center while overlay fades in
		    if (state == "out" && use_capture && surface_exists(surf)) {
		        var tw = display_get_gui_width();
		        var th = display_get_gui_height();
		        var s  = max(0.001, 1.0 - a_out); // 1→0
		        var dw = R.w * s, dh = R.h * s;
		        var ox = R.x + (R.w - dw) * 0.5;
		        var oy = R.y + (R.h - dh) * 0.5;
		        draw_surface_stretched(surf, ox, oy, dw, dh);
		    }
		    // then the usual black overlay using a_out (below your switch)
		} break;
*/


        default: return false;
    }

    // Make sure these filters are included at build time (call once at startup):
    // fx_create("_filter_pixelate");
    // fx_create("_filter_linear_blur");

    param_value = param_min_value;
    exiting     = true;
    temp_layer  = layer_create(-10000);
    filter      = fx_create(filter_name);
    layer_set_fx(temp_layer, filter);
    fx_set_parameter(filter, param_name, param_value);
    return true;
}

function Filters_Init() {
    // Touch the filters once so GameMaker bundles them
    fx_create("_filter_pixelate");
    fx_create("_filter_linear_blur");
}
