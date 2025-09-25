/// objKaijuDragon : Create

// --- Sprites (replace with your assets) ---
spr_head = sprDragonHead;
spr_seg  = sprDragonHead;//sprDragonSegment;  // mid body tile segment (looping)
spr_tail = sprDragonHead;//sprDragonTail;

// --- Boss basics ---
hp        = 5000;
dead      = false;
aggro_rad = 640;     // wakes when player close
target    = noone;

// --- Serpentine chain settings ---
seg_count   = 32;      // total pieces including head+tail
seg_spacing = 18;      // desired distance between knots
und_amp     = 10;      // lateral wave amplitude
und_speed   = 0.035;   // phase speed
und_step    = 12;      // phase offset per segment

// --- Movement/steering ---
speed_base  = 3.2;
speed_boost = 5.2;
turn_rate   = 2.0;     // deg/step (steering tightness)
wander_mag  = 28;      // how “snakey” the wander is
wander_freq = 0.008;   // noise frequency
altitude    = y;       // preferred height anchor
city_min_x  =  -2000;  // soft bounds so it loops/bounces
city_max_x  =   2000;
city_min_y  =   -400;
city_max_y  =    900;

// --- Head state ---
dir_deg   = irandom(359);     // facing angle
vx = lengthdir_x(speed_base, dir_deg);
vy = lengthdir_y(speed_base, dir_deg);

// --- Body arrays (positions & angles per knot) ---
seg_x = []; seg_y = []; seg_a = [];
array_resize(seg_x, seg_count);
array_resize(seg_y, seg_count);
array_resize(seg_a, seg_count);
for (var i = 0; i < seg_count; i++) {
    seg_x[i] = x - i * lengthdir_x(seg_spacing, dir_deg);
    seg_y[i] = y - i * lengthdir_y(seg_spacing, dir_deg);
    seg_a[i] = dir_deg;
}

// --- Timers / phases ---
t        = irandom(10000);
roar_cd  = 240;
breath_cd= 90;

// --- Combat toggles (plug into your boss system as needed) ---
provoked = false;   // set true when player seen/hit

// --- Effects ---
shadow_alpha = 0.25;
