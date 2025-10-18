function scr_Director_Update_mv(){
    /// scr_Director_Update_mv()
    // Called every Step from objControl_mv.Step

    // --- Do nothing until the game has started ---
    if (!game_start) exit;

    // ---- Defaults on controller (instance vars) ----
    if (!variable_instance_exists(self, "spawn_cooldown"))       spawn_cooldown       = 0;
    if (!variable_instance_exists(self, "spawn_interval_base"))  spawn_interval_base  = 75; // frames
    if (!variable_instance_exists(self, "kills_per_tier"))       kills_per_tier       = 10;
    if (!variable_instance_exists(self, "max_alive_base"))       max_alive_base       = 3;
    if (!variable_instance_exists(self, "max_alive_cap"))        max_alive_cap        = 30;
    if (!variable_instance_exists(self, "spawn_batch_cap"))      spawn_batch_cap      = 4;
    if (!variable_instance_exists(self, "enemy_spawn_radius"))   enemy_spawn_radius   = 640;
    if (!variable_instance_exists(self, "elite_every_n_tiers"))  elite_every_n_tiers  = 3;

    // ---- Tier / caps ----
    var _tier      = max(0, floor(kill_counter / kills_per_tier));
    var _max_alive = clamp(max_alive_base + _tier, max_alive_base, max_alive_cap);

    // current alive per family
    var _cur_robot = instance_exists(obj_Enemy_Robot) ? instance_number(obj_Enemy_Robot) : 0;
    var _cur_mv    = instance_exists(objEnemy_mv)     ? instance_number(objEnemy_mv)     : 0;

    // expose counts on controller (no resets!)
    enemy_count_robot = _cur_robot;
    enemy_count_mv    = _cur_mv;

    var _cur_total      = _cur_robot + _cur_mv;
    var _spawn_interval = max(18, spawn_interval_base - (_tier * 5));
    var _batch          = clamp(1 + (_tier div 2), 1, spawn_batch_cap);

    // ---- Cooldown & cap ----
    if (spawn_cooldown > 0) { spawn_cooldown--; return; }
    if (_cur_total >= _max_alive) { return; }

    // ---- How many to create (total) ----
    var _need      = _max_alive - _cur_total;
    var _to_create = min(_batch, _need);
    if (_to_create <= 0) { spawn_cooldown = 8; return; }

    // ---- Multipliers (locals) ----
    var _hpMul    = 1 + (0.18 * _tier);
    var _spdMul   = 1 + (0.06 * _tier);
    var _fireMul  = max(0.40, 1 - (0.05 * _tier));  // lower fire_delay = faster fire
    var _dmgMul   = 1 + (0.12 * _tier);
    var _eliteChance = (_tier > 0 && (_tier mod elite_every_n_tiers) == 0)
        ? clamp(0.10 + 0.02 * _tier, 0.10, 0.50)
        : 0;

    // ---- Camera rectangle (define BEFORE using _view_*) ----
    var _view_x, _view_y, _view_w, _view_h;
    if (view_enabled) {
        var _cam = view_get_camera(0);
        if (!is_undefined(_cam)) {
            _view_x = camera_get_view_x(_cam);
            _view_y = camera_get_view_y(_cam);
            _view_w = camera_get_view_width(_cam);
            _view_h = camera_get_view_height(_cam);
        } else {
            _view_x = view_xview[0];
            _view_y = view_yview[0];
            _view_w = view_wview[0];
            _view_h = view_hview[0];
        }
    } else {
        _view_x = 0; _view_y = 0; _view_w = room_width; _view_h = room_height;
    }

    // Use controller's layer (or replace with a specific layer name string)
    var _lay_name = layer_get_name(layer);

    // ---- Spawn loop ----
    repeat (_to_create) {
        // decide family (weight robots vs mv; nudge toward mv as tier grows)
        var mv_weight = clamp(0.30 + _tier * 0.05, 0.30, 0.80); // 30%→80% mv over time
        var spawn_mv  = (random(1) < mv_weight);

        // spawn just off the right edge, random Y within view
        var _sx = _view_x + _view_w + 24;
        var _sy = _view_y + irandom_range(0, _view_h);

        if (spawn_mv) {
            var _e = instance_create_layer(_sx, _sy, "Enemies", objEnemy_mv);

            // choose mode distribution
            var r = irandom(99);
            if (r < 14)         _e.mode = ENEMY_MV_MODE.SKY_DRILL;
            else if (r < 29)    { _e.mode = ENEMY_MV_MODE.LAVA_BALL; _e.lava_dir =  1; } // from bottom
            else if (r < 44)    { _e.mode = ENEMY_MV_MODE.LAVA_BALL; _e.lava_dir = -1; } // from top
            else if (r < 59)    _e.mode = ENEMY_MV_MODE.BOUNCER_CHASE;
            else if (r < 74)    _e.mode = ENEMY_MV_MODE.HOMER_STRAIGHT;
            else if (r < 89)    _e.mode = ENEMY_MV_MODE.HOMER_DRIFT;
            else                _e.mode = ENEMY_MV_MODE.GRAV_SWITCHER;

            // inject turret sometimes at higher tiers
            if (_tier >= 3 && irandom(100) < 12) {
                _e.mode = ENEMY_MV_MODE.POT_TURRET;
                _e.use_laser = (irandom(100) < 40);
            }

            // push multipliers
            _e._hpMul       = _hpMul;
            _e._spdMul      = _spdMul;
            _e._fireMul     = _fireMul;
            _e._dmgMul      = _dmgMul;
            _e._eliteChance = _eliteChance;

            with (_e) {
                if (variable_instance_exists(self, "hp_base")) hp = round(hp_base * _hpMul); else if (variable_instance_exists(self,"hp")) hp = round(hp * _hpMul);
                if (variable_instance_exists(self, "move_spd")) move_spd *= _spdMul;
                if (variable_instance_exists(self, "fire_delay")) {
                    fire_delay = max(1, round(fire_delay * _fireMul));
                    if (variable_instance_exists(self, "min_fire_delay")) fire_delay = max(min_fire_delay, fire_delay);
                }
                if (variable_instance_exists(self, "damage")) damage = round(damage * _dmgMul);

                elite = false;
                if (_eliteChance > 0 && random(1) < _eliteChance) {
                    elite = true;
                    if (variable_instance_exists(self,"hp"))      hp      = round(hp * 1.6);
                    if (variable_instance_exists(self,"damage"))  damage  = round(damage * 1.25);
                    if (variable_instance_exists(self,"move_spd"))move_spd*= 1.10;
                    image_blend = make_color_hsv(20, 220, 255);
                }
            }
        } else {
            // robot spawn
            var _r = instance_create_layer(_sx, _sy, "Enemies", obj_Enemy_Robot);
            _r._hpMul = _hpMul; _r._spdMul = _spdMul; _r._fireMul = _fireMul; _r._dmgMul = _dmgMul; _r._eliteChance = _eliteChance;

            with (_r) {
                if (variable_instance_exists(self, "hp_base")) hp = round(hp_base * _hpMul); else if (variable_instance_exists(self,"hp")) hp = round(hp * _hpMul);
                if (variable_instance_exists(self, "move_spd")) move_spd *= _spdMul;
                if (variable_instance_exists(self, "fire_delay")) {
                    fire_delay = max(1, round(fire_delay * _fireMul));
                    if (variable_instance_exists(self, "min_fire_delay")) fire_delay = max(min_fire_delay, fire_delay);
                }
                if (variable_instance_exists(self, "damage")) damage = round(damage * _dmgMul);

                elite = false;
                if (_eliteChance > 0 && random(1) < _eliteChance) {
                    elite = true;
                    if (variable_instance_exists(self,"hp"))      hp      = round(hp * 1.75);
                    if (variable_instance_exists(self,"damage"))  damage  = round(damage * 1.35);
                    if (variable_instance_exists(self,"move_spd"))move_spd*= 1.15;
                    image_blend = make_color_hsv(20, 220, 255);
                }
            }
        }
    }

    // ---- Cooldown jitter ----
    spawn_cooldown = _spawn_interval + irandom_range(-6, 6);
}
