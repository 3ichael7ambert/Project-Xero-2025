/// @description Insert description here
// You can write your code in this editor
randomize();

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

// Level definitions for specific modes
survival_levels = ["beach", "outer space", "forest"];
battle_levels = ["outerspace", "final destination"];


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
