//========================================= oGameSystem CREATE
// oGameSystem - Create Event

show_debug_message("Initializing Game System...");

// 1. Create the global Input Manager instance.
global.Input = new InputManager();

// 2. Initialize an array to hold our active player instances.
global.players_array = [];

// 3. Create and add a controller for Keyboard & Mouse. 
// It is now claimable just like a gamepad.
var _kbm_controller = new InputController(-1); // -1 is the device index for KBM
global.Input.add_controller(_kbm_controller);

// 4. Create and add controllers for ALL possible gamepad slots (0-11).
// The system will automatically ignore them if they aren't connected.
// This allows players to connect controllers after the game has started.
for (var i = 0; i < 12; i++) {
    var _pad_controller = new InputController(i);
    global.Input.add_controller(_pad_controller);
}

show_debug_message("Input System Ready.");
show_debug_message("Press ENTER to join with Keyboard.");
show_debug_message("Press L+R on a gamepad to join.");