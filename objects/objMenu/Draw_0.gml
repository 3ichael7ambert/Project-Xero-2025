// Initialize surface during game initialization






draw_set_font(fnt_menu);

switch(current_menu) {
    case "main": draw_main_menu(); break;
    case "survival_player_select": draw_survival_submenu(); break;
    case "survival_level_select": draw_survival_level_select(); break;
    case "cityscape_player_select": draw_cityscape_submenu(); break;
    case "options_menu": draw_options_menu(); break;
}





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
draw_sprite_ext(sprMenuScreen, 1, x, y,1,1,0,1,.25);
