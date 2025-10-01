/// objHumanPhys.Step
// --- INPUT (swap out for AI later) ---
_left  = noone;//keyboard_check(vk_left)  || keyboard_check(ord("A"));
_right = noone;//keyboard_check(vk_right) || keyboard_check(ord("D"));
_jump  = noone;//keyboard_check_pressed(vk_space);   // tap to jump
_jet   = noone;//keyboard_check(vk_space);           // hold to jet

// Replace these 3 lines in objHumanPhys.Step:
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);


// With this:
var mx = device_mouse_x(0);
var my = device_mouse_y(0);


aim_ang = point_direction(x, y + shoulder_ofs.y, mx, my);
facing  = (cos(degtorad(aim_ang)) >= 0) ? 1 : -1;  // face towards aim unless moving strongly

// --- GROUND CHECK ---
// Simple: raycast a short line down to look for your ground collider object (e.g., objSidewalk/objSolidGround)
var g = collision_line(x, y + 12, x, y + 16, obj_Floor_bike, false, true);
on_ground = (g != noone);

// --- HORIZONTAL MOVE ---
var vx = phy_linear_velocity_x;
var vy = phy_linear_velocity_y;
var ax = 0;

if (on_ground) {
    if (_left)  ax -= move_accel_gnd;
    if (_right) ax += move_accel_gnd;
} else {
    if (_left)  ax -= move_accel_air;
    if (_right) ax += move_accel_air;
}

// speed leash
if (abs(vx) > max_run_speed) {
    ax += -sign(vx) * 6000; // bleed excess
}

physics_apply_force(x, y, ax, 0);

// walk cycle (for legs draw only)
var moving = abs(vx) > 0.6;
if (moving && on_ground) {
    walk_cycle = (walk_cycle + clamp(abs(vx) / max_run_speed, 0.4, 1.2)) mod 360;
} else {
    // decay to neutral when idle/air
    walk_cycle = lerp(walk_cycle, 0, 0.2);
}

// --- JUMP ---
if (_jump && on_ground) {
    physics_apply_impulse(x, y, 0, -jump_impulse);
}

// --- JETPACK ---
jet_on = false;
if (_jet && fuel > 0) {
    var side = (_right - _left) * jet_thrust_side;
    physics_apply_force(x, y, side, -jet_thrust_up);
    fuel = max(0, fuel - fuel_burn_rate);
    jet_on = true;
} else if (on_ground) {
    fuel = min(fuel_max, fuel + fuel_recharge);
}

// --- FIRE ---
if (fire_cd > 0) fire_cd--;
if (has_gun && mouse_check_button(mb_left) && fire_cd <= 0) {
    var sx = x + (shoulder_ofs.x * facing);
    var sy = y +  shoulder_ofs.y;
    var bx = sx + lengthdir_x(16, aim_ang);
    var by = sy + lengthdir_y(16, aim_ang);

    var b = instance_create_layer(bx, by, layer, objBullet);
    b.direction = aim_ang;
    b.speed     = bullet_speed;
    b.owner     = id;

    // tiny recoil
    var rx = -lengthdir_x(recoil_impulse, aim_ang);
    var ry = -lengthdir_y(recoil_impulse, aim_ang);
    physics_apply_impulse(x, y, rx, ry);

    fire_cd = fire_interval;
}
