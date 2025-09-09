function scr_bird_create(){
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
scale  = .5;
ground  = objSidewalk;

// Movement + state
state         = "fly";   // "fly","land","hop","idle"
dir           = 1;       // 1 right, -1 left
hsp        = 0;
vsp      = 0;
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
//alarm[0]      = irandom_range(room_speed*2, room_speed*5); // schedule first chirp
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
off_body_x   = 0 * scale;   
off_body_y   = 0 * scale;
off_head_x   = off_body_x + 12 * scale;  
off_head_y   = off_body_y + -6 * scale;
off_wing_x   = 2 * scale;   
off_wing_y   = 0 * scale;
off_tail_x   = -10 * scale; 
off_tail_y   = 2 * scale;
off_eye_x    = off_head_x + (65 * scale);  
off_eye_y    = off_head_y - (28 * scale);
off_beak_x   = off_head_x + (78 * scale);  
off_beak_y   = off_head_y - (15 * scale);

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
vsp = -1.0;


// === Timers (replacing alarms) ===
// Chirp (beak open/close)
chirp_wait_min  = room_speed * 2;
chirp_wait_max  = room_speed * 5;
chirp_dur_min   = room_speed * 0.4;
chirp_dur_max   = room_speed * 0.7;

chirp_wait_t = irandom_range(chirp_wait_min,  chirp_wait_max); // countdown to next chirp
chirp_dur_t  = 0;                                              // time remaining with beak open

// Tail swish on/off
tail_wait_min  = room_speed * 2;
tail_wait_max  = room_speed * 6;
tail_dur_min   = room_speed * 1;
tail_dur_max   = room_speed * 2;

tail_wait_t = irandom_range(tail_wait_min, tail_wait_max); // countdown to next swish start
tail_dur_t  = 0;                                           // time remaining swishing

// --- Flapping & air physics ---
wing_img        = 0;
wing_frames     = 11;        // you used 0..10
flap_phase      = 0.0;       // 0..1
flap_base       = 0.12;      // baseline flap speed
flap_speed_gain = 0.04;      // adds flap speed from |hspeed|
flap_alt_gain   = 0.08;      // adds flap speed when below cruise_y
flap_force      = 0.22;      // upward impulse at downstroke peak
g_air           = 0.12;      // gravity while flying (lighter than ground g)


}


function scr_bird_step() {
	/// ===== BIRD: Step =====

// Pick facing from motion
if (hsp >  0.1) dir = 1;
if (hsp < -0.1) dir = -1;
image_xscale = scale * dir;

// --- State machine ---
if (state == "fly") {
    // Gentle horizontal wander
    hsp += random_range(-fly_wander, fly_wander);
    hsp = clamp(hsp, -fly_speed, fly_speed);

    // --- Flap-driven vertical control ---
    // If flapping slows (low flap_speed), gravity (g_air) dominates and it sinks.
    var speed_h  = abs(hsp);
    var alt_err  = (cruise_y - y);        // >0 means we're below target (need more lift)
    var alt_need = clamp(alt_err, 0, 32); // only boost when below target

    // how fast to advance the wing phase this step
    var flap_speed = flap_base
                   + speed_h * flap_speed_gain
                   + (alt_need/32) * flap_alt_gain;

    // advance flap phase [0..1)
    flap_phase += flap_speed;
    if (flap_phase >= 1) flap_phase -= 1;

    // downstroke model: positive half-cycle produces lift
    var stroke = sin(flap_phase * 2 * pi);   // -1..1
    var lift   = max(0, stroke) * flap_force * (1 + speed_h * 0.2);

    // air gravity then lift
    vsp += g_air;
    vsp -= lift;

    // clamp fall/speed
    vsp = clamp(vsp, -max_fall, max_fall);

    // Occasionally retarget cruise altitude a bit to feel alive
    if (irandom(90) == 0) cruise_y += irandom_range(-6, 6);

    // Occasionally decide to land if there’s sidewalk below
    desire_to_land_t--;
    if (desire_to_land_t <= 0) {
        var target = instance_place(x, y + 32, floor);
        if (target != noone) {
            state = "land";
        } else {
            desire_to_land_t = irandom_range(room_speed*3, room_speed*8);
        }
    }

} else if (state == "land") {
    // Drop to the floor (ground gravity)
    vsp += g;
    if (_is_on_floor()) {
        vsp = 0;
        state = "hop";
        hop_cooldown = irandom_range(room_speed*1, room_speed*2);
    }

} else if (state == "hop") {
    // Idle / tiny shuffle between hops
    if (_is_on_floor()) {
        vsp = 0;
        hop_cooldown--;

        // Randomly hop
        if (hop_cooldown <= 0) {
            var push = choose(-hop_h, hop_h);
            if (random(1) < 0.7) push = dir * hop_h; // bias toward facing
            hsp = push;
            vsp = -hop_v;
            hop_cooldown = irandom_range(room_speed*20, room_speed*40);
        }

        // Occasionally take off again
        idle_t++;
        if (idle_t > irandom_range(room_speed*3, room_speed*7)) {
            state = "fly";
            idle_t = 0;
            desire_to_land_t = irandom_range(room_speed*4, room_speed*9);
            vsp = -random_range(1.5, 2.8);         // little kick
            hsp += dir * random_range(0.5, 1.2);
        }
    } else {
        // Mid-hop, apply ground gravity
        vsp += g;
    }
}

// Apply movement
x += hsp;
y += vsp;

// --- Pose updates ---
// Use wing phase to pick a frame; if you prefer sine, restore your old math.
wing_img = floor(flap_phase * wing_frames);
if (wing_img >= wing_frames) wing_img = wing_frames - 1;

// If you’re drawing wings with rotation instead of frames, you can also do:
// wing_angle = stroke * flap_amp;  // where stroke from above is sin(phase*2*pi)
// (and draw with your rotated wing sprites)

var target_body = clamp(-vsp * body_tilt_scale, body_tilt_min, body_tilt_max);
body_angle = lerp(body_angle, target_body, 0.12);

var target_head = body_angle * head_follow_amt;
head_angle = lerp(head_angle, target_head, 0.18);

// Tail: passive or swish
if (tail_active) {
    tail_t += tail_rate;
    tail_angle = sin(degtorad(tail_t*6)) * tail_amp;
} else {
    tail_angle = lerp(tail_angle, -body_angle*0.25, 0.08);
}

// === Timers (step-driven) ===
// ---- Chirp (open/close beak) ----
if (chirp_dur_t > 0) {
    chirp_dur_t -= 1;
    beak_open = true;
    if (chirp_dur_t <= 0) {
        beak_open = false;
        chirp_wait_t = irandom_range(chirp_wait_min, chirp_wait_max);
    }
} else {
    if (chirp_wait_t > 0) chirp_wait_t -= 1;
    if (chirp_wait_t <= 0) {
        beak_open = true;
        // audio_play_sound(sndBirdChirp, 1, false);
        chirp_dur_t = irandom_range(chirp_dur_min, chirp_dur_max);
    }
}

// ---- Tail swish on/off ----
if (tail_dur_t > 0) {
    tail_active = true;
    tail_dur_t -= 1;
    if (tail_dur_t <= 0) {
        tail_active = false;
        tail_wait_t = irandom_range(tail_wait_min, tail_wait_max);
    }
} else {
    if (tail_wait_t > 0) tail_wait_t -= 1;
    if (tail_wait_t <= 0) {
        tail_active = true;
        tail_dur_t  = irandom_range(tail_dur_min, tail_dur_max);
    }
}

function scr_bird_draw() {
/// ===== BIRD: Draw =====

var base_ang = 0;


// --- BACK WING (behind)
_draw_part(spr_wing_back, wing_img, off_wing_x, off_wing_y, body_angle + wing_angle);

// --- BODY
_draw_part(spr_body, 0, off_body_x, off_body_y, body_angle);

// --- TAIL (slightly behind body center)
_draw_part(spr_tail, 0, off_tail_x, off_tail_y, body_angle + tail_angle);

// --- HEAD
_draw_part(spr_head, 0, off_head_x, off_head_y, head_angle);

// --- EYE (kept simple; could add tiny bob)
_draw_part(spr_eye, 0, off_eye_x, off_eye_y, head_angle);

// --- BEAK (top rotates to “open”)
var beak_top_ang = head_angle + (beak_open ? beak_open_ang : 0);
//var beak_btm_ang = head_angle - (beak_open ? beak_open_ang : 0);
_draw_part(spr_beak_btm, 0, off_beak_x, off_beak_y, 0);
_draw_part(spr_beak_top, 0, off_beak_x, off_beak_y, beak_top_ang);

// --- FRONT WING (in front)
_draw_part(spr_wing_front, wing_img, off_wing_x, off_wing_y, body_angle - wing_angle);
	
}

}

	