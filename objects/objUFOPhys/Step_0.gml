/// objUFOPhys.Step
/*
// late-bind after controller creates physics world
if (waiting_bind && physics_world_exists()) {
    physics_fixture_bind(fixture_idx, id);
    physics_fixture_delete(fixture_idx);
    waiting_bind = false;
    phy_bullet    = true;
    phy_kinematic = true;
}

// acquire/validate target
if (!instance_exists(target)) {
    target = noone;
    var best_d = 1e30;
    for (var i = 0; i < array_length(target_types); i++) {
        var who = instance_nearest(x, y, target_types[i]);
        if (instance_exists(who)) {
            var d = point_distance(x, y, who.x, who.y);
            if (d < best_d) { best_d = d; target = who; }
        }
    }
}

// ground under UFO (room-height fallback)
var floor_y = room_height;
if (ground_obj != -1) {
    var ginst = collision_line(x, y, x, floor_probe_max, ground_obj, false, true);
    if (ginst != noone) floor_y = ginst.bbox_top;
}
var lower_y = floor_y - ground_clearance;

// desired velocity
var want_vx = 0, want_vy = 0;
if (instance_exists(target)) {
    var tx = target.x;
    var ty = clamp(target.y - hover_height, ceiling_y, lower_y);
    var d  = point_distance(x, y, tx, ty);
    var a  = point_direction(x, y, tx, ty);
    var sp = min(max_spd, max(1, d * 0.08));
    want_vx = lengthdir_x(sp, a);
    want_vy = lengthdir_y(sp, a);
} else {
    if (fly_goal_t <= 0) {
        var r   = irandom_range(64, patrol_radius);
        var ang = irandom(359);
        fly_goal_x = x + lengthdir_x(r, ang);
        fly_goal_y = y + lengthdir_y(r, ang);
        fly_goal_t = irandom_range(room_speed, room_speed * 2);
    } else fly_goal_t--;
    var a2 = point_direction(x, y, fly_goal_x, fly_goal_y);
    want_vx = lengthdir_x(2.0, a2);
    want_vy = lengthdir_y(2.0, a2);
}

// steering
hsp = lerp(hsp, want_vx, steer);
vsp = lerp(vsp, want_vy, steer);
hsp *= (1 - drag);
vsp *= (1 - drag);

// push into corridor
var y_cur = variable_instance_exists(self,"phy_position_y") ? phy_position_y : y;
if (y_cur < ceiling_y) vsp = max(vsp, 0) + 0.6;
if (y_cur > lower_y)   vsp = min(vsp, 0) - 0.6;

// kinematic move (safe if not bound yet)
var has_phy = variable_instance_exists(self,"phy_position_x");
if (has_phy) {
    phy_position_x += hsp;
    phy_position_y  = clamp(phy_position_y + vsp, ceiling_y, lower_y);
} else {
    x += hsp;
    y  = clamp(y + vsp, ceiling_y, lower_y);
}

// fire straight down when aligned
if (fire_cd > 0) fire_cd--;
if (instance_exists(target)) {
    var aligned = (abs(target.x - x) <= fire_width);
    var under   = (target.y > y + 6);
    if (aligned && under && fire_cd <= 0) {
        var bx = x;
        var by = y + muzzle_ofs;
        var b  = instance_create_layer(bx, by, layer, objBullet);
        b.direction = 270;
        b.speed     = 12;
        b.owner     = id;
        fire_cd = fire_interval;
    }
}
