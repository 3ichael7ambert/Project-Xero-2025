// Initialize surface during game initialization






draw_set_font(fnt_menu);
/*
switch(current_menu) {
    case "main": draw_main_menu(); break;
    case "survival_player_select": draw_survival_submenu(); break;
    case "survival_level_select": draw_survival_level_select(); break;
    case "cityscape_player_select": draw_cityscape_submenu(); break;
    case "options_menu": draw_options_menu(); break;
}


switch (current_menu) {
    case "main":
        if (menu_confirmed) {
            var item = unlocked_menu_items[selected_item];
            if (item == "Cityscape") open_submenu("cityscape_player_select");
            else if (item == "Asteroid Belt") open_submenu("asteroid_player_select");
            else if (item == "Survival") open_submenu("survival_player_select");
            else if (item == "Boss") open_submenu("boss_player_select");
            else if (item == "Lava Run") open_submenu("lava_player_select");
            else if (item == "Invasion") open_submenu("battle_player_select");
            else if (item == "Options") open_submenu("options_menu");
            else if (item == "Exit") game_end();
        }
        break;

    case "cityscape_player_select":
        if (menu_confirmed) {
            player_count = selected_item + 1;
            start_game("cityscape");
        }
        break;

    case "asteroid_player_select":
        if (menu_confirmed) {
            player_count = selected_item + 1;
            start_game("asteroid");
        }
        break;

    case "lava_player_select":
        if (menu_confirmed) {
            player_count = selected_item + 1;
            start_game("lava");
        }
        break;

    case "survival_player_select":
        if (menu_confirmed) {
            player_count = selected_item + 1;
            open_submenu("survival_level_select");
        }
        break;

    case "survival_level_select":
        if (menu_confirmed) {
            selected_level = survival_levels[selected_item];
            start_game("survival");
        }
        break;

    case "boss_player_select":
        if (menu_confirmed) {
            player_count = selected_item + 1;
            open_submenu("boss_select");
        }
        break;

    case "boss_select":
        if (menu_confirmed) {
            selected_level = boss_names[selected_item];
            start_game("boss");
        }
        break;

    case "battle_player_select":
        if (menu_confirmed) {
            player_count = selected_item + 2;
            open_submenu("battle_level_select");
        }
        break;

    case "battle_level_select":
        if (menu_confirmed) {
            selected_level = battle_levels[selected_item];
            start_game("battle");
        }
        break;
}


*/

_MenuManager.handle_input();
_MenuManager.draw(display_get_gui_width() / 2, display_get_gui_height()+420);




if !surface_exists(surf_menu_bg) {
    //surf_menu_bg = surface_create(display_get_width(), display_get_height());
	surf_menu_bg = surface_create(room_width,room_height);
}

// Set target to surf_menu_bg
surface_set_target(surf_menu_bg);
//draw_sprite(sprMenuScreen, 3, x, y);

// Clear the surface to a specific color
draw_clear_alpha(c_black, 1);

// Draw your background elements
draw_set_color(make_color_rgb(150, 242, 252));
draw_rectangle(0, 0, room_width, room_height, 0);
draw_set_color(c_white);
draw_background_tiled_ext(sprXeroBG, 0, x, y, 0.25, 0.25, c_white, 1);
//draw_sprite(sprMenuScreen, 2, x, y);

// Reset target
//surface_reset_target();







/// clear hole for planet / moon
gpu_set_blendmode(bm_subtract);
draw_sprite(sprMenuScreen, 3, x, y);
gpu_set_blendmode(bm_normal);
surface_reset_target();


// Draw the surface
draw_surface(surf_menu_bg, 0,0 );

// Reset blend mode
gpu_set_blendmode(bm_normal);

// Draw additional elements
//draw_sprite(sprMenuScreen, 0, x, y);


//draw_sprite(sprMenuScreen, 2, x, y);
//draw_sprite_ext(sprMenuScreen, 1, x, y,1,1,0,1,.25);


///---///
//draw_shelled_circle(x,y,100,200,36,c_red,c_lime,1,0.25,5);
//draw_text(room_width/2, 32, "Controls: Navigation W/S or UP/DOWN\nENTER to select\nBACKSPACE to go back");

