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
