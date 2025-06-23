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
	audio_play_sound(snd_forward,10,false);
}

function return_to_previous_menu() {
    if (array_length(menu_stack) > 0) {
        current_menu = array_pop(menu_stack);
        selected_item = (0) % array_number;
		target_rot = 360 * selected_item / array_number;
		
	audio_play_sound(snd_back,10,false);
    }
}




function draw_cityscape_submenu() {
	//draw_text(menu_x, menu_y, "Cityscape: Select Player Count");
	 //TEXT
		
		var options = ["1 Player", "2 Player", "3 Player", "4 Player"];
	    for (var i = 0; i < array_length(options); i++) {
	        var col = (i == selected_item) ? c_yellow : c_white;
			var item_rot = 360 * i / array_number;
			 var rotated_x = lengthdir_x(menu_width/2, rot - item_rot + 90);
			 var rotated_y = lengthdir_y(menu_height/2, rot - item_rot + 90);
			draw_text_outlined(menu_x + rotated_x, menu_y+(menu_height/2) + rotated_y, options[i], c_white, c_gray);
	    }

		//IMAGES
		/*
	for (var i = 0; i < array_number; i++) {
	    var item_rot = 360 * i / array_number;
	    var rotated_x = lengthdir_x(menu2_width/2, rot - item_rot - 90);
	    var rotated_y = lengthdir_y(menu2_height/2, rot - item_rot - 90);

		if i=0 { //CITY
			var body=(true);
			var bg=(true);
			var scale=1;
			if body==true {
				var body_x = menu2_x + rotated_x;
				var body_y = menu2_y+(menu_height/2) + rotated_y;
			
				var armB_x = body_x + lengthdir_x(50*scale,50+body_angle);
				var armB_y = body_y + lengthdir_y(50*scale,50+body_angle);
				var handB_x = armB_x + lengthdir_x(80*scale,-5+armB_dir);
				var handB_y = armB_y + lengthdir_y(80*scale,-5+armB_dir);
			
				var legB_x = body_x + lengthdir_x(60*scale,-85+body_angle);
				var legB_y = body_y + lengthdir_y(60*scale,-85+body_angle);
			
				var jetpack_x = body_x + lengthdir_x(50*scale,175+body_angle);
				var jetpack_y = body_y + lengthdir_y(50*scale,175+body_angle);
			
				var head_x = body_x + lengthdir_x(58*scale,82+body_angle);
				var head_y = body_y + lengthdir_y(58*scale,82+body_angle);
				var eyes_x = head_x + lengthdir_x(60*scale,55);
				var eyes_y = head_y + lengthdir_y(60*scale,55);
			
				var armF_x = body_x + lengthdir_x(48*scale,132+body_angle);
				var armF_y = body_y + lengthdir_y(48*scale,132+body_angle);
				var handF_x = armF_x + lengthdir_x(75*scale,-3+armF_dir);
				var handF_y = armF_y + lengthdir_y(75*scale,-3+armF_dir);
			
				var legF_x = body_x + lengthdir_x(62*scale,-110+body_angle);
				var legF_y = body_y + lengthdir_y(63*scale,-110+body_angle);

			
				draw_sprite_ext(sprArmArms, 0, armB_x, armB_y, scale, scale, armB_dir, c_white, 1 );
				draw_sprite_ext(sprFist, 0, handB_x, handB_y, scale, scale, armB_dir, c_white, 1 );
				draw_sprite_ext(sprLeg3, 0, legB_x, legB_y, scale, scale, 0, c_white, 1);
				draw_sprite_ext(sprJetBack, 0, jetpack_x ,jetpack_y,scale, scale, -15+body_angle, c_white, 1 );
				draw_sprite_ext(sprBody, 0, body_x, body_y, scale, scale, body_angle, c_white, 1);
				draw_sprite_ext(sprHead_old, 0, head_x, head_y, scale, scale, 0, c_white, 1 );
				draw_sprite_ext(sprEyes, 0, eyes_x, eyes_y, scale, scale, 0, c_white, 1 );
				draw_sprite_ext(sprLeg3, 0, legF_x ,legF_y, scale, scale, 0, c_white, 1 );
				draw_sprite_ext(sprArmArms, 0, armF_x ,armF_y, scale, scale, armF_dir, c_white, 1);
				draw_sprite_ext(sprFist, 0, handF_x, handF_y, scale, scale, armF_dir, c_white, 1);
			}
		}
	
	}*/
}

function draw_survival_submenu() {
    var options = ["1 Player", "2 Player", "3 Player", "4 Player"];
	    for (var i = 0; i < array_length(options); i++) {
	        var col = (i == selected_item) ? c_yellow : c_white;
			var item_rot = 360 * i / array_number;
			 var rotated_x = lengthdir_x(menu_width/2, rot - item_rot + 90);
			 var rotated_y = lengthdir_y(menu_height/2, rot - item_rot + 90);
			draw_text_outlined(menu_x + rotated_x, menu_y+(menu_height/2) + rotated_y, options[i], c_white, c_gray);
	    }
}

function draw_survival_level_select() {
    for (var i = 0; i < array_length(survival_levels); i++) {
	        var col = (i == selected_item) ? c_yellow : c_white;
			var item_rot = 360 * i / array_number;
			 var rotated_x = lengthdir_x(menu_width/2, rot - item_rot + 90);
			 var rotated_y = lengthdir_y(menu_height/2, rot - item_rot + 90);
			draw_text_outlined(menu_x + rotated_x, menu_y+(menu_height/2) + rotated_y, survival_levels[i], c_white, c_gray);
	    }
}

function draw_options_menu() {
    var options = ["Sound: On", "Music: On", "Back"];
    //draw_text(menu_x, menu_y, "Options");
    for (var i = 0; i < array_length(options); i++) {
			var item_rot = 360 * i / array_number;
			 var rotated_x = lengthdir_x(menu_width/2, rot - item_rot + 90);
			 var rotated_y = lengthdir_y(menu_height/2, rot - item_rot + 90);
			draw_text_outlined(menu_x + rotated_x, menu_y+(menu_height/2) + rotated_y, options[i], c_white, c_gray);
	    }
	
	
}

function start_game(mode) {
    global.mode = mode;

    switch (mode) {
        case "cityscape":
            global.player_count = player_count;
           // room_goto(rmCity);
            break;

        case "asteroid":
            global.player_count = player_count;
            room_goto(r_level_infinite);
            break;

        case "survival":
            global.player_count = player_count;
            global.selected_level = selected_level;

            switch (selected_level) {
                case "space":
                case "sky":
                    room_goto(r_level_infinite);
                    break;
                case "forest":
                case "jungle":
                    room_goto(r_levelSide_infinite);
                    break;
                case "beach":
                    room_goto(rm_Infinite_beach);
                    break;
            }
            break;

        case "boss":
            global.player_count = player_count;
            global.selected_boss = selected_level;

            room_goto(rm_boss);  // use selected_boss in rm_boss logic
            break;

        case "lava":
            global.player_count = player_count;
            room_goto(rm_lava);
            break;

        case "battle":
            global.player_count = player_count;
            global.selected_level = selected_level;

            if (selected_level == "skyline") {
                room_goto(rm_battle_skyline);
            } else if (selected_level == "finaldestination") {
                room_goto(rm_battle_findes);
            }
            break;
    }
}







// Key transitions
function menu_buttons() {
	if (keyboard_check_pressed(vk_backspace)) {
	    return_to_previous_menu();
	}
	if (keyboard_check_pressed(vk_left)) {
	    selected_item = (selected_item - 1 + array_number) % array_number;
	    target_rot = 360 * selected_item / array_number;
		audio_play_sound(snd_arrow_l,10,false);
	}
	if (keyboard_check_pressed(vk_right)) {
	    selected_item = (selected_item + 1) % array_number;
	    target_rot = 360 * selected_item / array_number;
		audio_play_sound(snd_arrow_r,10,false);
	}

	if (gamepad_is_connected(0)) {
		if (gamepad_button_check_pressed(0,gp_face4)) {
			return_to_previous_menu();
		}
		if (gamepad_button_check_pressed(0,gp_face2)) {
			return_to_previous_menu();
		}
		if (gamepad_button_check_pressed(0,gp_padr)) || (gamepad_axis_value(0,gp_axislh)>0.5) {
		    selected_item = (selected_item - 1 + array_number) % array_number;
		    target_rot = 360 * selected_item / array_number;
		}
		if (gamepad_button_check_pressed(0,gp_padl)) || (gamepad_axis_value(0,gp_axislh)<-0.5) {
		    selected_item = (selected_item + 1) % array_number;
		    target_rot = 360 * selected_item / array_number;
		}
	
	}
		
		

if keyboard_check_pressed(vk_enter){
    var selection = unlocked_menu_items[selected_item];
    switch (selection) {
        case "Cityscape": 
			open_submenu("cityscape_player_select");
			selected_item = (0) % array_number;
			break;
        case "Asteroid Belt": 
			open_submenu("asteroid_player_select");
			selected_item = (0) % array_number;
			break;
        case "Survival":
			open_submenu("survival_player_select");
			selected_item = (0) % array_number;
			break;
        case "Boss":
			//room_goto(rm_boss);
			selected_item = (0) % array_number;
			break;
        case "Lava Run":
			//room_goto(rm_lava);
			selected_item = (0) % array_number;
			break;
        case "Options": 
			open_submenu("options_menu");
			selected_item = (0) % array_number;
			break;
        case "Exit":
			game_end();
			break;
    }
}

if (gamepad_is_connected(0)) {
	if (gamepad_button_check_pressed(0,gp_face1)) {
		var selection = unlocked_menu_items[selected_item];
	    switch (selection) {
	        case "Cityscape": 
				open_submenu("cityscape_player_select");
				selected_item = (0) % array_number;
				break;
	        case "Asteroid Belt": 
				open_submenu("asteroid_player_select");
				selected_item = (0) % array_number;
				break;
	        case "Survival":
				open_submenu("survival_player_select");
				selected_item = (0) % array_number;
				break;
	        case "Boss":
				room_goto(rm_boss);
				selected_item = (0) % array_number;
				break;
	        case "Lava Run":
				room_goto(rm_lava);
				selected_item = (0) % array_number;
				break;
	        case "Options": 
				open_submenu("options_menu");
				selected_item = (0) % array_number;
				break;
	        case "Exit":
				game_end();
				break;
    }
	
	
	}
			
}


	// Main navigation key (Enter)
if (keyboard_check_pressed(vk_enter)) {
	    switch (current_menu) {
	        case "main":
	            var item = unlocked_menu_items[selected_item];
	            if (item == "Survival") {
					open_submenu("survival_player_select");
					selected_item = (0) % array_number;
				}
	            else if (item == "Cityscape") {
					open_submenu("cityscape_player_select");
					selected_item = (0) % array_number;
				}
	            else if (item == "Options") {
					open_submenu("options_menu");
					selected_item = (0) % array_number;
				}
	            else if (item == "Exit") {
					game_end();
				}
				break;
	        case "survival_player_select":
	            open_submenu("survival_level_select");
	            break;
	        case "survival_level_select":
	            // Start game using selected player count + level here
	            break;
	    }
	}
	if (gamepad_is_connected(0)) {
		if (gamepad_button_check_pressed(0,gp_face4)) {
		    switch (current_menu) {
		        case "main":
	            var item = unlocked_menu_items[selected_item];
	            if (item == "Survival") {
					open_submenu("survival_player_select");
					selected_item = (0) % array_number;
				}
	            else if (item == "Cityscape") {
					open_submenu("cityscape_player_select");
					selected_item = (0) % array_number;
				}
	            else if (item == "Options") {
					open_submenu("options_menu");
					selected_item = (0) % array_number;
				}
	            else if (item == "Exit") {
					game_end();
				}
				break;
	        case "survival_player_select":
	            open_submenu("survival_level_select");
	            break;
	        case "survival_level_select":
	            // Start game using selected player count + level here
	            break;
		    }
		}
	}
}
