/// Create
// You can use either a sprite or a background, see Draw below.
spr_or_bg     = backCloudLayer1;   // if using a sprite
use_sprite    = true;        // set false if using a background

parx          = 0.10;        // 0..1 (0 = sticks to screen, 1 = locks to world)
// tip: far layers: 0.05..0.3, mid: 0.4..0.7, near: 0.85..0.95
pary          = 0.10;

scroll_spd_x  = -10;         // pixels/sec to auto-scroll (negative = left)
scroll_spd_y  = 0;

t_accum_x     = 0;           // seconds-based accumulators (smooth + framerate independent)
t_accum_y     = 0;

col           = c_white;
alp           = 1;
