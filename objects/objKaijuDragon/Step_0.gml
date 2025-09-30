/// objKaijuDragon : Step
if (dead) exit;

// ---------- 0) Target acquisition ----------
if (!instance_exists(target)) {
    var p = instance_nearest(x, y, obj_Player1);
    if (instance_exists(p) && point_distance(x, y, p.x, p.y) <= aggro_rad) {
        target   = p;
        provoked = true;
    }
}

// ---------- 1) Steering “intent” (dir_deg is the head’s facing) ----------
// Tunables (feel free to move these to Create once dialed)
var SEEK_GAIN      = provoked ? 0.90 : 0.40;  // how strongly we heed seek when provoked/idle
var WANDER_GAIN    = 0.35;                    // weight of wander vs seek
var ALT_GAIN       = 0.018;                   // bias toward preferred altitude
var BOUND_GAIN     = 0.65;                    // how hard to push off edges
var TURN_RATE_MAX  = turn_rate;               // deg/step clamp
var SPEED          = provoked ? speed_boost : speed_base;

// --- 1a) Wander: a smooth random-walk, not a sine (prevents tight circles)
if (!variable_instance_exists(self, "wander_heading")) {
    wander_heading = dir_deg;               // current wander target heading
    wander_timer   = irandom_range(45,120); // steps until we pick a new heading
}
wander_timer--;
if (wander_timer <= 0) {
    wander_timer   = irandom_range(45,120);
    // choose a new wander target within a cone around current heading
    var cone = 42; // deg
    wander_heading = dir_deg + irandom_range(-cone, cone);
}
// drift toward wander_heading slowly
var wander_dir = angle_lerp(dir_deg, wander_heading, 0.05);

// --- 1b) Seek/pursuit if provoked
var seek_dir = dir_deg;
if (instance_exists(target)) {
    // simple predictive lead
    var lead = 10; // frames lookahead (tweak)
    var tx = target.x, ty = target.y;
    if (variable_instance_exists(target, "hsp")) tx += target.hsp * lead;
    if (variable_instance_exists(target, "vsp")) ty += target.vsp * lead;
    seek_dir = point_direction(x, y, tx, ty);
}

// --- 1c) Altitude bias (keeps general vertical band)
var alt_bias = clamp((altitude - y) * ALT_GAIN, -12, 12); // small degrees

// --- 1d) Boundary repulsion (push away stronger the closer we get)
var push = 0;
{
    var pad = 220; // start pushing this many px before the edge
    if (x < city_min_x + pad) push += ( (city_min_x + pad) - x) / pad * 60;   // push right
    if (x > city_max_x - pad) push -= ( x - (city_max_x - pad)) / pad * 60;   // push left
    if (y < city_min_y + pad) alt_bias += 6;
    if (y > city_max_y - pad) alt_bias -= 6;
}
push *= BOUND_GAIN;

// --- 1e) Final desired heading: blend seek and wander, add small corrections
var desired_dir = angle_lerp(dir_deg, seek_dir, SEEK_GAIN);
desired_dir     = angle_lerp(desired_dir, wander_dir, WANDER_GAIN);
desired_dir    += alt_bias + push;

// --- 1f) Turn toward desired with clamp
var diff = angle_difference(desired_dir, dir_deg);
diff = clamp(diff, -TURN_RATE_MAX, TURN_RATE_MAX);
dir_deg += diff;

// --- 1g) Advance head
var spd = SPEED;
vx = lengthdir_x(spd, dir_deg);
vy = lengthdir_y(spd, dir_deg);

// Soft keep-in-bounds (optional nudge to avoid sticking)
if (x < city_min_x) dir_deg = 0;
if (x > city_max_x) dir_deg = 180;

x += vx;
y += vy;

// ---------- 2) Segment follow + undulation + roll (keeps your values) ----------
// ---------- 2) Segment follow + undulation + roll (gap-free) ----------
seg_x[0] = x;
seg_y[0] = y;
seg_a[0] = dir_deg;

t++; // timebase for undulation
var phase = t * und_speed;

for (var i = 1; i < seg_count; i++) {
    var px = seg_x[i-1];
    var py = seg_y[i-1];

    // 1) Base: place exactly seg_spacing behind parent along current link angle
    var ang_to_prev = point_direction(seg_x[i], seg_y[i], px, py);
    var base_x = px - lengthdir_x(seg_spacing, ang_to_prev);
    var base_y = py - lengthdir_y(seg_spacing, ang_to_prev);

    // 2) Lateral undulation in the link's local normal
    var normal = ang_to_prev + 90;
    var wave   = und_amp * dsin(phase + i * und_step);

    // Optional: reduce wave when turning sharply (prevents overshoot in tight bends)
    var turn_sharpness = abs(angle_difference(ang_to_prev, seg_a[i-1])); // 0..180
    var wave_scale = 1 - clamp(turn_sharpness / 90, 0, 1) * 0.6;
    wave *= wave_scale;

    var ox = lengthdir_x(wave * 0.10, normal);
    var oy = lengthdir_y(wave * 0.10, normal);

    var cx = base_x + ox;
    var cy = base_y + oy;

    // 3) Re-constrain: ensure exact distance from parent after offset
    //    (slides the point on the circle of radius seg_spacing around the parent)
    var vx = cx - px;
    var vy = cy - py;
    var vd = max(0.0001, sqrt(vx*vx + vy*vy));
    var scale_back = seg_spacing / vd;
    cx = px + vx * scale_back;
    cy = py + vy * scale_back;

    // Commit position and angle
    seg_x[i] = cx;
    seg_y[i] = cy;
    seg_a[i] = point_direction(cx, cy, px, py);

    // ---- roll / twist (unchanged) ----
    var a_prev  = seg_a_prev[i];
    var a_diff  = angle_difference(seg_a[i], a_prev);
    var noise   = roll_noise_amp * dsin((t + i * 13) * roll_noise_freq * 360);
    var torque  = a_diff * roll_from_turn + noise;

    var parent_roll = seg_roll[i-1];
    seg_roll[i] = lerp(seg_roll[i], parent_roll, roll_follow);
    seg_roll[i] = (seg_roll[i] + torque) * roll_decay;

    seg_a_prev[i] = seg_a[i];
}


// ---------- 3) Breath / roar (unchanged logic; optional) ----------
if (provoked && instance_exists(target)) {
    var d = point_distance(x, y, target.x, target.y);
    breath_cd--;
    if (d < 280 && breath_cd <= 0) {
        breath_cd = irandom_range(60, 120);
        with (instance_create(x, y, objBullet_Kaiju)) {
            dir  = other.dir_deg;
            spd  = 7;
            dmg  = 20;
            range= 380;
        }
    }
}

roar_cd--;
if (provoked && roar_cd <= 0) {
    roar_cd = irandom_range(200, 340);
    // audio_play_sound(sndDragonRoar, 0, false);
    // camera shake hook
}

// ---------- 4) Death hook ----------
if (hp <= 0) { dead = true; event_user(0); instance_destroy(); }
