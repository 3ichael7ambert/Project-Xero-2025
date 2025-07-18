//========================================= oGameSystem ASYNC
// oGameSystem - Async - System Event

var _event_type = async_load[? "event_type"];

// A gamepad has been unplugged
if (_event_type == "gamepad_lost") {
    var _pad_index = async_load[? "pad_index"];
    show_debug_message($"Gamepad lost: {_pad_index}");
    
    // Find which player was using this controller
    for (var i = 0; i < array_length(global.players_array); i++) {
        var _player = global.players_array[i];
        if (_player.input_mapper.controller.device_index == _pad_index) {
            
            // Mark the controller as unclaimed so it can be re-joined later
            _player.input_mapper.controller.is_claimed = false;
            
            // Optional: Destroy the player or put them in a "disconnected" state
            // instance_destroy(_player);
            // array_delete(global.players, i, 1);
            
            show_debug_message($"Player {_player.self_id + 1}'s controller disconnected.");
            break;
        }
    }
}

// A gamepad has been plugged in
if (_event_type == "gamepad_discovered") {
    var _pad_index = async_load[? "pad_index"];
    show_debug_message($"Gamepad discovered: {_pad_index}. Press L+R to join.");
    // The system is already polling all 12 slots, so no extra action is needed.
    // The find_and_claim_controller function will now be able to see this new gamepad.
}