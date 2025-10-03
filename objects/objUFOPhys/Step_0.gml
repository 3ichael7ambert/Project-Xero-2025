/// objUFOPhys.Step — KINEMATIC hover follower (like objHumanPhys.Begin Step)

// 0) keep physics from fighting us if this instance has a fixture
var has_phy = variable_instance_exists(self, "phy_position_x");
if (has_phy) {
    phy_gravity_scale  = 0;
    phy_fixed_rotation = true;
    phy_awake          = true;
}

// 1) pick a target (nearest of these types)
if (!instance_exists(target)) {
    target = noone;
    var best_d = 1000000;
    var _types = ["obj_NeonBike_bike","obj_Player1","objHumanPhys"]; // bike preferred
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
    if (!instance_exists(target)) exit;
}

// 2) tunables (mirrors your working human script style)
var HOVER_ABOVE_TARGET = 1560;  // stay this much higher than the target (smaller y)
var FLOOR_CLEARANCE    = 1460;  // minimum distance above floor
var TOP_MARGIN         = -280;  // keep off very top (smaller y = higher)
var TRAIL_X            = 320;   // hover offset left/right of target
var FLOOR_PROBE_MAX    = 4000;  // how far down to scan for floor

// 3) helper: floor probe using current position basis (phy or normal)
function _floor_y_below(_x, _y, _max) {
    var yy = _y, step = 8, lim = min(room_height - 2, _y + max(96, _max));
    while (yy <= lim) {
        if (position_meeting(_x, yy, obj_Floor_bike)) return yy;
        yy += step;
    }
    return -1;
}

// use same coordinate basis throughout this step
var px = has_phy ? phy_position_x : x;
var py = has_phy ? phy_position_y : y;

// 4) compute desired hover point relative to target, clamped to floor & top
var floorY = _floor_y_below(px, py, FLOOR_PROBE_MAX);

var want_y = target.y - HOVER_ABOVE_TARGET;              // higher = smaller y
if (floorY >= 0) want_y = min(want_y, floorY - FLOOR_CLEARANCE);
want_y = max(TOP_MARGIN, want_y);

var want_x = (px <= target.x) ? (target.x - TRAIL_X) : (target.x + TRAIL_X);

// 5) distance-based step sizes (farther = bigger steps)
function _step_curve(_gap, _lo, _hi, _denom) {
    return lerp(_lo, _hi, clamp(_gap / _denom, 0, 1));
}
var gapX  = abs(want_x - px);
var gapY  = abs(want_y - py);
var stepX = _step_curve(gapX, 6, 30, 800);
var stepY = _step_curve(gapY, 4, 20, 500);

// 6) next kinematic position
var nx = px + clamp(want_x - px, -stepX, stepX);
var ny = py + clamp(want_y - py, -stepY, stepY);

// safety: never enter floor band; keep off top
if (floorY >= 0) ny = min(ny, floorY - FLOOR_CLEARANCE);
ny = max(TOP_MARGIN, ny);

// 7) apply position (physics body or not)
if (has_phy) {
    phy_position_x = nx;
    phy_position_y = ny;
    // kill drift so it doesn’t undo our kinematic placement
    phy_linear_velocity_x = 0;
    phy_linear_velocity_y = 0;
} else {
    x = nx;
    y = ny;
}

// 8) stable facing + downward aim (35–55°)
if (!variable_instance_exists(id,"facing"))   facing  = 1;
if (!variable_instance_exists(id,"_face_cd")) _face_cd = 0;
_face_cd = max(0, _face_cd - 1);

var want_face = (target.x >= nx) ? 1 : -1;
if (facing != want_face && _face_cd == 0 && abs(nx - px) > 0.3) {
    facing   = want_face;
    _face_cd = 6;
}
var sc = variable_instance_exists(id,"scale") ? scale : 1;
image_xscale = facing * max(0.001, sc);

// aim 35–55° downward relative to facing
var base = (facing == 1) ? 0 : 180;
var raw  = point_direction(nx, ny, target.x, target.y);
var diff = ((raw - base + 540) mod 360) - 180;
aim_ang  = base + clamp(diff, 35, 55);

// 9) cosmetics
if (variable_instance_exists(id,"walk_cycle"))
    walk_cycle = lerp(walk_cycle, 0, 0.25);
if (variable_instance_exists(id,"jet_on"))
    jet_on = false;

// (Optional) fire straight down when roughly aligned — uncomment to enable
/*
if (!variable_instance_exists(id,"ufo_fire_cd")) ufo_fire_cd = 0;
var ufo_fire_interval = room_speed;  // 1s
var ufo_fire_width    = 28;
var ufo_muzzle_ofs    = 16;

if (ufo_fire_cd > 0) ufo_fire_cd--;
if (abs(target.x - nx) <= ufo_fire_width && ufo_fire_cd <= 0) {
    var bobj = asset_get_index("objBullet_Human"); if (bobj == -1) bobj = asset_get_index("objBullet");
    if (bobj != -1) {
        var b = instance_create_layer(nx, ny + ufo_muzzle_ofs, layer, bobj);
        b.direction = 270; b.speed = 12; b.owner = id;
    }
    ufo_fire_cd = ufo_fire_interval;
}
*/
