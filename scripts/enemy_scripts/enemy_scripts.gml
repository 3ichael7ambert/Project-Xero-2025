// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_weapon_class_data(_weapon) {
    var data = {
        preferred_range_min: 0,
        preferred_range_max: 100,
        aggression: 1,
        cooldown: 30,
        move_style: "normal" // options: "normal", "dash", "retreat", etc.
    };

    switch (_weapon) {
        case 1: // Gun (soldier)
            data.preferred_range_min = 60;
            data.preferred_range_max = 150;
            data.aggression = 2;
            data.cooldown = 20;
            data.move_style = "normal";
            break;

        case 2: // Gun2 (SMG)
            data.preferred_range_min = 40;
            data.preferred_range_max = 120;
            data.aggression = 3;
            data.cooldown = 5;
            data.move_style = "rush";
            break;

        case 3: // Gun3 (Shotgun)
            data.preferred_range_min = 10;
            data.preferred_range_max = 60;
            data.aggression = 3;
            data.cooldown = 15;
            data.move_style = "rush";
            break;

        case 8: // Rocket Launcher
            data.preferred_range_min = 150;
            data.preferred_range_max = 300;
            data.aggression = 1;
            data.cooldown = 60;
            data.move_style = "retreat";
            break;

        case 9: // Sniper
            data.preferred_range_min = 200;
            data.preferred_range_max = 500;
            data.aggression = 1;
            data.cooldown = 90;
            data.move_style = "static";
            break;

        case 10: // Flamethrower
            data.preferred_range_min = 0;
            data.preferred_range_max = 60;
            data.aggression = 4;
            data.cooldown = 8;
            data.move_style = "rush";
            break;

        case 11: // Taser
            data.preferred_range_min = 0;
            data.preferred_range_max = 40;
            data.aggression = 2;
            data.cooldown = 10;
            data.move_style = "dash";
            break;

        case 12: // Chainsaw
            data.preferred_range_min = 0;
            data.preferred_range_max = 40;
            data.aggression = 5;
            data.cooldown = 5;
            data.move_style = "rush";
            break;
    }

    return data;
}
