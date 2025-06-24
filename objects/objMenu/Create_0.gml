/// @description Insert description here
// You can write your code in this editor
randomize();

// Step Event
menu_confirmed = keyboard_check_pressed(vk_enter)

menu_dir_level=0;

x=0;//room_width/2;
y=0;//room_width/2;

bg_color1=make_color_rgb(irandom_range(64,192),irandom_range(64,192),irandom_range(64,192));

var lay_id = layer_get_id("Background");
var back_id = layer_background_get_id(lay_id);
if layer_background_get_sprite(back_id) != sprXeroBG
{
    layer_background_sprite(back_id, sprXeroBG);
	layer_background_blend(back_id,bg_color1);
	layer_hspeed(back_id,irandom_range(-2,2));
	layer_vspeed(back_id,irandom_range(-2,2));
}
surf_menu_bg=-1;
application_surface_draw_enable(true);



//menu_items = ["Cityscape", "Asteroid Belt", "Survival", "Invasion", "Zero Gravity", "Streetbike Fury", "Beach", "Forest", "Boss", "Lava Run", "Options", "Exit"];
// Top-level menu item definitions (filtered by unlocked state)
menu_items_all = ["Cityscape", "Asteroid Belt", "Survival", "Invasion", "Zero Gravity", "Streetbike Fury", "Boss", "Lava Run", "Options", "Exit"];
unlocked_menu_items = ["Cityscape", "Asteroid Belt", "Survival", "Boss", "Lava Run", "Options", "Exit"];
menu_items = unlocked_menu_items;

// Level definitions for specific modes
survival_levels = ["space", "sky", "forest", "jungle", "beach"];
boss_names = ["firestarter", "icequeen"];
battle_levels = ["skyline", "finaldestination"];




// Device availability and player control setup
player_controls = array_create(4, -1); // -1: Unset, 0: Keyboard+Mouse, 1+: Gamepad ID
assign_player_controls();

// Create submenu state tracking
menu_stack = [];
current_menu = "main";
selected_item = 0;

menu_x = display_get_gui_width() / 2 -300;
menu_y=room_height-(room_height/5);
menu_width =  room_width;// Set your desired menu width;
menu_height =  300;// Set your desired menu height;
array_number = array_length_1d(unlocked_menu_items); // Get the number of items in the array

rot=0;
target_rot = 0; 

menu2_x=room_width/2;
menu2_y=room_height/3;
menu2_width=room_width;
menu2_height=590;


armF_dir=-75;
armB_dir=-85;
body_angle=0;


///---///

// --- Create the Menu Manager ---
global.MenuManager = new MenuManager();

// --- Define functions that can be called by menu options ---
function start_game() {
    show_debug_message("Starting Game...");
    // room_goto(rm_level_1);
}

function show_credits() {
    show_debug_message("Game made by A. Coder");
}

function quit_game() {
    show_debug_message("Quitting Game...");
    game_end();
}

// --- Create the menus themselves ---

// Create the Settings Menu (this will be a sub-menu)
var settings_menu = new Menu();


// Create the Main Menu
// --- Top-Level Menu ---
var main_menu = new Menu(,,"Choose Game Mode");

for (var i = 0; i < array_length(unlocked_menu_items); i++) {
    var item = unlocked_menu_items[i];

    switch (item) {
        case "Cityscape":
            main_menu.add_option("Cityscape", function() {
                var player_menu = create_player_count_menu(start_cityscape_game);
                global.MenuManager.go_to_submenu(player_menu);
            });
            break;

        case "Survival":
            main_menu.add_option("Survival", function() {
                var player_menu = create_player_count_menu(function(pcount) {
                    var level_menu = create_survival_level_menu(pcount);
                    global.MenuManager.go_to_submenu(level_menu);
                });
                global.MenuManager.go_to_submenu(player_menu);
            });
            break;

        case "Boss":
            main_menu.add_option("Boss", function() {
                show_debug_message("Boss menu coming soon...");
            });
            break;

        case "Lava Run":
            main_menu.add_option("Lava Run", function() {
                start_game_mode("lava", 1); // Or prompt for player count
            });
            break;

        case "Options":
            var settings_menu = new Menu();
            settings_menu.add_option("Graphics", function() { show_debug_message("Graphics Settings"); });
            settings_menu.add_option("Audio", function() { show_debug_message("Audio Settings"); });
            settings_menu.add_option("Back", function() { global.MenuManager.go_back(); });

            main_menu.add_option("Options", settings_menu);
            break;

        case "Exit":
            main_menu.add_option("Quit", quit_game);
            break;
    }
}

// Set active menu
global.MenuManager.set_initial_menu(main_menu);

///---///
