var tw = display_get_gui_width();
var th = display_get_gui_height();

var a_out = t / max(1, dur_out);          // 0→1 while exiting
var a_in  = 1 - (t / max(1, dur_in));     // 1→0 while entering

/*
if (state == "out" && use_capture && surface_exists(surf)) {
    var R = _tr_target_area(true);

    shader_set(shd_swirl);
    var u_time   = shader_get_uniform(shd_swirl, "u_time");
    var u_amount = shader_get_uniform(shd_swirl, "u_amount");
    var u_center = shader_get_uniform(shd_swirl, "u_center");

    shader_set_uniform_f(u_time, current_time * 0.001);
    shader_set_uniform_f(u_amount, a_out);           // increase swirl with time
    shader_set_uniform_f(u_center, 0.5, 0.5);        // center of screen

    draw_surface_stretched(surf, R.x, R.y, R.w, R.h);
    shader_reset();
}
*/

if (state == "out") {
    switch (style) {
        case "fade_white": {
            draw_set_alpha(a_out);
            draw_set_color(c_white);
            draw_rectangle(0, 0, tw, th, false);
            draw_set_alpha(1);
        } break;
/*
        case "shade": {
            draw_set_alpha(min(1, a_out * 0.85));
            draw_set_color(shade_col);
            draw_rectangle(0, 0, tw, th, false);
            draw_set_alpha(1);
        } break;

        case "iris": { // circular close
            var r = lerp( max(tw,th), 0, a_out );
            gpu_set_blendmode_ext_sepalpha(bm_zero, bm_one, bm_one, bm_zero); // draw “hole” mask trick
            draw_set_alpha(1);
            draw_set_color(c_black);
            draw_rectangle(0,0,tw,th,false);
            draw_set_color(c_white);
            draw_circle(tw*0.5, th*0.5, max(r,1), false);
            gpu_set_blendmode(bm_normal);
        } break;

        case "radial_wipe":     // clockwise wedge
        case "radial_wipe_ccw": // counter-clockwise wedge
        {
            var sweep = a_out * 360;
            if (style == "radial_wipe_ccw") sweep = -sweep;
            // fill screen black, then cut a wedge out from center
            draw_set_color(c_black);
            draw_rectangle(0,0,tw,th,false);
            gpu_set_blendmode_ext_sepalpha(bm_zero, bm_one, bm_one, bm_zero);
            draw_set_color(c_white);
            draw_vertex_begin(pr_trianglefan);
            draw_vertex_color(tw*0.5, th*0.5, c_white, 1);
            var steps = 64;
            var ang0 = -90; // start up
            for (var i=0; i<=steps; i++) {
                var ang = ang0 + (i/steps) * sweep;
                var _x = tw*0.5 + lengthdir_x(max(tw,th), ang);
                var _y = th*0.5 + lengthdir_y(max(tw,th), ang);
                draw_vertex_color(_x, _y, c_white, 1);
            }
            draw_vertex_end();
            gpu_set_blendmode(bm_normal);
        } break;
*/
        default: { // includes "fade_black" and anything unhandled → black fade
            draw_set_alpha(a_out);
            draw_set_color(c_black);
            draw_rectangle(0, 0, tw, th, false);
            draw_set_alpha(1);
        }
    }
}
else // state == "in"
{
    // Entry: fade from overlay back to scene (match black/white behavior)
    var col = (style == "fade_white") ? c_white : c_black;
    draw_set_alpha(clamp(a_in, 0, 1));
    draw_set_color(col);
    draw_rectangle(0, 0, tw, th, false);
    draw_set_alpha(1);
}
