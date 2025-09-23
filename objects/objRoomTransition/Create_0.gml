
persistent = true;
depth      = -1000000;


//use_fx = _tr_start_fx_for_style(style);


// Pick your virtual size (example 1920x1080)
var VW = 1920, VH = 1080;

// GUI stays constant across all rooms
display_set_gui_size(VW, VH);

// Optional: keep application surface matching GUI (prevents surprises)
application_surface_enable(true);
surface_resize(application_surface, VW, VH);



state   = "out";
t = 0; k = 0;

dur_out = 30; dur_in = 24;
shade_col = make_color_rgb(10,10,14);

surf = -1; captured = false;
cap_attempt = 0; cap_max = 6; use_capture = true;

use_fx = false;          // <- default; real init happens in User Event 0
exiting = true;          // for FX path
param_value = 0;

application_surface_enable(true);

//if (!is_undefined(_snd) && _snd != noone) audio_play_sound(_snd, 1, false);


// --- FX baseline so reads never crash ---
use_fx          = false;
exiting         = true;

filter_name     = "";
param_name      = "";
param_min_value = 0;     // default safe values
param_max_value = 1;
param_speed     = 0.1;
param_value     = 0;

temp_layer      = -1;
filter          = noone;

// Also keep your other fields here (state, t, k, surf, cap_w/cap_h, etc.)
