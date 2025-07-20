/// @function Menu(_draw_handler, _radius = 150)
/// @description Constructor for a single menu instance. Manages its own options and state.
/// @param {Function} _draw_handler The function that will be responsible for drawing this menu.
/// @param {Real} [_radius] The radius for circular menus.
function Menu(_draw_handler = draw_circular_menu, _radius = 600,_title = "") constructor {
    //================================================================================
    // Properties
    //================================================================================
    
    /// @description An array of option structs. Each struct contains a name and an action.
    options = [];
    
    /// @description The index of the currently selected option.
    selection_index = 0;
    
    // -- Drawing & Layout Properties --
    
    /// @description The function used to draw the menu. Allows for custom appearances.
    draw_handler = _draw_handler;
    
	title = _title;
    /// @description The radius of the circle on which options are placed.
    radius = _radius;
    
    /// @description The speed at which the menu rotates to the selected item.
    rotation_speed = 0.1;
    
    /// @description The current rotation of the menu view. Used for smooth animation.
    current_angle = 0;
    
    /// @description The angle the menu is trying to rotate towards.
    target_angle = 0;
    
    //================================================================================
    // Methods
    //================================================================================
    
    /// @description Adds a new option to the menu.
    /// @param {String} name The text to display for the option.
    /// @param {Function|Struct.Menu} action The function to execute or the sub-menu to open.
    static add_option = function(_name, _action) {
        var _option = {
            name: _name,
            action: _action,
        };
        array_push(options, _option);
    };
    
    /// @description Navigates the menu options up or down and updates the target angle for rotation.
    /// @param {Real} _direction The direction to navigate (-1 for up, 1 for down).
    static navigate = function(_direction) {
        if (array_length(options) == 0) {
            selection_index = 0;
            return;
        }
        
        selection_index += _direction;
        
        // Wrap selection around
        if (selection_index < 0) {
            selection_index = array_length(options) - 1;
        }
        if (selection_index >= array_length(options)) {
            selection_index = 0;
        }
        
        // Update the target angle for the circular menu drawing
        var _angle_step = 360 / array_length(options);
        target_angle = -selection_index * _angle_step;
    };
    
    /// @description Returns the currently selected option struct.
    /// @returns {Struct|undefined}
    static get_current_option = function() {
        if (array_length(options) > 0) {
            return options[selection_index];
        }
        return undefined;
    };
}

/// @function MenuManager()
/// @description Manages the active menu, navigation stack, and input handling.
function MenuManager() constructor {
    //================================================================================
    // Properties
    //================================================================================
    active_menu = noone;
    menu_stack = [];
    
    //================================================================================
    // Methods
    //================================================================================
    
    static set_initial_menu = function(_menu) {
        active_menu = _menu;
        active_menu.navigate(0); // Initialize target angle
        menu_stack = [];
    };
    
	
	
	
    static handle_input = function() {
		_gain=1;
		sound_click=snd_arrow_r;
		sound_back=snd_back;
		sound_forward=snd_forward;
		
        if (!is_struct(active_menu)) return;
		
				if gamepad_is_connected(0){
				var kUpGP = gamepad_button_check_pressed(0,gp_padu);
				var kRightGP = gamepad_button_check_pressed(0,gp_padr);
				var kDownGP = gamepad_button_check_pressed(0,gp_padd);
				var kLeftGP = gamepad_button_check_pressed(0,gp_padl);
				var enterGP = gamepad_button_check_pressed(0,gp_face1);
				var backGP = gamepad_button_check_pressed(0,gp_face2);
			} else {
				
				var enterGP = undefined;
				var backGP = undefined;
			}
		//else {
				var kUp = keyboard_check_pressed(vk_up);
				var kRight = keyboard_check_pressed(vk_right);
				var kDown = keyboard_check_pressed(vk_down);
				var kLeft = keyboard_check_pressed(vk_left);
			//}

        var _up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || kUp || kLeft || kUpGP || kLeftGP;
        var _down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || kDown || kRight || kDownGP || kRightGP
        
        if (_up) active_menu.navigate(-1);
        if (_down) active_menu.navigate(1);
		
		if (_up || _down) {
			audio_play_sound(sound_click,10,false,_gain,);
		}
		
        var _select = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || enterGP;
        if (_select) {
            var _option = active_menu.get_current_option();
            if (_option != undefined) {
                if (is_method(_option.action)) {
                    _option.action();
                } else if (is_struct(_option.action)) {
                    go_to_submenu(_option.action);
                }
            }
        }
        
        var _back = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_backspace) || backGP;
        if (_back) go_back();
    };

    static go_to_submenu = function(_submenu) {
        array_push(menu_stack, active_menu);
        active_menu = _submenu;
        active_menu.navigate(0); // Initialize target angle for new menu
    };
    
    static go_back = function() {
        if (array_length(menu_stack) > 0) {
            active_menu = array_pop(menu_stack);
            active_menu.navigate(0); // Re-initialize target angle
        } else {
            show_debug_message("At top level menu, cannot go back further.");
        }
    };
    
    /// @description Draws the currently active menu using its assigned draw handler.
    /// @param {Real} _x The x-coordinate to draw the menu at.
    /// @param {Real} _y The y-coordinate to draw the menu at.
    static draw = function(_x, _y) {
        if (is_struct(active_menu) || is_method(active_menu.draw_handler)) {
            // Call the menu's specific draw handler, passing the menu itself as an argument
            active_menu.draw_handler(active_menu, _x, _y);
        }
    };
}