//========================================= oGameSystem STEP
// oGameSystem - Step Event

// 1. ALWAYS update the input manager first. This polls all hardware.
global.Input.update();

player=obj_Player1;

// 2. Check if a new player is trying to join (with keyboard OR gamepad).
var new_mapper = global.Input.find_and_claim_controller();

// 3. If a new mapper was returned, a player has successfully joined!
if (new_mapper != undefined) {
    // A. Create a player object for them.
	global.gameReady=true;
    var _player_x = room_width / 2 + random_range(-100, 100);
    var _player_y = room_height / 2;
    var _player_instance = instance_create_layer(_player_x, _player_y, "Instances", player);
    
	
    // B. Assign the new mapper to the player instance. This is crucial.
    _player_instance.input_mapper = new_mapper;
    
    // C. Use the player_index from the mapper to identify the player.
    _player_instance.self_id = new_mapper.player_index;
    
    // D. --- DEFINE THIS PLAYER'S CONTROLS based on device type ---
    var _controller = new_mapper.controller;
    
	_player_instance.player = new_mapper.player_index + 1;
	/*
    if (_controller.is_gamepad) {
        // --- GAMEPAD BINDINGS ---
        var _l_stick_x = _controller.add_input(INPUT_TYPE.GAMEPAD_AXIS, gp_axislh);
        var _l_stick_y = _controller.add_input(INPUT_TYPE.GAMEPAD_AXIS, gp_axislv);
        var _jump_btn  = _controller.add_input(INPUT_TYPE.GAMEPAD_BUTTON, gp_face1); // "A" on Xbox
        var _fire_btn  = _controller.add_input(INPUT_TYPE.GAMEPAD_BUTTON, gp_face3); // "X" on Xbox

        new_mapper.map_axis_to_action(_l_stick_x, "move_horizontal");
        new_mapper.map_axis_to_action(_l_stick_y, "move_vertical");
        new_mapper.map_button_to_action(_jump_btn, "jump");
        new_mapper.map_button_to_action(_fire_btn, "fire");
        
    } else {
        // --- KEYBOARD BINDINGS ---
		// Define keys for a "virtual axis" (e.g., A/D for horizontal movement)
        var _key_left  = _controller.add_input(INPUT_TYPE.KEYBOARD, ord("A"));
        var _key_right = _controller.add_input(INPUT_TYPE.KEYBOARD, ord("D"));
        var _key_up    = _controller.add_input(INPUT_TYPE.KEYBOARD, ord("W"));
        var _key_down  = _controller.add_input(INPUT_TYPE.KEYBOARD, ord("S"));
        
		// Define buttons for actions
        var _key_jump  = _controller.add_input(INPUT_TYPE.KEYBOARD, vk_space);
        var _key_fire  = _controller.add_input(INPUT_TYPE.KEYBOARD, vk_shift);
        
		// Map the virtual axes and buttons to actions
        new_mapper.map_virtual_axis_to_action(_key_left, _key_right, "move_horizontal");
        new_mapper.map_virtual_axis_to_action(_key_up, _key_down, "move_vertical");
        new_mapper.map_button_to_action(_key_jump, "jump");
        new_mapper.map_button_to_action(_key_fire, "fire");
    }
	
	*/
	_player_instance.gamepad_num=_controller.device_index;
	 
	 if (_controller.is_gamepad) {
        // --- GAMEPAD BINDINGS ---
        _player_instance.gamepad=true;
		
		 //_player_instance.mouse_aim=false;
		//player_num=array_length(global.players)+1;
        
    } else {
        _player_instance.gamepad=false;
		// _player_instance.mouse_aim=true;
		//player_num=array_length(global.players)+1;
    }
    
    // E. Add the new player instance to our global list for tracking.
    array_push(global.players_array, _player_instance);
}