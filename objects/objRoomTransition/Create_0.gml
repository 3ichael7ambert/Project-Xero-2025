persistent   = true;
depth        = -1000000;

state        = "out";   // "out" -> swap -> "in"
t            = 0;
k            = 0;
style        = "fade";  // caller can override
dur_out      = 30;
dur_in       = 24;
shade_col    = make_color_rgb(10,10,14);

surf         = -1;
captured     = false;
_snd		 = noone;

_snd = (is_undefined(_snd) ? noone : _snd);
if (_snd != noone) audio_play_sound(_snd, 1, false);

// make sure app surface is on; we’ll still guard for existence below
application_surface_enable(true);
