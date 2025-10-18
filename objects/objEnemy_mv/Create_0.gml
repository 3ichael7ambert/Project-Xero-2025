/// enum for objEnemy_mv modes
enum ENEMY_MV_MODE {
    SKY_DRILL = 0,          // drills from ceiling downward
    LAVA_BALL = 1,          // shoots up from lava (or down from ceiling) then falls off-screen
    BOUNCER_CHASE = 2,      // goo-like jumper that hops toward player
    HOMER_STRAIGHT = 3,     // boo-like, flies directly at player
    HOMER_DRIFT = 4,        // boo-like, drifts/homes loosely (not straight)
    GRAV_SWITCHER = 5,      // swaps gravity, crawls floor/ceiling
    POT_TURRET = 6          // 4-legged pot w/ cannon head (projectile or eye laser)
}



/// objEnemy_mv.Create

// ---- base stats (director will scale these on spawn) ----
/// objEnemy_mv.Create
if (!variable_instance_exists(self,"hp"))         hp = 24;   hp_base = hp;
if (!variable_instance_exists(self,"move_spd"))   move_spd = 2.6; move_spd_base = move_spd;
if (!variable_instance_exists(self,"damage"))     damage = 3;     damage_base = damage;
if (!variable_instance_exists(self,"fire_delay")) fire_delay = 60; fire_delay_base = fire_delay;
if (!variable_instance_exists(self,"min_fire_delay")) min_fire_delay = 10;

elite = false; image_blend = c_white; scale = 1;
hsp = 0; vsp = 0; grav = 0.45; state = 0; t = 0;
if (!variable_instance_exists(self,"mode")) mode = irandom_range(0, 6);
mode_inited = false;

// Apply mode vars now (will re-apply if director changes `mode` afterwards)
scr_EnemyMV_apply_mode_vars();

scale = .5;
image_xscale=scale;
image_yscale=scale;
elite       = false;
image_blend = c_white;

// ---- mode select (director can set `mode` before/after creation) ----
if (!variable_instance_exists(self, "mode")) mode = irandom_range(0, 6);

// ---- common movement vars (non-physics) ----
hsp = 0; vsp = 0;
grav = 0.45;         // default gravity if used
grav_dir = 1;        // +1 = down to floor, -1 = up to ceiling
state = 0;           // simple state var per-mode
t    = 0;            // general timer

// ---- per-mode tunables ----
switch (mode) {
    case ENEMY_MV_MODE.SKY_DRILL:
        image_angle = irandom(359);
        spin_spd    = 12;           // degrees per step
        drop_acc    = 0.9;          // accelerate as it drops
        vsp         = 0;
        break;

    case ENEMY_MV_MODE.LAVA_BALL:
        // Launch direction: +1=from bottom up, -1=from top down (director can set `lava_dir`)
        if (!variable_instance_exists(self,"lava_dir")) lava_dir = 1;
        launch_spd  = (lava_dir == 1) ? -8.5 : 8.5;  // negative goes up
        vsp         = launch_spd;
        grav        = 0.45 * sign(-launch_spd);      // gravity opposes initial direction so it comes back
        break;

    case ENEMY_MV_MODE.BOUNCER_CHASE:
        jump_spd    = -7.5;
        hop_cool    = 36;    // frames between hops on ground
        hop_timer   = irandom(hop_cool);
        run_spd     = 2.4;
        break;

    case ENEMY_MV_MODE.HOMER_STRAIGHT:
        max_spd     = 3.4;
        accel       = 0.22;
        break;

    case ENEMY_MV_MODE.HOMER_DRIFT:
        max_spd     = 3.1;
        accel       = 0.12;
        drift_bias  = 0.06; // how much to lerp target toward current vel
        break;

    case ENEMY_MV_MODE.GRAV_SWITCHER:
        crawl_spd    = 2.3;
        switch_cd    = 90;   // min frames between gravity flips
        switch_timer = irandom(switch_cd);
        grav_dir     = choose(-1, 1);  // start on ceiling or floor
        break;

    case ENEMY_MV_MODE.POT_TURRET:
        patrol_spd     = 1.2;
        fire_timer     = irandom_range(30, 90);
        projectile_spd = 7;
        use_laser      = false; // set true to use eye laser instead of bullets
        // up-facing / down-facing orientation for sprites
        faces_up       = choose(true, false);
        image_angle    = faces_up ? 0 : 180;
        break;
}
