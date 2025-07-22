function scr_menu(){
//
}

function assign_player_controls() {
    var gp_count = 0;
    for (var i = 0; i < 3; i++) {
        if (i == 0) {
            // First player option (choose manually)
            player_controls[i] = (gamepad_is_connected(0)) ? 0 : -1; // default to keyboard if available
			
	show_debug_message("Player " + string(i) + "found");
		} else {
            // Assign next available gamepads for P2-P4
            var found = false;
            for (var g = 1; g < 8; g++) {
                if (gamepad_is_connected(g)) {
                    player_controls[i] = g;
                    found = true;
					//
					show_debug_message("Player " + string(i) + " found");
					//
					global.max_players++;
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
		if (global.max_players == 1) {
			var options = ["1 Player"];
		}
		if (global.max_players == 2) {
			var options = ["1 Player", "2 Player"];
		}
		if (global.max_players == 3) {
			var options = ["1 Player", "2 Player", "3 Player"];
		}
		if (global.max_players == 4) {
			var options = ["1 Player", "2 Player", "3 Player", "4 Player"];
		}
		
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
		 if (global.max_players == 1) {
			var options = ["1 Player"];
		}
		if (global.max_players == 2) {
			var options = ["1 Player", "2 Player"];
		}
		if (global.max_players == 3) {
			var options = ["1 Player", "2 Player", "3 Player"];
		}
		if (global.max_players == 4) {
			var options = ["1 Player", "2 Player", "3 Player", "4 Player"];
		}
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
/*
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

            room_goto(rm_boss);  
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



*/



// Key transitions
function menu_buttons() {
	/*
	if (keyboard_check_pressed(vk_backspace)) {
	    return_to_previous_menu();
	}
	if (keyboard_check_pressed(vk_right)) {
	    selected_item = (selected_item -1 + array_number) % array_number;
	    target_rot = 360 * selected_item / array_number;
		audio_play_sound(snd_arrow_l,10,false);
	}
	if (keyboard_check_pressed(vk_left)) {
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
		*/
}	
/*
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

*/


// --- Gameplay Starter ---
function start_cityscape_game() {
   // global.player_count = player_count;
    room_goto(rmCity);
}

function start_survival_game(player_count, _level) {
    global.player_count = player_count;
    global.selected_level = _level;

if global.gameReady=true {
    switch (_level) {
        case "Outerspace": room_goto(r_level_infinite); break;
        case "Sky": room_goto(r_level_infinite); break;
        case "Forest": room_goto(r_levelSide_infinite); break;
        case "Jungle": room_goto(r_levelSide_infinite); break;
        case "Beach": room_goto(rm_Infinite_beach); break;
    }
}

}

function quit_game() { game_end(); }


function create_player_count_menu_cityscape() {
    var menu = new Menu();

//show_debug_message("room_target " + string(room_target));

    menu.add_option("1 Player", function() { global.players = 1; room_goto(global._next_room); });
    menu.add_option("2 Players", function() { global.players = 2; room_goto(global._next_room);  });
    menu.add_option("3 Players", function() { global.players = 3; room_goto(global._next_room);  });
    menu.add_option("4 Players", function() { global.players = 4; room_goto(global._next_room);  });

    return menu;
}

function create_player_count_menu_survival() {
    var menu = new Menu();

//show_debug_message("room_target " + string(room_target));

    menu.add_option("1 Player", function() { 
		global.players = 1; 
		var level_menu = create_survival_level_menu(1);
		level_menu.title = "Select Level";
		_MenuManager.go_to_submenu(level_menu);
		});
    menu.add_option("2 Players", function() { 
		global.players = 1; 
		var level_menu = create_survival_level_menu(1);
		level_menu.title = "Select Level";
		_MenuManager.go_to_submenu(level_menu);
		});
    menu.add_option("3 Players", function() { 
		global.players = 1; 
		var level_menu = create_survival_level_menu(1);
		level_menu.title = "Select Level";
		_MenuManager.go_to_submenu(level_menu);
		});
    menu.add_option("4 Players", function() { 
		global.players = 1; 
		var level_menu = create_survival_level_menu(1);
		level_menu.title = "Select Level";
		_MenuManager.go_to_submenu(level_menu);
		});

    return menu;
}


function create_player_count_menu_boss() {
	var menu = new Menu();
	
	return menu;
}
function create_player_count_menu_lava() {
	var menu = new Menu();
	
	return menu;
}

/*
function create_survival_level_menu(player_count) {
    var levels = ["Outerspace", "Sky", "Forest", "Jungle", "Beach","Train"];
    var level_menu = new Menu();
    for (var i = 0; i < array_length(levels); i++) {
        var lvl = levels[i];
		show_debug_message("LVL is " + string(lvl));
        level_menu.add_option(lvl, function(player_count,lvl) {
				global.gameReady=true; 
				start_survival_game(player_count, "Outerspacee")});
    
    }
    return level_menu;
}
*/
function create_survival_level_menu(player_count) {
    var levels = ["Outerspace", "Sky", "Forest", "Jungle", "Beach","Train"];
    var level_menu = new Menu();
			level_menu.add_option("Outerspace", function(player_count) {
				global.gameReady=true; 
				global.level_name = "Outerspace";
				start_survival_game(player_count, "Outerspace")}
				);
			level_menu.add_option("Sky", function(player_count) {
				global.gameReady=true; 
				global.level_name = "Sky";
				start_survival_game(player_count, "Sky")}
				);
			level_menu.add_option("Forest", function(player_count) {
				global.gameReady=true; 
				global.level_name = "Forest";
				start_survival_game(player_count, "Forest")}
				);
			level_menu.add_option("Jungle", function(player_count) {
				global.gameReady=true; 
				global.level_name = "Jungle";
				start_survival_game(player_count, "Jungle")}
				);
			level_menu.add_option("Beach", function(player_count) {
				global.gameReady=true; 
				global.level_name = "Beach";
				start_survival_game(player_count, "Beach")}
				);
			level_menu.add_option("Train", function(player_count) {
				global.gameReady=true; 
				global.level_name = "Train";
				start_survival_game(player_count, "Train")}
				);
    return level_menu;
}

/*
function create_boss_level_menu(player_count) {
    var levels = ["Fire Starter", "Ice Queen"];
    var level_menu = new Menu();
    for (var i = 0; i < array_length(levels); i++) {
        var lvl = levels[i];
        level_menu.add_option(lvl, start_survival_game(player_count, lvl));
    }
    return level_menu;
}*/

function create_boss_level_menu(player_count) {
     var levels = ["Fire Starter", "Ice Queen"];
    var level_menu = new Menu();
			level_menu.add_option("Fire Starter", function(player_count) {
				global.gameReady=true; 
				global.level_name = "Fire Starter";
				start_survival_game(player_count, "Fire Starter")}
				);
			level_menu.add_option("Ice Queen", function(player_count) {
				global.gameReady=true; 
				global.level_name = "Ice Queen";
				start_survival_game(player_count, "Ice Queen")}
				);
    return level_menu;
}

function create_battle_level_menu(player_count) {
    var levels = ["Skyline", "Final Destination", "Train"];
    var level_menu = new Menu();
    for (var i = 0; i < array_length(levels); i++) {
        var lvl = levels[i];
        level_menu.add_option(lvl, start_survival_game(player_count, lvl));
    }
    return level_menu;
}
