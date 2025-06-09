function scr_Enemy_Robot_create_init_ai(){


my_weapon = weapon;//irandom_range(1, 12); // or passed from controller
class_data = scr_weapon_class_data(my_weapon);

// example: set up combat preferences
preferred_range_min = class_data.preferred_range_min;
preferred_range_max = class_data.preferred_range_max;
aggression_level = class_data.aggression;
attack_cooldown_max = class_data.cooldown;
movement_type = class_data.move_style;

enemy_classes = [
    "streetfighter",
    "soldier1",
    "soldier2",
    "megaman",
    "swordsman",
    "shotgun",
    "laser",
    "grenade",
    "rocket",
    "sniper",
    "flamethrower",
    "taser",
    "chainsaw"
];
enemy_class = choose(enemy_classes);
enemy_class=enemy_classes[weapon];
jetpack_mode = choose(1, 2, 3);

// AI Classification Setup
switch (enemy_class) {
    case "streetfighter":
        preferred_range_min = 0;
        preferred_range_max = 60;
        movement_type = "rush";
        attack_type = "melee_combo";
        break;

    case "soldier1":
        preferred_range_min = 100;
        preferred_range_max = 250;
        movement_type = "normal";
        attack_type = "single_shot";
        break;

    case "soldier2":
        preferred_range_min = 120;
        preferred_range_max = 300;
        movement_type = "strafe";
        attack_type = "rapid_fire";
        break;

    case "megaman":
        preferred_range_min = 150;
        preferred_range_max = 300;
        movement_type = "jump_shoot";
        attack_type = "charged_shot";
        break;

    case "swordsman":
        preferred_range_min = 20;
        preferred_range_max = 80;
        movement_type = "rush";
        attack_type = "melee_slash";
        break;

    case "shotgun":
        preferred_range_min = 30;
        preferred_range_max = 100;
        movement_type = "rush";
        attack_type = "spread";
        break;

    case "laser":
        preferred_range_min = 200;
        preferred_range_max = 400;
        movement_type = "static";
        attack_type = "beam";
        break;

    case "grenade":
        preferred_range_min = 200;
        preferred_range_max = 350;
        movement_type = "arc";
        attack_type = "lob";
        break;

    case "rocket":
        preferred_range_min = 300;
        preferred_range_max = 500;
        movement_type = "normal";
        attack_type = "splash";
        break;

    case "sniper":
        preferred_range_min = 400;
        preferred_range_max = 600;
        movement_type = "retreat";
        attack_type = "precision";
        break;

    case "flamethrower":
        preferred_range_min = 50;
        preferred_range_max = 150;
        movement_type = "rush";
        attack_type = "cone";
        break;

    case "taser":
        preferred_range_min = 10;
        preferred_range_max = 40;
        movement_type = "dash";
        attack_type = "stun";
        break;

    case "chainsaw":
        preferred_range_min = 0;
        preferred_range_max = 30;
        movement_type = "rush";
        attack_type = "saw";
        break;
}


// Jetpack movement logic
// 1 = walking, 2 = jet shoes glide, 3 = full jetpack
switch (jetpack_mode) {
    case 1:
        move_speed = 1.2;
       grav = 0.4;
        break;

    case 2:
        move_speed = 2.2;
        grav = 0.15;
        break;

    case 3:
        move_speed = 2.8;
       grav = 0.05;
        break;
}



/*
offsetX=23;
offsetY=56;
*/

ai_state = "patrol"; // Can be: "patrol", "follow", "attack"
patrol_direction = choose(-1, 1); // Start facing left or right
patrol_timer = irandom_range(60, 180); // Frames before switching direction
player_detect_range = 600; // Distance to start following the player
attack_range = 150; // Distance to start attacking




}