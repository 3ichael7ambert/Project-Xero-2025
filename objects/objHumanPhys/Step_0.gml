/// objHumanPhys.Begin Step — KINEMATIC physics hover follower (no shooting)

// Keep physics from fighting us
phy_gravity_scale  = 0;
phy_fixed_rotation = true;
phy_awake          = true;

// Acquire the bike target
if (!instance_exists(target) || target.object_index != obj_NeonBike_bike) {
    target = instance_nearest(x, y, obj_NeonBike_bike);
    if (!instance_exists(target)) exit;
}

// --- Tunables (feel free to tweak) ---
var HOVER_ABOVE_PLAYER = 1560;   // stay this much higher than player (smaller y)
var FLOOR_CLEARANCE    = 1460;   // minimum distance above floor
var TOP_MARGIN         = -280;    // keep off top of room
var TRAIL_X            = 320;   // hover offset left/right of player

// Floor probe straight down from our current x
function _floor_y_below(_x, _y, _max) {
    var yy = _y, step = 8, lim = min(room_height - 2, _y + max(96, _max));
    while (yy <= lim) { if (position_meeting(_x, yy, obj_Floor_bike)) return yy; yy += step; }
    return -1;
}
var floorY = _floor_y_below(phy_position_x, phy_position_y, 4000);

// Desired position
var want_y = target.y - HOVER_ABOVE_PLAYER;
if (floorY >= 0) want_y = min(want_y, floorY - FLOOR_CLEARANCE);
want_y = max(TOP_MARGIN, want_y);

var want_x = (phy_position_x <= target.x) ? (target.x - TRAIL_X) : (target.x + TRAIL_X);

// Distance-based step size (farther = faster)
function _step_curve(gap, lo, hi, denom) { return lerp(lo, hi, clamp(gap/denom, 0, 1)); }
var gapX  = abs(want_x - phy_position_x);
var gapY  = abs(want_y - phy_position_y);
var stepX = _step_curve(gapX, 6, 30, 800);
var stepY = _step_curve(gapY, 4, 20, 500);

// Next kinematic position
var nx = phy_position_x + clamp(want_x - phy_position_x, -stepX, stepX);
var ny = phy_position_y + clamp(want_y - phy_position_y, -stepY, stepY);

// Safety clamps
if (floorY >= 0) ny = min(ny, floorY - FLOOR_CLEARANCE);
ny = max(TOP_MARGIN, ny);

// *** Apply by writing to physics position (no physics_set_transform) ***
phy_position_x = nx;
phy_position_y = ny;
// stop residual drift so we don't slowly slide
phy_linear_velocity_x = 0;
phy_linear_velocity_y = 0;

// Stable facing + downward aim (35–55°)
if (!variable_instance_exists(id,"facing"))  facing  = 1;
if (!variable_instance_exists(id,"_face_cd")) _face_cd = 0;
_face_cd = max(0, _face_cd - 1);
var want_face = (target.x >= phy_position_x) ? 1 : -1;
if (facing != want_face && _face_cd == 0 && abs(nx - phy_position_x) > 0.3) { facing = want_face; _face_cd = 6; }
image_xscale = facing * (variable_instance_exists(id,"scale") ? scale : 1);

var base = (facing == 1) ? 0 : 180;
var raw  = point_direction(phy_position_x, phy_position_y, target.x, target.y);
var diff = ((raw - base + 540) mod 360) - 180;
aim_ang  = base + clamp(diff, 35, 55);

// cosmetics
jet_on = false;
walk_cycle = lerp(walk_cycle, 0, 0.25);
