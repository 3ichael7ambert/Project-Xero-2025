// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
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