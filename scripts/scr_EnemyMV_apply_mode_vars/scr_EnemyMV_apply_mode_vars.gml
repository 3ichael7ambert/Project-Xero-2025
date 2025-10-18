/// scr_EnemyMV_apply_mode_vars()
/// Initialize per-mode tunables for objEnemy_mv based on current `mode`.

function scr_EnemyMV_apply_mode_vars() {
/// common defaults (safe baseline)
spin_spd = 12; drop_acc = 0.9;
jump_spd = -7.5; hop_cool = 36; hop_timer = irandom(hop_cool); run_spd = 2.4;
max_spd = 3.2; accel = 0.18; drift_bias = 0.06;
crawl_spd = 2.3; switch_cd = 90; switch_timer = irandom(switch_cd); grav_dir = choose(-1,1);
patrol_spd = 1.2; fire_timer = irandom_range(30,90); projectile_spd = 7; use_laser = false; faces_up = choose(true,false);

switch (mode) {
    case ENEMY_MV_MODE.SKY_DRILL:
        vsp = 0;
        break;

    case ENEMY_MV_MODE.LAVA_BALL:
        if (!variable_instance_exists(self,"lava_dir")) lava_dir = 1; // +1 from bottom, -1 from top
        var launch_spd = (lava_dir == 1) ? -8.5 : 8.5;  // negative goes up
        vsp  = launch_spd;
        grav = 0.45 * sign(-launch_spd);               // pull back after arc
        break;

    case ENEMY_MV_MODE.BOUNCER_CHASE:
        // jump_spd, hop_cool, hop_timer, run_spd already set
        grav = 0.45;
        break;

    case ENEMY_MV_MODE.HOMER_STRAIGHT:
        max_spd = 3.4; accel = 0.22;
        break;

    case ENEMY_MV_MODE.HOMER_DRIFT:
        max_spd = 3.1; accel = 0.12; drift_bias = 0.06;
        break;

    case ENEMY_MV_MODE.GRAV_SWITCHER:
        // crawl_spd, switch_cd/timer, grav_dir already set
        break;

    case ENEMY_MV_MODE.POT_TURRET:
        // patrol_spd, fire_timer, projectile_spd, use_laser, faces_up already set
        image_angle = faces_up ? 0 : 180;
        break;
}
mode_inited = true;
}