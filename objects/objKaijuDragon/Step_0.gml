/// objKaijuDragon : Step

if (dead) exit;

/// @function angle_lerp(a, b, amt)
/// @desc Interpolates from angle a → b with proper wraparound (0–360).
function angle_lerp(a, b, amt) {
    var diff = angle_difference(b, a);
    return a + diff * amt;
}


// Resolve a target (player) if nearby
if (!instance_exists(target)) {
    var p = instance_nearest(x, y, obj_Player1);
    if (instance_exists(p) && point_distance(x, y, p.x, p.y) <= aggro_rad) {
        target = p; provoked = true;
    }
}

// Wander + soft seek
t++;

var seek_strength = provoked ? 0.8 : 0.35;
var wander        = wander_mag * dsin(t * wander_freq * 360);
var desired_dir   = dir_deg;

// If we have a target, bias toward them
if (instance_exists(target)) {
    var to_tgt = point_direction(x, y, target.x, target.y);
    desired_dir = angle_lerp(dir_deg, to_tgt, seek_strength);
} else {
    // drift toward preferred altitude centerline
    var alt_bias = clamp((altitude - y) * 0.02, -15, 15);
    desired_dir = dir_deg + alt_bias;
}

// Add wandering “serpent” noise
desired_dir += wander;

// Turn toward desired
var diff = angle_difference(desired_dir, dir_deg);
dir_deg += clamp(diff, -turn_rate, turn_rate);

// Speed up if provoked
var spd = provoked ? speed_boost : speed_base;

// Head velocity
vx = lengthdir_x(spd, dir_deg);
vy = lengthdir_y(spd, dir_deg);

// Keep inside soft city bounds (bounce steering)
if (x < city_min_x) dir_deg = 0 + irandom_range(-10,10);
if (x > city_max_x) dir_deg = 180 + irandom_range(-10,10);
if (y < city_min_y) dir_deg += 6;
if (y > city_max_y) dir_deg -= 6;

// Move head (segment 0 is head)
x += vx;
y += vy;
seg_x[0] = x;
seg_y[0] = y;
seg_a[0] = dir_deg;

// Body follow-the-leader with undulation
var phase = t * und_speed;
for (var i = 1; i < seg_count; i++) {
    var px = seg_x[i-1];
    var py = seg_y[i-1];
    var cx = seg_x[i];
    var cy = seg_y[i];

    // Aim current knot toward previous
    var a_to_prev = point_direction(cx, cy, px, py);
    var dist      = point_distance(cx, cy, px, py);

    // pull to desired spacing
    var pull = dist - seg_spacing;
    cx += lengthdir_x(pull, a_to_prev);
    cy += lengthdir_y(pull, a_to_prev);

    // Lateral wave (normal to segment)
    var normal = a_to_prev + 90;
    var wave   = und_amp * dsin(phase + i * und_step);
    cx += lengthdir_x(wave * 0.10, normal); // gentle to avoid exploding

    // Damping
    cx = lerp(cx, px - lengthdir_x(seg_spacing, a_to_prev), 0.35);
    cy = lerp(cy, py - lengthdir_y(seg_spacing, a_to_prev), 0.35);

    // Commit
    seg_x[i] = cx;
    seg_y[i] = cy;
    seg_a[i] = a_to_prev;
}
/*
// Simple “breath” trigger if close
if (provoked && instance_exists(target)) {
    var d = poi
