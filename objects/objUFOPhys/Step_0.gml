/// objUFOPhys.Step — hover, patrol, clamp to ceiling/ground, fire down

// ---------- ensure scratch vars ----------
if (!variable_instance_exists(self,"fly_goal_t")) fly_goal_t = 0;

// ---------- retarget if needed ----------
if (!instance_exists(target)) {
    target = noone;
    var best_d = 1000000;
    var _types = ["obj_Player1","objHumanPhys","obj_NeonBike_bike"];
    for (var i = 0; i < array_length(_types); i++) {
        var t = asset_get_index(_types[i]);
        if (t != -1) {
            var who = instance_nearest(x, y, t);
            if (instance_exists(who)) {
                var d = point_distance(x, y, who.x, who.y);
                if (d < best_d) { best_d = d; target = who; }
            }
        }
    }
}


// ---------- find floor under us (fallback = room bottom) ----------
var floor_y = room_height;
if (ground_obj != -1) {
    // Note: this relies on the ground object having a mask or bbox.
    // If none, floor_y remains room_height which is still safe.
    var ginst = collision_line(x, y, x, ufo_floor_probe_max, ground_obj, false, true);
    if (ginst != noone) floor_y = ginst.bbox_top;
}

// altitude corridor based on ceiling + local ground
var ceiling_y = ufo_ceiling_margin;
var lower_y   = floor_y - ufo_ground_clearance;

// ---------- desired velocity ----------
var want_vx = 0, want_vy = 0;

if (instance_exists(target)) {
    // hover above target, but clamp to corridor
    var tx = target.x;
    var ty = clamp(target.y - ufo_hover_h, ceiling_y, lower_y);

    var d  = point_distance(x, y, tx, ty);
    var a  = point_direction(x, y, tx, ty);
    var sp = min(ufo_max_spd, max(1, d * 0.08));
    want_vx = lengthdir_x(sp, a);
    want_vy = lengthdir_y(sp, a);
} else {
    // idle patrol around a soft goal
    if (fly_goal_t <= 0) {
        var r   = irandom_range(64, ufo_patrol_r);
        var ang = irandom(359);
        fly_goal_x = x + lengthdir_x(r, ang);
        fly_goal_y = y + lengthdir_y(r, ang);
        fly_goal_t = irandom_range(room_speed, room_speed * 2);
    } else fly_goal_t--;

    var a2 = point_direction(x, y, fly_goal_x, fly_goal_y);
    want_vx = lengthdir_x(ufo_idle_drift, a2);
    want_vy = lengthdir_y(ufo_idle_drift, a2);
}

// ---------- steer + floatiness ----------
hsp = lerp(hsp, want_vx, ufo_accel);
vsp = lerp(vsp, want_vy, ufo_accel);

hsp *= (1 - ufo_drag);
vsp *= (1 - ufo_drag);

// soft push back into corridor (feels floaty, avoids hard clamps)
var y_cur = variable_instance_exists(self,"phy_position_y") ? phy_position_y : y;
if (y_cur < ceiling_y) vsp = max(vsp, 0) + 0.6;
if (y_cur > lower_y)   vsp = min(vsp, 0) - 0.6;

// ---------- integrate (supports both non-physics and physics bodies) ----------
var has_phy = variable_instance_exists(self,"phy_position_x");
if (has_phy) {
  //  phy_position_x += hsp;
  //  phy_position_y  = clamp(phy_position_y + vsp, ceiling_y, lower_y);
} else {
    x += hsp;
    y  = clamp(y + vsp, ceiling_y, lower_y);
}

// ---------- animate rings (draw uses spin_angle) ----------
spin_angle += hsp * 0.5;
if (spin_angle >= 360 || spin_angle <= -360) spin_angle = 0;

// ---------- fire straight down when roughly aligned ----------
if (ufo_fire_cd > 0) ufo_fire_cd--;
if (instance_exists(target)) {
    var aligned = (abs(target.x - x) <= ufo_fire_width);
  //  var under   = (target.y > (variable_instance_exists(self,"phy_position_y") ? phy_position_y : y) + 6);
    if (aligned && /*under &&*/ ufo_fire_cd <= 0) {
        var bx = x;
        var by = (variable_instance_exists(self,"phy_position_y") ? phy_position_y : y) + ufo_muzzle_ofs;

        // bullet object fallback: prefer objBullet_Human, else objBullet
        var bobj = asset_get_index("objBullet_Human");
        if (bobj == -1) bobj = asset_get_index("objBullet");
        if (bobj != -1) {
            var b = instance_create_layer(bx, by, layer, bobj);
            b.direction = 270;
            b.speed     = 12;
            b.owner     = id;
        }

        ufo_fire_cd = ufo_fire_interval;
    }
}
