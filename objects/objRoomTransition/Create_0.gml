persistent = true;
depth      = -1000000;

state   = "out";  // "out" -> swap -> "in"
t = 0; k = 0;

style   = "fade";
dur_out = 30;
dur_in  = 24;

shade_col = make_color_rgb(10,10,14);

surf        = -1;
captured    = false;
cap_attempt = 0;      // how many capture tries
cap_max     = 6;      // try a few frames, then fallback
use_capture = true;   // flips to false if we give up

_snd = noone;

if (is_undefined(_snd)) _snd = noone;
if (_snd != noone) audio_play_sound(_snd, 1, false);

// Ensure app surface (becomes available next frame)
application_surface_enable(true);
