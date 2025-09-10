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
    ground = objSidewalk;

    // State & motion (TWO STATES ONLY)
    state      = "fly";     // "fly" | "ground"
    hsp        = 0;
    vsp        = -1;        // gentle start upward
    g_ground   = 0.35;      // while on ground
    g_air      = 0.09;      // light air gravity
    fly_speed  = 1.8;
    fly_wander = 0.05;
    max_fall   = 5.5;

    // Pose
    body_angle      = 0;
    head_angle      = 0;
    wing_angle      = 0;
    tail_angle      = 0;
    body_tilt_scale = 1.7;
    body_tilt_min   = -15;
    body_tilt_max   = 20;
    head_follow_amt = 0.35;

    // Flap & lift (phase-driven)
    wing_img        = 0;
    wing_frames     = 11;      // 0..10
    flap_phase      = 0.0;
    flap_base       = 0.12;
    flap_speed_gain = 0.06;
    flap_alt_gain   = 0.12;
    flap_force      = 0.42;    // strong enough to beat g_air

    // Flight band (cruise target, soft ceiling, ground-avoid)
    cruise_y      = y + irandom_range(-16, 16);
    fly_ceiling_y = y - 120;
    min_fly_y     = -.00000001;

    // Find ground below to set safe band
    var gy = noone;
    for (var i = 0; i < 600; i++) if (instance_place(x, y + i, ground) != noone) { gy = y + i; break; }
    if (gy != noone) {
        min_fly_y     = gy - 12;              // don’t dip below this while flying
        cruise_y      = min(cruise_y, gy - 56);
        fly_ceiling_y = min(fly_ceiling_y, gy - 120);
    }

    // Ground behavior tuning
    hop_cooldown = 0;
    hop_h        = 1.5;
    hop_v        = 3.8;
    idle_t       = 0;

    // Offsets (unscaled, facing right)
    off_body_x = 0;   off_body_y = 0;
    off_head_x = 12;  off_head_y = -6;
    off_wing_x = 2;   off_wing_y = 0;
    off_tail_x = -10; off_tail_y = 2;
    off_eye_x  = off_head_x + 65;  off_eye_y  = off_head_y - 28;
    off_beak_x = off_head_x + 78;  off_beak_y = off_head_y - 15;

    // Beak / Tail (timers, optional – keep your existing step timers if you like)
    beak_open     = false;
    beak_open_ang = 16;
    chirp_wait_min = room_speed * 2; chirp_wait_max = room_speed * 5;
    chirp_dur_min  = room_speed * 0.4; chirp_dur_max = room_speed * 0.7;
    chirp_wait_t   = irandom_range(chirp_wait_min, chirp_wait_max);
    chirp_dur_t    = 0;

    tail_active   = false;
    tail_amp      = 12;
    tail_rate     = 5;
    tail_t        = 0;
    tail_wait_min = room_speed * 2; tail_wait_max = room_speed * 6;
    tail_dur_min  = room_speed * 1; tail_dur_max  = room_speed * 2;
    tail_wait_t   = irandom_range(tail_wait_min, tail_wait_max);
    tail_dur_t    = 0;
}


function scr_bird_step() {
    // Facing & scale
    if (hsp >  0.1) dir = 1;
    if (hsp < -0.1) dir = -1;
    image_xscale = scale * dir;
    image_yscale = scale;

    if (state == "fly") {
        // --- Better horizontal wander (keeps moving) ---
		if (!variable_instance_exists(id, "wander_t")) {
		    wander_t = 0;
		    desired_hsp = choose(-1,1) * random_range(0.6, 1.0) * fly_speed;
		}
		wander_t--;
		if (wander_t <= 0) {
		    // pick a new horizontal target every 1–3 seconds
		    desired_hsp = choose(-1,1) * random_range(0.5, 1.0) * fly_speed;
		    // 20% chance to flip direction bias
		    if (irandom(4) == 0) desired_hsp = -desired_hsp;
		    wander_t = irandom_range(room_speed, room_speed*3);
		}
		// steer smoothly toward desired_hsp
		hsp = lerp(hsp, desired_hsp, 0.06);

		// --- Ceiling control (screen Y increases downward) ---
		// If we are ABOVE the ceiling (smaller y), push the target DOWN below us
		if (y < fly_ceiling_y) {
		    cruise_y = lerp(cruise_y, y + 96, 0.15);  // set a lower (greater Y) target
		    vsp += 0.25;                               // add a little downward bias now
		}

		// --- Flap rate & lift (corrected sign) ---
		var speed_h  = abs(hsp);
		var alt_err  = (y - cruise_y);     // >0 means we are BELOW (greater Y) -> need lift
		var need     = clamp(alt_err, 0, 64) / 64.0;

		var flap_speed = flap_base
		               + speed_h * flap_speed_gain
		               + need * flap_alt_gain;

		flap_phase += flap_speed;
		if (flap_phase >= 1) flap_phase -= 1;

		var stroke = sin(flap_phase * 2 * pi); // -1..1
		var lift   = max(0, stroke) * flap_force * (1 + speed_h * 0.25);

		// Air gravity first, then lift. Only add ground-avoid lift near ground.
		vsp += g_air;
		if (instance_place(x, y + 48, ground) != noone) lift += 0.25;
		vsp -= lift;
		vsp = clamp(vsp, -max_fall, max_fall);


        // Land if ground is close under us sometimes
        if (irandom(120) == 0 && instance_place(x, y + 24, ground) != noone) {
            state = "ground";
        }

    } else { // ===== "ground" =====
        // Apply stronger gravity
        vsp += g_ground;

        // On ground? hop around a bit; sometimes take off
        if (place_meeting(x, y + 1, ground)) {
            vsp = 0;

            // tiny random hop
            hop_cooldown--;
            if (hop_cooldown <= 0) {
                var push = choose(-hop_h, hop_h);
                if (random(1) < 0.7) push = dir * hop_h;
                hsp = push;
                vsp = -hop_v;
                hop_cooldown = irandom_range(room_speed*20, room_speed*40);
            }

            // chance to fly away
            idle_t++;
            if (idle_t > irandom_range(room_speed*3, room_speed*7)) {
                state = "fly";
                idle_t = 0;
                vsp = -random_range(1.2, 2.4);
                hsp += dir * random_range(0.5, 1.2);
            }
        }
    }

    // ===== Movement (simple + floor resolve) =====
    x += hsp;
    y += vsp;

    // If we intersect ground after moving, push out & stop vsp
    if (place_meeting(x, y, ground)) {
        var push = sign(vsp);
        if (push == 0) push = 1;
        while (place_meeting(x, y, ground)) y -= push;
        vsp = 0;
        state = "ground"; // if we touched ground, we are grounded now
    }

    // ===== Poses =====
    // wing frame from phase
    var frames = max(1, wing_frames);
    var idx    = floor(((flap_phase % 1 + 1) % 1) * frames);
    wing_img   = clamp(idx, 0, frames - 1);

    var target_body = clamp(-vsp * body_tilt_scale, body_tilt_min, body_tilt_max);
    body_angle = lerp(body_angle, target_body, 0.12);

    var target_head = body_angle * head_follow_amt;
    head_angle = lerp(head_angle, target_head, 0.18);

    if (tail_active) {
        tail_t += tail_rate;
        tail_angle = sin(degtorad(tail_t * 6)) * tail_amp;
    } else {
        tail_angle = lerp(tail_angle, -body_angle * 0.25, 0.08);
    }

    // ===== Simple timers (optional) =====
    if (chirp_dur_t > 0) {
        chirp_dur_t -= 1; beak_open = true;
        if (chirp_dur_t <= 0) { beak_open = false; chirp_wait_t = irandom_range(chirp_wait_min, chirp_wait_max); }
    } else {
        if (chirp_wait_t > 0) chirp_wait_t -= 1;
        if (chirp_wait_t <= 0) { beak_open = true; chirp_dur_t = irandom_range(chirp_dur_min, chirp_dur_max); }
    }

    if (tail_dur_t > 0) {
        tail_active = true; tail_dur_t -= 1;
        if (tail_dur_t <= 0) { tail_active = false; tail_wait_t = irandom_range(tail_wait_min, tail_wait_max); }
    } else {
        if (tail_wait_t > 0) tail_wait_t -= 1;
        if (tail_wait_t <= 0) { tail_active = true; tail_dur_t = irandom_range(tail_dur_min, tail_dur_max); }
    }
	
	if (x < 32)  desired_hsp = abs(desired_hsp);
	if (x > room_width - 32) desired_hsp = -abs(desired_hsp);



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


