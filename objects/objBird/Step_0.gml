/// ===== BIRD: Step =====

// Pick facing from motion
if (hspeed >  0.1) dir = 1;
if (hspeed < -0.1) dir = -1;
image_xscale = scale * dir;

// --- State machine ---
if (state == "fly") {
    // Gentle wander while flying
    hspeed += random_range(-fly_wander, fly_wander);
    hspeed = clamp(hspeed, -fly_speed, fly_speed);

    // Tiny downward bias to keep motion organic
    vspeed += fly_float_g;
    vspeed = clamp(vspeed, -max_fall, max_fall);

    // Occasionally decide to land if over sidewalk
    desire_to_land_t--;
    if (desire_to_land_t <= 0) {
        // Look a bit below for floor
        var target = instance_place(x, y+32, floor);
        if (target != noone) {
            state = "land";
        } else {
            desire_to_land_t = irandom_range(room_speed*3, room_speed*8);
        }
    }

} else if (state == "land") {
    // Drop to the floor
    vspeed += g;
    if (_is_on_floor()) {
        vspeed = 0;
        y = y; // already on floor
        state = "hop";
        hop_cooldown = irandom_range(room_speed*1, room_speed*2);
    }

} else if (state == "hop") {
    // Idle / tiny shuffle between hops
    if (_is_on_floor()) {
        vspeed = 0;
        hop_cooldown--;

        // Randomly hop
        if (hop_cooldown <= 0) {
            // small hop forward or backward
            var push = choose(-hop_h, hop_h);
            if (random(1) < 0.7) push = dir * hop_h; // bias toward facing

            hspeed = push;
            vspeed = -hop_v;
            hop_cooldown = irandom_range(room_speed*20, room_speed*40);
        }

        // Occasionally decide to take off again
        idle_t++;
        if (idle_t > irandom_range(room_speed*3, room_speed*7)) {
            state = "fly";
            idle_t = 0;
            desire_to_land_t = irandom_range(room_speed*4, room_speed*9);
            // small upward kick on takeoff
            vspeed = -random_range(1.5, 2.8);
            hspeed += dir * random_range(0.5, 1.2);
        }
    } else {
        // Mid-hop, apply gravity
        vspeed += g;
    }
}

// Apply movement
x += hspeed;
y += vspeed;

// Soft damping when flying
if (state == "fly") {
    // Gentle horizontal wander
    hspeed += random_range(-fly_wander, fly_wander);
    hspeed = clamp(hspeed, -fly_speed, fly_speed);

    // --- Vertical control (adds lift so it doesn't just fall) ---
    // error: positive if we're below cruise_y (need more lift)
    var alt_err = (cruise_y - y);

    // small sinusoidal bob for life
    fly_bob_t += fly_bob_spd;
    var bob = sin(degtorad(fly_bob_t)) * fly_bob_amp;

    // PD controller: lift = kp * error - kd * vspeed + bob
    var lift = fly_kp * alt_err - fly_kd * vspeed + bob;

    vspeed += lift;                      // apply lift (net against gravity)
    vspeed = clamp(vspeed, -max_fall, max_fall);

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
}


// Pose updates
// Wings flap on sine; only animated part
flap_t += flap_rate * (state == "fly" ? 1 : 0.7);
wing_angle = sin(degtorad(flap_t*6)) * flap_amp;

// Body tilt follows vertical speed
var target_body = clamp(-vspeed * body_tilt_scale, body_tilt_min, body_tilt_max);
body_angle = lerp(body_angle, target_body, 0.12);

// Head lags body a touch
var target_head = body_angle * head_follow_amt;
head_angle = lerp(head_angle, target_head, 0.18);

// Tail: passive or swish
if (tail_active) {
    tail_t += tail_rate;
    tail_angle = sin(degtorad(tail_t*6)) * tail_amp;
} else {
    // subtle small counter to body
    tail_angle = lerp(tail_angle, -body_angle*0.25, 0.08);
}

wing_img++;
if (wing_img>10) {wing_img=0;}
