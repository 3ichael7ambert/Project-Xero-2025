/// objKaijuDragon : Create

// --- Sprites (replace with your assets) ---
spr_head = sprKaiju_Dragon_Head;
spr_seg  = sprKaiju_Dragon_Body;//sprDragonSegment;  // mid body tile segment (looping)
spr_tail = sprKaiju_Dragon_Tail;//sprDragonTail;

// --- Boss basics ---
hp        = 5000;
dead      = false;
aggro_rad = 640;     // wakes when player close
target    = noone;

scale=.2;

// --- Serpentine chain settings ---
seg_count   = 32;      // total pieces including head+tail

// After you define spr_seg and scale
var seg_w = (sprite_get_width(spr_seg)/2) * scale;
seg_spacing = max(1, seg_w * 0.92); // slight overlap to hide any tex bleeding

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



// --- SPRITES (add belly) ---
spr_belly = sprKaiju_Dragon_Belly;     // 80 frames
belly_frames = sprite_get_number(spr_belly); // expect 80

// --- Per-segment roll/twist state ---
seg_roll = [];          // degrees, “roll” around forward axis (fake)
seg_a_prev = [];        // previous step’s segment facing (for curvature)
array_resize(seg_roll, seg_count);
array_resize(seg_a_prev, seg_count);
for (var i = 0; i < seg_count; i++) {
    seg_roll[i] = 0;
    seg_a_prev[i] = seg_a[i]; // from your init loop
}

// --- Roll controls (tune to taste) ---
roll_follow     = 0.28;   // how much a segment adopts parent’s roll per step
roll_from_turn  = 0.65;   // how much local turning injects roll (deg -> roll deg)
roll_decay      = 0.96;   // damping to keep it bounded (0..1)
roll_noise_amp  = 6.0;    // gentle wiggle on top so it’s alive
roll_noise_freq = 0.012;  // per-step noise frequency

// keep a head angle history to capture turning energy
dir_deg_prev = dir_deg;
