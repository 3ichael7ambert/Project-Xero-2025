function scr_player_ball_init(){
	// --- Mode 4 config ---
#macro JP4_STATE_IDLE      0
#macro JP4_STATE_ROLL      1   // 2D spin / morph ball roll (ground/air)
#macro JP4_STATE_CHARGE    2   // charging a directional smash
#macro JP4_STATE_SLAM      3   // released charge; dashing/slamming
#macro JP4_STATE_HOMING    4   // short homing burst toward nearest enemy

jp4_state          = JP4_STATE_IDLE;
jp4_roll_speed     = 8;     // base roll speed on ground
jp4_air_control    = 0.4;   // air WASD influence during roll
jp4_grav           = 0.6;   // gravity in mode 4
jp4_fric_ground    = 0.85;  // friction when rolling on ground
jp4_fric_air       = 0.98;  // air drag while rolling
jp4_charge         = 0;
jp4_charge_max     = 40;    // frames; tune feel
jp4_charge_rate    = 1.2;   // per step
jp4_slam_speed_min = 10;
jp4_slam_speed_max = 26;
jp4_slam_up_bias   = 0.25;  // mixes some upward into oblique slams
jp4_bounce_coef    = 0.55;  // how much speed returns on bounce
jp4_bounce_bonus   = 0.02;  // extra bounce per unit of impact |vsp| + charge
jp4_squash_time    = 9;     // frames for squash recovery
jp4_squash_amt_max = 0.35;  // max additional squash from impact

jp4_homing_range   = 420;   // px to seek a target
jp4_homing_speed   = 20;
jp4_homing_time    = 12;    // frames burst lasts
jp4_homing_t       = 0;

// transient fx
jp4_squash_t = 0;
jp4_squash_x = 1;
jp4_squash_y = 1;

// input (reuse your existing buttons if you want)
btn_charge   = mb_left;     // hold to charge, release to slam
btn_rollTap  = vk_shift;    // tap to toggle roll state quickly
btn_homing   = vk_space;    // press in air during roll to homing burst

// circular collider for roll (optional: swap mask for cleaner corners)
sprMaskBall  = sprXeroBlank; // put a ~circular mask here; else we keep your dyn bbox


}

function _jp4_start_roll() {
    jp4_state = JP4_STATE_ROLL;
    // kick horizontal based on facing or input
    var dir = facing_right ? 0 : 180;
    if (move_left)  dir = 180;
    if (move_right) dir = 0;
    hsp = jp4_roll_speed * dcos(dir);
    image_angle += sign(hsp) * 12; // visual spin
}

function _jp4_start_charge() {
    jp4_state  = JP4_STATE_CHARGE;
    jp4_charge = 0;
}

function _jp4_release_slam() {
    jp4_state = JP4_STATE_SLAM;

    // pick direction: stick/mouse aim first, else WASD, else facing
    var dir = armF_dir; // you already compute this toward mouse or stick
    if (!mouse_aim && gamepad==false) {
        if (move_up   && move_left)  dir = 135;
        else if (move_up   && move_right) dir = 45;
        else if (move_down && move_left)  dir = 225;
        else if (move_down && move_right) dir = 315;
        else if (move_up)    dir = 270;
        else if (move_down)  dir = 90;
        else if (move_left)  dir = 180;
        else if (move_right) dir = 0;
        else dir = facing_right ? 0 : 180;
    }

    var t = clamp(jp4_charge / jp4_charge_max, 0, 1);
    var slam_spd = lerp(jp4_slam_speed_min, jp4_slam_speed_max, t);

    // give it a touch of upward bias so diagonals feel good
    var vx = lengthdir_x(slam_spd, dir);
    var vy = lengthdir_y(slam_spd, dir);
    if (vy > 0) vy = lerp(vy, -abs(vy)*jp4_slam_up_bias, t); // bias down slams upward a bit

    hsp = vx;
    vsp = vy;

    // quick visual squash stretch at the moment of takeoff
    _jp4_squash(1.0 - 0.18, 1.0 + 0.18, jp4_squash_time);
}

function _jp4_try_homing() {
    // find nearest enemy in range
    if (instance_exists(objEnemyParent)) {
        var tgt = instance_nearest(x, y, objEnemyParent);
        if (tgt != noone && point_distance(x,y,tgt.x,tgt.y) <= jp4_homing_range) {
            jp4_state   = JP4_STATE_HOMING;
            jp4_homing_t = jp4_homing_time;
            var dir = point_direction(x,y,tgt.x,tgt.y);
            hsp = lengthdir_x(jp4_homing_speed, dir);
            vsp = lengthdir_y(jp4_homing_speed, dir);
            _jp4_squash(1.0 - 0.1, 1.0 + 0.1, jp4_squash_time);
        }
    }
}

function _jp4_squash(xscale, yscale, frames) {
    jp4_squash_x = xscale;
    jp4_squash_y = yscale;
    jp4_squash_t = frames;
}

function _jp4_bounce_from_impact(_impact_v) {
    // _impact_v is positive; higher = harder smash
    var bonus = _impact_v * jp4_bounce_bonus + (jp4_charge / jp4_charge_max) * 2.5;
    var up = max(jp4_bounce_coef * _impact_v + bonus, 4);
    vsp = -min(up, jp4_slam_speed_max + 6);
    // horizontal retain a bit
    hsp *= 0.9;
    // squash on bounce (squash x, stretch y)
    var amt = clamp((_impact_v/18.0), 0, jp4_squash_amt_max);
    _jp4_squash(1.0 + amt, 1.0 - amt, jp4_squash_time);
}
