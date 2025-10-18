function scr_Director_Update_mv(){
/// scr_Director_Update_mv()
// Call from objControl_mv.Step

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
var _tier         = max(0, floor(kill_counter / kills_per_tier));
var _max_alive    = clamp(max_alive_base + _tier, max_alive_base, max_alive_cap);
var _cur_alive    = instance_exists(obj_Enemy_Robot) ? instance_number(obj_Enemy_Robot) : 0;
enemy_count_robot = _cur_alive;

var _spawn_interval = max(18, spawn_interval_base - (_tier * 5));
var _batch          = clamp(1 + (_tier div 2), 1, spawn_batch_cap);

// ---- Cooldown & cap ----
if (spawn_cooldown > 0) { spawn_cooldown--; exit; }
if (_cur_alive >= _max_alive) { exit; }

// ---- How many to create ----
var _need      = _max_alive - _cur_alive;
var _to_create = min(_batch, _need);
if (_to_create <= 0) { spawn_cooldown = 8; exit; }

// ---- Multipliers (locals) ----
var _hpMul    = 1 + (0.18 * _tier);
var _spdMul   = 1 + (0.06 * _tier);
var _fireMul  = max(0.40, 1 - (0.05 * _tier));  // lower fire_delay = faster fire
var _dmgMul   = 1 + (0.12 * _tier);
var _eliteChance = (_tier > 0 && (_tier mod elite_every_n_tiers) == 0)
    ? clamp(0.10 + 0.02 * _tier, 0.10, 0.50)
    : 0;

// ---- Spawn ring around player ----
var _px = instance_exists(obj_Player1) ? obj_Player1.x : x;
var _py = instance_exists(obj_Player1) ? obj_Player1.y : y;
var _lay_name = layer_get_name(layer); // controller's current layer name

repeat (_to_create) {
   // var _ang  = irandom_range(0, 359);
   // var _dist = irandom_range(enemy_spawn_radius * 0.6, enemy_spawn_radius);
   var cam = view_camera[0];
	//var _sx   = _px + lengthdir_x(_dist, _ang);
   // var _sy   = _py + lengthdir_y(_dist, _ang);
	var _sx   = camera_get_view_x(cam) + camera_get_view_width(cam);
    var _sy   = camera_get_view_y(cam) + irandom(camera_get_view_height(cam));

    var _e = instance_create(_sx, _sy, obj_Enemy_Robot);

    // push multipliers into the enemy instance
    _e._hpMul        = _hpMul;
    _e._spdMul       = _spdMul;
    _e._fireMul      = _fireMul;
    _e._dmgMul       = _dmgMul;
    _e._eliteChance  = _eliteChance;

    with (_e) {
        if (variable_instance_exists(self, "hp_base")) {
            hp = round(hp_base * _hpMul);
        } else if (variable_instance_exists(self, "hp")) {
            hp = round(hp * _hpMul);
        }

        if (variable_instance_exists(self, "move_spd")) move_spd *= _spdMul;

        if (variable_instance_exists(self, "fire_delay")) {
            fire_delay = max(1, round(fire_delay * _fireMul));
            if (variable_instance_exists(self, "min_fire_delay"))
                fire_delay = max(min_fire_delay, fire_delay);
        }

        if (variable_instance_exists(self, "damage")) damage = round(damage * _dmgMul);

        // Elite roll
        elite = false;
        if (_eliteChance > 0 && random(1) < _eliteChance) {
            elite = true;
            if (variable_instance_exists(self, "hp"))      hp      = round(hp * 1.75);
            if (variable_instance_exists(self, "damage"))  damage  = round(damage * 1.35);
            if (variable_instance_exists(self, "move_spd"))move_spd*= 1.15;
            image_blend = make_color_hsv(20, 220, 255);
        }
    }
}

// ---- Cooldown jitter ----
spawn_cooldown = _spawn_interval + irandom_range(-6, 6);


}