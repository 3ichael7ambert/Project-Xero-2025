// Sprites
spr_head=sprBirdHead;
spr_body=sprBirdBody;
spr_wing_front=sprBirdWingFront;
spr_wing_back=sprBirdWingBack;
spr_eye=sprBirdEye;
spr_tail=sprBirdTail;
spr_beak_top=sprBirdBeakTop;
spr_beak_btm=sprBirdBeakBtm;

wing_img=0;

// Scale & ground
scale  = 0.8;
ground  = objSidewalk;

// Movement + state
state         = "fly";   // "fly","land","hop","idle"
dir           = 1;       // 1 right, -1 left
hspeed        = 0;
vspeed        = 0;
g             = 0.35;    // gravity when grounded / hopping
fly_float_g   = 0.08;    // tiny downward bias while flying
fly_speed     = 1.6;
fly_wander    = 0.04;    // horizontal drift changes
max_fall      = 6;

// Body pose
body_angle    = 0;       // smoothed
head_angle    = 0;
wing_angle    = 0;       // driven by sine
tail_angle    = 0;

body_tilt_scale  = 1.7;  // how much vspeed affects angle
body_tilt_min    = -15;
body_tilt_max    =  20;

head_follow_amt  = 0.35; // head lags the body a little

// Wing flap
flap_t        = 0;
flap_rate     = 9;       // higher = faster flap
flap_amp      = 30;      // degrees

// Beak (chirp)
beak_open     = false;
beak_open_ang = 16;      // degrees the top beak rotates up
alarm[0]      = irandom_range(room_speed*2, room_speed*5); // schedule first chirp
// alarm[1] used to close mouth

// Tail swish
tail_active   = false;
tail_amp      = 12;
tail_rate     = 5;
tail_t        = 0;
alarm[2]      = irandom_range(room_speed*2, room_speed*6); // schedule first tail start
// alarm[3] ends tail swish

// Landing / hopping cadence
desire_to_land_t = irandom_range(room_speed*3, room_speed*8);
hop_cooldown     = 0;
hop_h            = 1.5; // hop horizontal push
hop_v            = 4.0; // hop up
idle_t           = 0;

// Draw offsets (tweak to fit your sprites)
off_body_x   = 0 * scale;   off_body_y   = 0 * scale;
off_head_x   = 12 * scale;  off_head_y   = -6 * scale;
off_wing_x   = 2 * scale;   off_wing_y   = 0 * scale;
off_tail_x   = -10 * scale; off_tail_y   = 2 * scale;
off_eye_x    = off_head_x + 75 * scale;  off_eye_y    = off_head_y -28 * scale;
off_beak_x   = off_head_x + 88 * scale;  off_beak_y   = off_head_y-15 * scale;

// Facing & scale
image_xscale = scale;
image_yscale = scale;

// --- Flight controller targets
cruise_y   = y + irandom_range(-16, 16); // target altitude around spawn
fly_kp     = 0.08;   // proportional lift gain (altitude error -> lift)
fly_kd     = 0.20;   // damping on vertical velocity
fly_bob_amp= 0.35;   // vertical bob amplitude
fly_bob_spd= 2.0;    // vertical bob speed
fly_bob_t  = irandom(360);

// Optional: initial little upward nudge so it starts in the air nicely
vspeed = -1.0;
