persistent         = true;
depth              = -1000000;  // draw on top
state              = "out"; // "out" -> swap -> "in"
t                  = 0;
shade_col          = make_color_rgb(10,10,14); // for "shade" style overlay
surf               = -1;
_snd			   = noone;

// durations & inputs provided by caller
// _rm, style, dur_out, dur_in, _snd

// optional sfx
if (_snd != noone) audio_play_sound(_snd, 1, false);

// ensure app surface is on
application_surface_enable(true);

var w = surface_get_width(application_surface);
var h = surface_get_height(application_surface);

// screenshot current frame to our surface
surf = surface_create(w, h);
surface_set_target(surf);
draw_clear_alpha(c_black, 0);
draw_surface(application_surface, 0, 0);
surface_reset_target();

// cache for distort effect timing
k = 0; // small phase accumulator
