function scr_bird_create(){
    // Sprites
    spr_head       = sprBirdHead;
    spr_body       = sprBirdBody;
    spr_wing_front = sprBirdWingFront;
    spr_wing_back  = sprBirdWingBack;
    spr_eye        = sprBirdEye;
    spr_tail       = sprBirdTail;
    spr_beak_top   = sprBirdBeakTop;
    spr_beak_btm   = sprBirdBeakBtm;

    // Visual
    col   = c_red;
    scale = random_range(0.16, 0.24);
    dir   = choose(-1,1);
    image_xscale = scale * dir;
    image_yscale = scale;

    // Ground
    ground = objSidewalk;  // single source of truth
    _floor  = ground;       // (if any code still uses 'floor')

    // State & kinematics
    state      = "fly"; // "fly","land","hop","idle"
    hsp        = 0;
    vsp        = -1;    // small initial upward nudge
    g          = 0.35;  // ground gravity
    g_air      = 0.11;  // lighter gravity while flying
    fly_speed  = 1.6;
    fly_wander = 0.04;
    max_fall   = 6;

    // Body pose
    body_angle       = 0;
    head_angle       = 0;
    wing_angle       = 0;
    tail_angle       = 0;
    body_tilt_scale  = 1.7;
    body_tilt_min    = -15;
    body_tilt_max    = 20;
    head_follow_amt  = 0.35;

    // Flapping & lift (phase-driven)
    wing_img        = 0;
    wing_frames     = 11;   // 0..10
    flap_phase      = 0.0;
    flap_base       = 0.10; // baseline flap rate
    flap_speed_gain = 0.05; // faster if moving horizontally
    flap_alt_gain   = 0.10; // faster if too low
    flap_force      = 0.28; // upforce on downstroke

    // Flight targets (cruise, ceiling, ground avoidance)
    cruise_y  = y + irandom_range(-16, 16);
    fly_ceiling_y = y - 120; // don’t climb above this; will be adjusted below
    min_fly_y = y - 200;     // safety buffer above ground; set precisely below

    // Find ground under spawn (up to 600px), set safe flight band
    var gy = noone;
    for (var i = 0; i < 600; i++) {
        if (instance_place(x, y + i, ground) != noone) { gy = y + i; break; }
    }
    if (gy != noone) {
        min_fly_y     = gy - 12;               // don’t dip below this while flying
        cruise_y      = min(cruise_y, gy - 56);
        fly_ceiling_y = min(fly_ceiling_y, gy - 120);
    }

    // Beak (chirp) — step timers
    beak_open     = false;
    beak_open_ang = 16;
    chirp_wait_min= room_speed * 2;
    chirp_wait_max= room_speed * 5;
    chirp_dur_min = room_speed * 0.4;
    chirp_dur_max = room_speed * 0.7;
    chirp_wait_t  = irandom_range(chirp_wait_min, chirp_wait_max);
    chirp_dur_t   = 0;

    // Tail swish — step timers
    tail_active   = false;
    tail_amp      = 12;
    tail_rate     = 5;
    tail_t        = 0;
    tail_wait_min = room_speed * 2;
    tail_wait_max = room_speed * 6;
    tail_dur_min  = room_speed * 1;
    tail_dur_max  = room_speed * 2;
    tail_wait_t   = irandom_range(tail_wait_min, tail_wait_max);
    tail_dur_t    = 0;

    // Land/hop cadence
    desire_to_land_t = irandom_range(room_speed*3, room_speed*8);
    hop_cooldown     = 0;
    hop_h            = 1.5;
    hop_v            = 4.0;
    idle_t           = 0;

    // Offsets (unscaled, facing right)
    off_body_x = 0;   off_body_y = 0;
    off_head_x = 12;  off_head_y = -6;
    off_wing_x = 2;   off_wing_y = 0;
    off_tail_x = -10; off_tail_y = 2;
    off_eye_x  = off_head_x + 65;  off_eye_y  = off_head_y - 28;
    off_beak_x = off_head_x + 78;  off_beak_y = off_head_y - 15;
}


function scr_bird_step() {
    // Facing
    if (hsp >  0.1) dir = 1;
    if (hsp < -0.1) dir = -1;
    image_xscale = scale * dir;
    image_yscale = scale;

    // ===== State machine =====
    if (state == "fly") {
        // horizontal wander
        hsp += random_range(-fly_wander, fly_wander);
        hsp  = clamp(hsp, -fly_speed, fly_speed);

        // --- vertical control (flap + gravity) ---
        // Don’t climb too high: nudge cruise down if we breach ceiling
        if (y < fly_ceiling_y) cruise_y = lerp(cruise_y, fly_ceiling_y + 24, 0.05);

        // Need-based flap rate
        var speed_h  = abs(hsp);
        var alt_err  = (cruise_y - y);                 // >0 => below target
        var alt_need = clamp(alt_err, 0, 48);

        var flap_speed = flap_base
                       + speed_h * flap_speed_gain
                       + (alt_need/48) * flap_alt_gain;

        // advance flap phase 0..1
        flap_phase += flap_speed;
	if (flap_phase >= 1) flap_phase -= 1;
	if (flap_phase < 0)  flap_phase += 1; // just in case

        var stroke = sin(flap_phase * 2 * pi);         // -1..1
        var lift   = max(0, stroke) * flap_force * (1 + speed_h * 0.25);

        // Air gravity first, then lift
        vsp += g_air;

        // extra avoidance if getting near ground
        if (y > min_fly_y) lift += 0.35;

        vsp -= lift;
        vsp = clamp(vsp, -max_fall, max_fall);

        // Land decision
        desire_to_land_t--;
        if (desire_to_land_t <= 0) {
            var t = instance_place(x, y + 32, ground);
            if (t != noone) {
                state = "land";
            } else {
                desire_to_land_t = irandom_range(room_speed*3, room_speed*8);
            }
        }

    } else if (state == "land") {
        // fall to ground
        vsp += g;
        if (_is_on_floor(ground)) {
            // pop out of any overlap
            while (place_meeting(x, y, ground)) y -= 1;
            vsp = 0;
            state = "hop";
            hop_cooldown = irandom_range(room_speed*1, room_speed*2);
        }

    } else if (state == "hop") {
        if (_is_on_floor(ground)) {
            vsp = 0;
            hop_cooldown--;

            if (hop_cooldown <= 0) {
                var push = choose(-hop_h, hop_h);
                if (random(1) < 0.7) push = dir * hop_h; // bias forward
                hsp = push;
                vsp = -hop_v;
                hop_cooldown = irandom_range(room_speed*20, room_speed*40);
            }

            // takeoff sometimes
            idle_t++;
            if (idle_t > irandom_range(room_speed*3, room_speed*7)) {
                state = "fly";
                idle_t = 0;
                desire_to_land_t = irandom_range(room_speed*4, room_speed*9);
                vsp = -random_range(1.5, 2.8);
                hsp += dir * random_range(0.5, 1.2);
            }
        } else {
            // mid-hop arc
            vsp += g;
        }
    }

    // ===== Movement (with ground-safe Y) =====
    x += hsp;
  //  _move_y_solid(vsp, ground);

    // ===== Pose =====
   // keep flap_phase in [0,1) and pick a valid subimage index
flap_phase = (flap_phase % 1 + 1) % 1;          // robust wrap
var frames  = max(1, wing_frames);               // avoid zero
var idx     = floor(flap_phase * frames);
wing_img    = clamp(idx, 0, frames - 1);

    var target_body = clamp(-vsp * body_tilt_scale, body_tilt_min, body_tilt_max);
    body_angle = lerp(body_angle, target_body, 0.12);

    var target_head = body_angle * head_follow_amt;
    head_angle = lerp(head_angle, target_head, 0.18);

    if (tail_active) {
        tail_t += tail_rate;
        tail_angle = sin(degtorad(tail_t*6)) * tail_amp;
    } else {
        tail_angle = lerp(tail_angle, -body_angle*0.25, 0.08);
    }

    // ===== Timers (chirp & tail) =====
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
}



function scr_bird_draw() {
/// ===== BIRD: Draw =====

var base_ang = 0;

shader_hue_start(col);
// --- BACK WING (behind)
_draw_bird_part(spr_wing_back, wing_img, off_wing_x, off_wing_y, body_angle + wing_angle);

// --- BODY
_draw_bird_part(spr_body, 0, off_body_x, off_body_y, body_angle);

// --- TAIL (slightly behind body center)
_draw_bird_part(spr_tail, 0, off_tail_x, off_tail_y, body_angle + tail_angle);

// --- HEAD
_draw_bird_part(spr_head, 0, off_head_x, off_head_y, head_angle);

// --- EYE (kept simple; could add tiny bob)
_draw_bird_part(spr_eye, 0, off_eye_x, off_eye_y, head_angle);

// --- BEAK (top rotates to “open”)
var beak_top_ang = head_angle + (beak_open ? beak_open_ang : 0);
var beak_btm_ang = head_angle;
_draw_bird_part(spr_beak_btm, 0, off_beak_x, off_beak_y, beak_btm_ang);
_draw_bird_part(spr_beak_top, 0, off_beak_x, off_beak_y, beak_top_ang);


// --- FRONT WING (in front)
_draw_bird_part(spr_wing_front, wing_img, off_wing_x, off_wing_y, body_angle - wing_angle);
	
	//shader_reset();
}



/// Returns true if standing on ground
function _is_on_floor(__floor) {
    return place_meeting(x, y + 1, __floor);
}


/// Collision-safe vertical move against ground (prevents tunneling)
/*
function _move_y_solid(_vy, _floor_obj) {
    // No movement? nothing to do.
    if (_vy == 0) return;

    var s = sign(_vy);
    // number of full-pixel steps (must be integer)
    var steps = abs(floor(_vy));

    // Move 1px at a time
    repeat (steps) {
        if (!place_meeting(x, y + s, _floor_obj)) {
            y += s;
        } else {
            vsp = 0;   // stop vertical speed on impact
            return;    // abort further movement this step
        }
    }

    // Move the leftover fractional part (if any)
    var frac = _vy - s * steps; // this is in (-1, 1)
    if (frac != 0) {
        if (!place_meeting(x, y + frac, _floor_obj)) {
            y += frac;
        } else {
            vsp = 0;
            // no return needed; nothing more to do
        }
    }
}


}