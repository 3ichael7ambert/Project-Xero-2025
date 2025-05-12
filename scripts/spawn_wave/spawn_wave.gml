// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/*
function spawn_wave(_wave,enemy) {
    var num_enemies = 3 + _wave * 2; // scaling up
    enemies_remaining = num_enemies;
    
    for (var i = 0; i < num_enemies; i++) {
        var xx = random(room_width);
        var yy = random(room_height);
        var inst = instance_create_layer(xx, yy, "Enemies",enemy);

        // Scale enemy stats by difficulty
        inst.hp += global.difficulty * 2;
        inst.speed += global.difficulty * 0.1;
        inst.attack_power += global.difficulty * 0.5;
    }
}
*/

/// @function spawn_wave(_wave, enemy_obj, weapon_override, aggression_override, jetpack_override, scale_override)
/// All overrides are optional. Pass `undefined` or leave blank to use random values.


function spawn_wave(_wave, enemy_obj, weapon_override, aggression_override, jetpack_override, scale_override) {
    var num_enemies = 3 + _wave * 2;
    enemies_remaining = num_enemies;

    for (var i = 0; i < num_enemies; i++) {
        var xx = random(room_width);
        var yy = random(room_height);
        var inst = instance_create_layer(xx, yy, "Enemies", enemy_obj);

        // Difficulty scaling
        inst.hp += global.difficulty * 2;
        inst.speed += global.difficulty * 0.1;
        inst.attack_power += global.difficulty * 0.5;

        // Handle optional overrides (fallback to random/defaults)
        inst.weapon = is_undefined(weapon_override) ? irandom(12) : weapon_override;
        inst.aggression = is_undefined(aggression_override) ? irandom_range(1, 5) : aggression_override;
        inst.jetpack_mode = is_undefined(jetpack_override) ? choose(1, 2, 3) : jetpack_override;
        inst.scale = is_undefined(scale_override) ? choose(0.2, 0.25, 0.3) : scale_override;

        inst.facing_right = choose(true, false);
        inst.weapon_locked = true;

        // Setup based on weapon/class
        inst.class_data = scr_weapon_class_data(inst.weapon);
        inst.preferred_range_min = inst.class_data.preferred_range_min;
        inst.preferred_range_max = inst.class_data.preferred_range_max;
        inst.aggression_level = inst.class_data.aggression;
        inst.attack_cooldown_max = inst.class_data.cooldown;
        inst.movement_type = inst.class_data.move_style;

        inst.enemy_classes = [
            "streetfighter", "soldier1", "soldier2", "megaman",
            "swordsman", "shotgun", "laser", "grenade",
            "rocket", "sniper", "flamethrower", "taser", "chainsaw"
        ];
        inst.enemy_class = inst.enemy_classes[inst.weapon];
    }
}
