function scr_bird_create(){
	
	species="bird";
	/*
	 if (current_month==10) {
		 species="bat";
	 } else {
		 species="bird";
	}*/
	// Roll the dice and set species
var p = undead_chance_autumn();      // 0..1
if (random(1) < p) {
    species = "bat";
}
    
	if (species="bird") {
		color_body = make_color_hsv(irandom(255),irandom(255),irandom(255));
		color_body_2 = make_color_hsv(irandom(255),irandom(255),irandom(255));
		color_body_3 = make_color_hsv(irandom(255),irandom(255),irandom(255));
		color_eye = make_color_hsv(irandom(255),irandom(255),irandom(255));
		color_beak = make_color_hsv(irandom(255),irandom(255),irandom(255));
	} else if (species="bat"){
		color_body = make_color_rgb(irandom(255),irandom(64),irandom(64));
		color_body_2 = make_color_rgb(irandom(255),irandom(64),irandom(64));
		color_body_3 = make_color_rgb(irandom(255),irandom(64),irandom(64));
		color_eye = make_color_rgb(irandom_range(128,255),irandom(32),irandom(32));
		color_beak = make_color_rgb(irandom(32),irandom(32),irandom(32));
	} else {
	
		color_body = make_color_hsv(irandom(255),irandom(255),irandom(255));
		color_body_2 = make_color_hsv(irandom(255),irandom(255),irandom(255));
		color_body_3 = make_color_hsv(irandom(255),irandom(255),irandom(255));
		color_eye = make_color_hsv(irandom(255),irandom(255),irandom(255));
		color_beak = make_color_hsv(irandom(255),irandom(255),irandom(255));
}
// Sprites
    spr_head       = sprBirdHead;
    spr_body       = sprBirdBody;
	if (species=="bird") {
		spr_wing_front = sprBirdWingFront;
		spr_wing_back  = sprBirdWingBack;
		spr_wing_ground = sprBirdWingGround;
	} else if species=="bat" {
		spr_wing_front = sprBirdWingBat;
		spr_wing_back  = sprBirdWingBat;
		spr_wing_ground = sprBirdWingGround;
	} else {
		
		spr_wing_front = sprBirdWingFront;
		spr_wing_back  = sprBirdWingBack;
		spr_wing_ground = sprBirdWingGround;
		}
    spr_eye        = sprBirdEye;
    spr_tail       = sprBirdTail;
    spr_beak_top   = sprBirdBeakTop;
    spr_beak_btm   = sprBirdBeakBtm;
	if (species=="bird") {
		idx_head	   = choose(0,1);
	} else if (species=="bat"){
		idx_head	   = choose(0,2);
	} else {
		idx_head	   = choose(0,1);
	}
	

	// --- Landing planner (fly -> ground)
	land_scan_dist     = 64;                       // how far below to look for ground
	land_check_min     = room_speed * 3;           // increased frequency
	land_check_max     = room_speed * 8;           
	land_timer         = irandom_range(land_check_min, land_check_max);
	landing            = false;                    // are we in a landing approach?
	perch_x            = x;                        // x position to land at - ADDED THIS
	perch_y            = y;                        // y to touch down on
	landing_flap_mul   = 0.25;                     // reduce lift more while landing
	perch_snap_pad     = 16;                       // increased snap distance
	land_scan_ahead    = 12;                       // reduced look ahead
	landing_descent    = 0.35;                     // increased downward bias
	landing_hsp_damp   = 0.12;                     // how fast to bleed horizontal speed

	// --- Flocking (Boids-lite) ---
	flock_on            = true;      // master switch
	flock_tag           = 0;         // birds only flock with same tag (0..N). Use if you want subflocks.
	flock_range         = 160;       // how far to sense neighbors
	flock_sep_range     = 28;        // strong push if closer than this
	flock_max_neighbors = 8;         // perf clamp

	// steering weights
	flock_w_align = 0.8;             // match heading/speed
	flock_w_coh   = 0.6;             // move toward center
	flock_w_sep   = 1.3;             // keep distance
	flock_mix     = 0.55;            // how much flocking overrides wander [0..1]

	// limits/smoothing
	flock_max_force = 0.08;          // max steering delta per step (horizontal)
	flock_smooth    = 0.12;          // lerp factor when applying steer

	// vertical cohesion → adjust cruise_y slowly (not during landing)
	flock_coh_vert_gain = 0.02;      // how quickly cruise_y drifts toward flock Y
	flock_coh_vert_offset = -24;     // keep a little above group center
	// In Create:
	is_leader = (irandom(7) == 0); // ~1/8 are leaders

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
        min_fly_y     = gy - 12;              // don't dip below this while flying
        cruise_y      = min(cruise_y, gy - 56);
        fly_ceiling_y = min(fly_ceiling_y, gy - 120);
    }

    // Ground behavior tuning
    hop_cooldown = 0;
    hop_h        = 1.5;
    hop_v        = 3.8;
    idle_t       = 0;
    
    // Ground nibbling behavior - ADDED THIS
    nibble_cooldown = 0;
    nibble_duration = 0;
    is_nibbling = false;
    head_bob_offset = 0;

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
   
    // Initialize stamina variables if they don't exist (for existing instances)
    if (!variable_instance_exists(id, "stamina")) {
        stamina_max     = room_speed * 16;  
        stamina         = stamina_max;     
        stamina_drain   = 1;               
        stamina_regen   = 2;               
        stamina_low     = stamina_max * 0.3; 
        stamina_critical = stamina_max * 0.1; 
        must_land       = false;           
    }
    
    // DEBUG: Force landing every few seconds to test
    if (!variable_instance_exists(id, "debug_land_timer")) {
        debug_land_timer = room_speed * 3;
    }
    debug_land_timer--;
    if (debug_land_timer <= 0) {
        debug_land_timer = room_speed * 5;
        show_debug_message("Bird trying to land - stamina: " + string(stamina) + " state: " + state);
        
        // Force transition to ground for testing
        if (state == "fly") {
			landing=true;
            //state = "ground";
            vsp = 0;
            hsp *= 0.3;
            //landing = false;
            must_land = true;
            hop_cooldown = room_speed * 2;
            nibble_cooldown = room_speed * 1;
            show_debug_message("FORCED BIRD TO GROUND STATE");
        }
    }
   
 // Facing & scale
    if (hsp >  0.1) dir = 1;
    if (hsp < -0.1) dir = -1;
    image_xscale = scale * dir;
    image_yscale = scale;

    if (state == "fly") {
    // --- Better horizontal wander so they *move* ---
    if (!variable_instance_exists(id, "wander_t")) {
        wander_t = 0;
        desired_hsp = choose(-5,5) * random_range(0.6, 1.0) * fly_speed;
    }
    wander_t--;
    if (wander_t <= 0) {
        desired_hsp = choose(-5,5) * random_range(0.5, 1.0) * fly_speed;
        if (irandom(4) == 0) desired_hsp = -desired_hsp;       // sometimes flip bias
        wander_t = irandom_range(room_speed, room_speed*3);
    }
    // steer smoothly toward target horizontal speed
    hsp = lerp(hsp, desired_hsp, 0.06);
	//if 
	// --- FLOCKING (only in air, skip while landing descent is critical) ---
		if (flock_on) {
		    var sum_x = 0, sum_y = 0, sum_h = 0;  // positions & horizontal speeds
		    var sep_x = 0;                        // separation push (horizontal)
		    var n = 0;

		    // Iterate neighbors (cap for perf)
		if (object_index == objBird && flock_on) {
		    var sum_x = 0, sum_y = 0, sum_h = 0;
		    var sep_x = 0;
		    var n = 0;
		    with (objBird) {
		        if (id == other.id) continue;
		        if (!flock_on) continue;
		        if (flock_tag != other.flock_tag) continue;   // optional subflock
		        if (other.state != "fly") continue;           // only flock with flyers

		        var dx = x - other.x;
		        var dy = y - other.y;
		        var d2 = dx*dx + dy*dy;
		        if (d2 <= sqr(other.flock_range)) {
		            // Count (cap to avoid O(N^2) cost blowup)
		            n += 1;
		            if (n > other.flock_max_neighbors) break;

		            // Cohesion / alignment
		            sum_x += other.x;
		            sum_y += other.y;
		            sum_h += other.hsp;

		            // Separation (stronger if very close)
		            if (d2 < sqr(other.flock_sep_range)) {
		                var d = max(1, sqrt(d2));
		                sep_x += (x - other.x) / d; // horizontal push away
		            }
		        }
		    }
		}

	    if (n > 0) {
	        var avg_x = sum_x / n;
	        var avg_y = sum_y / n;
	        var avg_h = sum_h / n;

	        // Alignment: match group horizontal speed
	        var steer_align = (avg_h - hsp);

	        // Cohesion: move toward center in X (small, bounded)
	        var to_center_x = clamp((avg_x - x) * 0.02, -1, 1) * fly_speed;

	        // Separation: push away in X
	        var steer_sep = sep_x * fly_speed; // already ~normalized by distance

	        // Combine
	        var steer =  flock_w_align * steer_align
	                   + flock_w_coh   * to_center_x
	                   + flock_w_sep   * steer_sep;

	        // Limit steering force
	        steer = clamp(steer, -flock_max_force, flock_max_force);
			
			// In Step just before blending flock:
			if (is_leader) { flock_mix = 0.15; } else { flock_mix = 0.55; }

	        // Blend flocking with your current desired_hsp
	        var flock_target_hsp = clamp(hsp + steer, -fly_speed, fly_speed);

	        // If landing, keep flock influence small so we don't miss perch
	        var mix = landing ? flock_mix * 0.25 : flock_mix;

	        desired_hsp = lerp(desired_hsp, flock_target_hsp, flock_smooth * mix);

	        // Vertical cohesion: gently drift cruise_y toward flock's Y (not during landing)
	        if (!landing) {
	            var target_cruise = avg_y + flock_coh_vert_offset;
	            cruise_y = lerp(cruise_y, target_cruise, flock_coh_vert_gain);
	        }
	    }
	}

	
	if (landing) {
	    var dx = perch_x - x;
	    var steer = clamp(dx * 0.02, -0.8, 0.8);
	    desired_hsp = steer;
	    hsp = lerp(hsp, desired_hsp, 0.20);	
	}


    // --- Decide to land occasionally if ground is below in front ---
	land_timer--;
	if (!landing && land_timer <= 0) {
	    land_timer = irandom_range(land_check_min, land_check_max);

	    var ahead_x = x + dir * land_scan_ahead;       // look slightly ahead
	    var yy = y;
	    var found_ground = false;
	    
	    // Better ground detection
	    for (var i = 0; i < land_scan_dist; i++) {
	        if (instance_place(ahead_x, yy + i, ground) != noone) {
	            landing = true;
	            perch_x = ahead_x;          // lock target X
	            perch_y = yy + i - 1;       // just above ground pixel
	            cruise_y = perch_y - 12;    // bring target below us so we want to descend
	            found_ground = true;
	            break;
	        }
	    }
	}

    // --- Keep within a vertical band (screen Y grows downward) ---
    if (y < fly_ceiling_y) {
        cruise_y = lerp(cruise_y, y + 96, 0.15);   // aim below current pos
        vsp += 0.25;                                // nudge downward now
    }

    // --- Flap: faster if moving sideways and if we're *below* target (need lift) ---
    var speed_h   = abs(hsp);
    var alt_err   = (y - cruise_y);                 // >0 means we are below target
    var need      = clamp(alt_err, 0, 64) / 64.0;

    var flap_speed = flap_base
                   + speed_h * flap_speed_gain
                   + need * flap_alt_gain;

    flap_phase += flap_speed;
    if (flap_phase >= 1) flap_phase -= 1;

    var stroke = sin(flap_phase * 2 * pi);          // -1..1
    var lift   = max(0, stroke) * flap_force * (1 + speed_h * 0.25);

    // --- Air gravity, then lift (reduced if we're landing) ---
	vsp += g_air;

	if (landing) {
	    // distance to perch; dist_y > 0 means perch is below us
	    var dist_y   = max(0, perch_y - y);
	    var t        = clamp(dist_y / 96, 0, 1);
	    var v_target = lerp(0.15, 2.2, t*t);   // soft target descent

	    var lift_mul  = 0.75;                  // 75% lift while landing (wings still work)
	    var lift_land = lift * lift_mul;

	    // bias toward gentle descent, then let wings cushion it
	    vsp = lerp(vsp, v_target, 0.18);
	    vsp -= lift_land;

	    // cap downward speed during landing
	    vsp = min(vsp, 2.0);
	} else {
	    // tiny buoyancy near ground only when NOT landing
	    if (instance_place(x, y + 48, ground) != noone) lift += 0.12;
	    vsp -= lift;
	    vsp = clamp(vsp, -max_fall, max_fall);
	}



   // vsp -= lift;
   // vsp = clamp(vsp, -max_fall, max_fall);

    // --- Touchdown: improved landing detection ---
	if (landing && vsp >= -0.5) {
	    var close_enough = (point_distance(x, y, perch_x, perch_y) < perch_snap_pad)
	                    || place_meeting(x, y + 2, ground);
	    if (close_enough) {
	        if (place_meeting(x, y, ground)) {
	            while (place_meeting(x, y, ground)) y -= 1;
	        } else {
	            y = perch_y - 1;
	        }
	        vsp = 0;
	        hsp *= 0.3;
	        state   = "ground";
	        landing = false;
	        hop_cooldown    = irandom_range(room_speed*2, room_speed*4);
	        nibble_cooldown = irandom_range(room_speed*1, room_speed*3);
	    }
	}


} else { 
    // ===== "ground" =====
    // Apply stronger gravity
    vsp += g_ground;

    // On ground? hop around a bit; sometimes take off
    if (place_meeting(x, y + 1, ground)) {
		landing = false; 
        vsp = 0;

        // Handle nibbling behavior - ADDED THIS
        if (nibble_duration > 0) {
            is_nibbling = true;
            nibble_duration--;
            // Bob head up and down while nibbling
            head_bob_offset = sin(nibble_duration * 0.3) * 3;
            // Open beak occasionally while nibbling
            if (irandom(10) == 0) {
                beak_open = true;
                chirp_dur_t = 5; // brief beak open
            }
        } else {
            is_nibbling = false;
            head_bob_offset = lerp(head_bob_offset, 0, 0.1);
            
            nibble_cooldown--;
            if (nibble_cooldown <= 0) {
                nibble_duration = irandom_range(room_speed * 0.5, room_speed * 2);
                nibble_cooldown = irandom_range(room_speed * 2, room_speed * 5);
            }
        }

        // tiny random hop
        hop_cooldown--;
        if (hop_cooldown <= 0 && !is_nibbling) {
            var push = choose(-hop_h, hop_h);
            if (random(1) < 0.7) push = dir * hop_h;
            hsp = push;
            vsp = -hop_v;
            hop_cooldown = irandom_range(room_speed*3, room_speed*8);
        }

        // chance to fly away (much longer ground time)
        idle_t++;
        var fly_chance_min = is_nibbling ? room_speed*15 : room_speed*10; // stay grounded much longer
        var fly_chance_max = is_nibbling ? room_speed*25 : room_speed*20;
        if (idle_t > irandom_range(fly_chance_min, fly_chance_max)) {
            state = "fly";
            idle_t = 0;
            vsp = -random_range(1.2, 2.4);
            hsp += dir * random_range(0.5, 1.2);
            is_nibbling = false;
            nibble_duration = 0;
            head_bob_offset = 0;
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
        if (state == "fly") {state = "ground"; landing=false}; // if we touched ground, we are grounded now
    }

    // ===== Poses =====
    // wing frame from phase
    /// ---- Flap rate from movement (frame-rate independent) ----
	var dt = 1 / room_speed;            // seconds per step

	var max_up   = 3.0;                 // expected max upward vsp magnitude
	var max_down = max_fall;
	var h_norm   = clamp(abs(hsp) / fly_speed, 0, 1);  // 0..1 from horizontal speed
	var up_norm  = clamp(-vsp / max_up,        0, 1);  // 0..1 when rising (vsp < 0)
	var dn_norm  = clamp( vsp / max_down,      0, 1);  // 0..1 when falling (vsp > 0)

	// Weight: faster when rising or moving sideways, slower when falling
	var weight = clamp(0.5*h_norm + 0.7*up_norm - 0.6*dn_norm, 0, 1);

	// Target flaps per second (much slower overall)
	var flaps_min = 0.02;   // 1 flap every 50 seconds when resting
	var flaps_max = 0.25;   // ~1 flap every 4 seconds when active
	var flaps_per_sec = lerp(flaps_min, flaps_max, weight);
	
	// Stamina affects flapping rate - but keep flapping during landing!
	if (state == "fly") {
	    var stamina_factor = stamina / stamina_max; // 0 to 1
	    if (landing) {
	        // Flap actively during landing for control
	        flaps_per_sec *= 1.2; // increase flapping during landing
	    } else {
	        // Normal stamina effect
	        flaps_per_sec *= (0.5 + stamina_factor * 0.5); // 50-100% based on stamina
	    }
	}

	// Optional: even slower when on ground
	if (state == "ground") flaps_per_sec = 0.01;

	// Advance phase using time, not frames
	flap_phase = (flap_phase + flaps_per_sec * dt) % 1;

	// Pick wing frame from phase
	var frames = max(1, wing_frames);
	wing_img   = floor(flap_phase * frames);

    var target_body = clamp(-vsp * body_tilt_scale, body_tilt_min, body_tilt_max);
    body_angle = lerp(body_angle, target_body, 0.12);

    var target_head = body_angle * head_follow_amt + head_bob_offset; // Added head bob
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
	
	// Keep birds in room bounds - check if desired_hsp exists first
	if (variable_instance_exists(id, "desired_hsp")) {
	    if (x < 32)  desired_hsp = abs(desired_hsp);
	    if (x > room_width - 32) desired_hsp = -abs(desired_hsp);
	}
}


function scr_bird_draw() {
    /// ===== BIRD: Draw =====
    var base_ang = 0;
   // shader_hue_start(col);
    
    if (state == "fly" || landing) {
    _draw_bird_part(spr_wing_back, wing_img, off_wing_x, off_wing_y, body_angle + wing_angle,color_body);
	}

    if (state == "ground") {
        // --- BACK WING (behind) - folded wings on ground
       // _draw_bird_part(spr_wing_ground, wing_img, off_wing_x, off_wing_y, body_angle + wing_angle + 90,color_body);
    }
    
    // --- BODY
    _draw_bird_part(spr_body, 0, off_body_x, off_body_y, body_angle,color_body);
    
    // --- TAIL (slightly behind body center)
    _draw_bird_part(spr_tail, 0, off_tail_x, off_tail_y, body_angle + tail_angle,color_body);
    
	if species = "bat" {
		_draw_bird_part(spr_head, 4, off_head_x, off_head_y, head_angle,color_body);
	}
    // --- HEAD
    _draw_bird_part(spr_head, idx_head, off_head_x, off_head_y, head_angle,color_body);
	if species = "bat" {
		_draw_bird_part(spr_head, 3, off_head_x, off_head_y, head_angle,color_body);
	}
    
    // --- EYE (kept simple; could add tiny bob)
    _draw_bird_part(spr_eye, 0, off_eye_x, off_eye_y, head_angle,color_eye);
    
	if (species!="bat") {
	    // --- BEAK (top rotates to "open")
	    var beak_top_ang = head_angle + (beak_open ? beak_open_ang : 0);
	    var beak_btm_ang = head_angle;
	    _draw_bird_part(spr_beak_btm, 0, off_beak_x, off_beak_y, beak_btm_ang,color_beak);
	    _draw_bird_part(spr_beak_top, 0, off_beak_x, off_beak_y, beak_top_ang,color_beak);
	}
    
    // front wing
	if (state == "fly" || landing) {
	    _draw_bird_part(spr_wing_front, wing_img, off_wing_x, off_wing_y, body_angle - wing_angle,color_body);
	}
    if (state == "ground") {
        // --- FRONT WING (in front) - folded wings on ground
		if (dir==1) {
			//_draw_bird_part(spr_wing_front, wing_img, off_wing_x, off_wing_y, body_angle - wing_angle + 90);
			//draw_sprite_ext(spr_wing_ground,wing_img,off_wing_x,scale,-scale,off_wing_y,body_angle-90,color_body,1);
		}
		if (dir==-1) {
			//_draw_bird_part(spr_wing_front, wing_img, off_wing_x, off_wing_y, body_angle - wing_angle);
			//draw_sprite_ext(spr_wing_ground,wing_img,off_wing_x,off_wing_y,image_xscale,-image_yscale,body_angle-90,color_body,1);
		}
		_draw_bird_part(spr_wing_ground, wing_img, off_wing_x, off_wing_y, body_angle + wing_angle,color_body);
    
   }
    
   // shader_reset();
}

/// Returns true if standing on ground
function _is_on_floor(__floor) {
    return place_meeting(x, y + 1, __floor);
}



