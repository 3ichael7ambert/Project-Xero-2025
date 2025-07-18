/// @function InputController(device_index)
/// @description Manages raw input from a single device (keyboard/mouse or gamepad).
/// @param {Real} device_index The index of the gamepad, or -1 for keyboard/mouse.
function InputController(_device_index = -1) constructor {
    // --- Enums and Properties ---
    
    // Enum to define the type of hardware input
    enum INPUT_TYPE {
        KEYBOARD,
        MOUSE_BUTTON,
        MOUSE_AXIS_X,
        MOUSE_AXIS_Y,
        GAMEPAD_BUTTON,
        GAMEPAD_AXIS
    }
    
    self.device_index = _device_index; // -1 for KBM, 0-11 for gamepads
    self.is_gamepad = (_device_index != -1);
    self.is_claimed = false;
    
    self.deadzone_inner = 0.20;
    self.deadzone_outer = 0.90;

    self.input_bindings = [];
    self.input_map = {};
    
    // --- "Private" Helper Methods ---
    
    static _get_key_string = function(type, code) {
        return $"input_{type}_{code}";
    }
    
    // --- Public API Methods ---
    
    static add_input = function(type, code) {
        var _key = self._get_key_string(type, code);
        if (variable_struct_exists(self.input_map, _key)) return _key;
        
        var _new_input = {
            type: type,
            code: code,
            is_axis: (type == INPUT_TYPE.GAMEPAD_AXIS or type == INPUT_TYPE.MOUSE_AXIS_X or type == INPUT_TYPE.MOUSE_AXIS_Y),
            pressed: false, released: false, held: false,
            value: 0.0, value_raw: 0.0,
        };
        
        array_push(self.input_bindings, _new_input);
        self.input_map[$ _key] = _new_input;
        return _key;
    };
    
    static get_input_state = function(key_string) {
        // REVISED: Replaced '??' with a compatible check
        if (variable_struct_exists(self.input_map, key_string)) {
            return self.input_map[$ key_string];
        }
        return undefined;
    };

    static check_combo_held = function(key_strings) {
        var _len = array_length(key_strings);
        for (var i = 0; i < _len; i++) {
            var _state = self.get_input_state(key_strings[i]);
            if (_state == undefined || !_state.held) {
                return false;
            }
        }
        return (_len > 0); // Return true only if the array wasn't empty
    }

    static update = function() {
        if (self.is_gamepad && !gamepad_is_connected(self.device_index)) {
            return;
        }

        var _count = array_length(self.input_bindings);
        for (var i = 0; i < _count; ++i) {
            var _input = self.input_bindings[i];
            
            _input.pressed = false;
            _input.released = false;
            _input.value = 0.0;
            
            switch (_input.type) {
                case INPUT_TYPE.KEYBOARD:
                    _input.pressed = keyboard_check_pressed(_input.code);
                    _input.released = keyboard_check_released(_input.code);
                    _input.held = keyboard_check(_input.code);
                    _input.value = _input.held ? 1.0 : 0.0;
                    break;
                case INPUT_TYPE.MOUSE_BUTTON:
                    _input.pressed = mouse_check_button_pressed(_input.code);
                    _input.released = mouse_check_button_released(_input.code);
                    _input.held = mouse_check_button(_input.code);
                    _input.value = _input.held ? 1.0 : 0.0;
                    break;
                case INPUT_TYPE.MOUSE_AXIS_X:
                    _input.value = mouse_x;
                    break;
                case INPUT_TYPE.MOUSE_AXIS_Y:
                    _input.value = mouse_y;
                    break;
                case INPUT_TYPE.GAMEPAD_BUTTON:
                    if (!self.is_gamepad) break;
                    _input.pressed = gamepad_button_check_pressed(self.device_index, _input.code);
                    _input.released = gamepad_button_check_released(self.device_index, _input.code);
                    _input.held = gamepad_button_check(self.device_index, _input.code);
                    _input.value = gamepad_button_value(self.device_index, _input.code);
                    break;
                case INPUT_TYPE.GAMEPAD_AXIS:
                    if (!self.is_gamepad) break;
                    var _raw = gamepad_axis_value(self.device_index, _input.code);
                    _input.value_raw = _raw;
                    var _abs_raw = abs(_raw);
                    if (_abs_raw < self.deadzone_inner) {
                        _input.value = 0.0;
                    } else {
                        var _range = self.deadzone_outer - self.deadzone_inner;
                        _input.value = sign(_raw) * clamp((_abs_raw - self.deadzone_inner) / _range, 0, 1);
                    }
                    var _old_held = _input.held;
                    _input.held = (_input.value != 0);
                    if (_input.held and !_old_held) _input.pressed = true;
                    if (!_input.held and _old_held) _input.released = true;
                    break;
            }
        }
    };
}

/// @function ActionMapper(input_controller, player_index)
/// @description Maps raw inputs to named game actions for a specific player.
/// @param {Struct.InputController} input_controller The controller to source inputs from.
/// @param {Real} player_index A unique index for the player (e.g., 0, 1, 2, 3).
function ActionMapper(_controller, _player_index) constructor {
    self.controller = _controller;
    self.player_index = _player_index;
    self.actions = {};
    
    static _ensure_action = function(action_name) {
        if (!variable_struct_exists(self.actions, action_name)) {
            self.actions[$ action_name] = {
                bindings: [],
                pressed: false,
                released: false,
                held: false,
                value: 0.0,
                is_virtual_axis: false,
                va_positive: undefined,
                va_negative: undefined
            };
        }
        return self.actions[$ action_name];
    }
    
    static map_button_to_action = function(input_key, action_name) {
        var _action = self._ensure_action(action_name);
        if (array_get_index(_action.bindings, input_key) == -1) {
            array_push(_action.bindings, input_key);
        }
    };

    static map_axis_to_action = function(input_key, action_name) {
        self.map_button_to_action(input_key, action_name);
    };

    static map_virtual_axis_to_action = function(negative_key, positive_key, action_name) {
        var _action = self._ensure_action(action_name);
        _action.is_virtual_axis = true;
        _action.va_negative = negative_key;
        _action.va_positive = positive_key;
    };
    
    static update = function() {
        var _action_names = variable_struct_get_names(self.actions);
        var _count = array_length(_action_names);

        for (var i = 0; i < _count; ++i) {
            var _name = _action_names[i];
            var _action = self.actions[$ _name];
            
            var _old_held = _action.held;
            _action.value = 0.0;
            _action.held = false;

            if (_action.is_virtual_axis) {
                var _pos_state = self.controller.get_input_state(_action.va_positive);
                var _neg_state = self.controller.get_input_state(_action.va_negative);
                var _pos_val = (_pos_state != undefined) ? _pos_state.value : 0;
                var _neg_val = (_neg_state != undefined) ? _neg_state.value : 0;
                _action.value = _pos_val - _neg_val;
                _action.held = (_action.value != 0);
            } else {
                var _num_bindings = array_length(_action.bindings);
                for (var j = 0; j < _num_bindings; ++j) {
                    var _state = self.controller.get_input_state(_action.bindings[j]);
                    if (_state == undefined) continue;
                    _action.held = _action.held or _state.held;
                    if (abs(_state.value) > abs(_action.value)) {
                        _action.value = _state.value;
                    }
                }
            }
            
            _action.pressed = (_action.held and !_old_held);
            _action.released = (!_action.held and _old_held);
        }
    };
    
    // --- Getters for Game Logic (REVISED) ---
    
    static get_action_pressed = function(action_name) {
        if (variable_struct_exists(self.actions, action_name)) {
            return self.actions[$ action_name].pressed;
        }
        return false;
    }
    
    static get_action_released = function(action_name) {
        if (variable_struct_exists(self.actions, action_name)) {
            return self.actions[$ action_name].released;
        }
        return false;
    }
    
    static get_action_held = function(action_name) {
        if (variable_struct_exists(self.actions, action_name)) {
            return self.actions[$ action_name].held;
        }
        return false;
    }
    
    static get_action_value = function(action_name) {
        if (variable_struct_exists(self.actions, action_name)) {
            return self.actions[$ action_name].value;
        }
        return 0.0;
    }
}

/// @function InputManager()
/// @description Global singleton to manage all input controllers and player mappers.
function InputManager() constructor {
    self.controllers = [];
    self.mappers = [];
    
    self.max_players = 4;
    self.next_player_index = 0;
    
    self.claim_combo_keys = []; 

    static add_controller = function(controller) {
        array_push(self.controllers, controller);
        
        // Set up the specific "join" or "claim" buttons for this controller type
        if (controller.is_gamepad) {
            // Gamepads will use a combo of L+R shoulder buttons to join
            var _l = controller.add_input(INPUT_TYPE.GAMEPAD_BUTTON, gp_shoulderl);
            var _r = controller.add_input(INPUT_TYPE.GAMEPAD_BUTTON, gp_shoulderr);
            self.claim_combo_keys[controller.device_index] = [_l, _r];
        } else {
            // The Keyboard/Mouse controller uses the 'Enter' key to join
            var _join_key = controller.add_input(INPUT_TYPE.KEYBOARD, vk_enter);
            // The KBM controller has device_index -1, which is not a valid array index.
            // We can store its claim key in a separate property.
            self.kbm_claim_key = _join_key;
        }
        return controller;
    };
    
    static find_and_claim_controller = function() {
        if (self.next_player_index >= self.max_players) {
            return undefined;
        }

        // Iterate through all available controllers to see if one is trying to join
        for (var i = 0; i < array_length(self.controllers); i++) {
            var _controller = self.controllers[i];
            
            // Skip this controller if it's already being used by a player
            if (_controller.is_claimed) {
                continue;
            }
            
            var _join_signal = false;
            if (_controller.is_gamepad) {
                // For gamepads, check if it's connected and L+R are held
                if (gamepad_is_connected(_controller.device_index)) {
                    var _combo_keys = self.claim_combo_keys[_controller.device_index];
                    _join_signal = _controller.check_combo_held(_combo_keys);
                }
            } else {
                // For KBM, check if the Enter key was just pressed
                var _state = _controller.get_input_state(self.kbm_claim_key);
                if (_state != undefined) {
                    _join_signal = _state.pressed;
                }
            }

            // If a join signal was detected, claim the controller and create a mapper
            if (_join_signal) {
                var _device_name = _controller.is_gamepad ? $"gamepad {_controller.device_index}" : "Keyboard";
                show_debug_message($"Player {self.next_player_index + 1} joined with {_device_name}!");
                
                _controller.is_claimed = true;
                
                var _new_mapper = new ActionMapper(_controller, self.next_player_index);
                array_push(self.mappers, _new_mapper);
                
                self.next_player_index++;
                
                return _new_mapper;
            }
        }
        
        return undefined;
    };
    
    static update = function() {
        var _c_count = array_length(self.controllers);
        for (var i = 0; i < _c_count; ++i) {
            self.controllers[i].update();
        }
        
        var _m_count = array_length(self.mappers);
        for (var i = 0; i < _m_count; ++i) {
            self.mappers[i].update();
        }
    };
}