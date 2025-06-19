function scr_menu(){

}

function assign_player_controls() {
    var gp_count = 0;
    for (var i = 0; i < 4; i++) {
        if (i == 0) {
            // First player option (choose manually)
            player_controls[i] = (gamepad_is_connected(0)) ? 0 : -1; // default to keyboard if available
        } else {
            // Assign next available gamepads for P2-P4
            var found = false;
            for (var g = 1; g < 8; g++) {
                if (gamepad_is_connected(g)) {
                    player_controls[i] = g;
                    found = true;
                    break;
                }
            }
            if (!found) player_controls[i] = -1;
        }
    }
}


function open_submenu(name) {
    array_push(menu_stack, current_menu);
    current_menu = name;
    selected_item = 0;
}

function return_to_previous_menu() {
    if (array_length(menu_stack) > 0) {
        current_menu = array_pop(menu_stack);
        selected_item = 0;
    }
}

// Menu drawing logic (example call per menu state)
function draw_main_menu() {
    for (var i = 0; i < array_length(unlocked_menu_items); i++) {
        draw_text(menu_x, menu_y + i * 40, unlocked_menu_items[i]);
    }
}

function draw_survival_submenu() {
    draw_text(menu_x, menu_y, "Survival Mode - Select Player Count");
    var options = ["1 Player", "2 Player", "3 Player", "4 Player"];
    for (var i = 0; i < array_length(options); i++) {
        draw_text(menu_x, menu_y + (i+1) * 40, options[i]);
    }
}

function draw_survival_level_select() {
    draw_text(menu_x, menu_y, "Select Survival Level");
    for (var i = 0; i < array_length(survival_levels); i++) {
        draw_text(menu_x, menu_y + (i+1) * 40, survival_levels[i]);
    }
}

// Key transitions
if (keyboard_check_pressed(vk_backspace)) {
    return_to_previous_menu();
}

// Main navigation key (Enter)
if (keyboard_check_pressed(vk_enter)) {
    switch (current_menu) {
        case "main":
            var item = unlocked_menu_items[selected_item];
            if (item == "Survival") open_submenu("survival_player_select");
            else if (item == "Cityscape") open_submenu("cityscape_player_select");
            else if (item == "Options") open_submenu("options_menu");
            else if (item == "Exit") game_end();
            break;
        case "survival_player_select":
            open_submenu("survival_level_select");
            break;
        case "survival_level_select":
            // Start game using selected player count + level here
            break;
    }
}