//store number of options in current menu
up_key = keyboard_check_pressed(vk_up);
down_key = keyboard_check_pressed(vk_down);
accept_key = keyboard_check_pressed(vk_space);

op_length=array_length(option[menu_level]);

pos += down_key - up_key;
if pos >= op_length {pos = 0};
if pos < 0 {pos = op_length-1};


if accept_key 
{
	var _sml=menu_level;
switch(menu_level) {
	case 0:
		switch(pos) {
		//start game
		case 0: break;
		case 1: menu_level=1; break;
		}
	case 1:
		switch(pos) {
		//start game
		case 0: menu_level=0; break;
		
		case 1: break;
		}
	case 2:	
		switch(pos) {
		//start game
		case 0: break;
		case 1: break;
		}

}
	if _sml!=menu_level {pos =0};
	op_length=array_length(option[menu_level]);
}
//---------------------------



// Oscillate the cursor using sin function
cursorLevitate = dsin(cursorTime);

// Use this as an "angle" to use in the sin function
// to oscillate cursor
cursorTime += leviRate;


// Vertical input is determined by the press of up
// and down buttons
var vert =  keyboard_check_pressed(downButt) -  keyboard_check_pressed(upButt);

// Move cursor up or down depending on inputs
selected += vert;
selectLerp = lerp(selectLerp, selected, lerpAmt); // Smooth cursor movement

// Don't let cursor move past where it should be
selected = clamp(selected, 0, array_length_1d(menu) - 1);

// Whenever you press the confirm button, do whatever
// it should do depending on what menu element is selected
if(keyboard_check_pressed(confirmButt))
{
	if(selected == 0 && menu_set=0) // Play by default
	{
		// Whatever happens when you play
	}
	
	if(selected == 1 && menu_set=0) // Options by default
	{
		// Go to options room
	}
	
	if(selected == 2 && menu_set=0) // Stats by default
	{
		// Go to stats room
	}
	
	if(selected == 3 && menu_set=0) // Exit by default
	{
		
	}
}








//GPT
// Check if gamepad is connected
if (gamepad_is_connected(0)) {
    // Gamepad is plugged in, set controls to gamepad
    // Use gamepad inputs for navigation and selection
    var kUp = gamepad_button_check_pressed(0, gp_padu);
    var kDown = gamepad_button_check_pressed(0, gp_padd);
    var kEnter = gamepad_button_check_pressed(0, gp_face1);
    var kBack = gamepad_button_check_pressed(0, gp_face2);
}
else {
    // Gamepad is not connected, set controls to keyboard
    // Use keyboard inputs for navigation and selection
    var kUp = keyboard_check_pressed(k_up);
    var kDown = keyboard_check_pressed(k_down);
    var kEnter = keyboard_check_pressed(k_enter);
    var kBack = keyboard_check_pressed(k_back);
}

// Handle menu navigation
if (!showOptions) {
    // Main menu navigation
    var prevSelectedOption = selectedOption;
    if (kDown) {
        selectedOption = (selectedOption + 1) mod menuOptions.length;
    } else if (kUp) {
        selectedOption = (selectedOption - 1 + menuOptions.length) mod menuOptions.length;
    }
    
    // Check for option selection changes
    if (prevSelectedOption != selectedOption) {
        // Play sound effect or update visual indicator for option selection change
    }
    
    // Execute option action on enter
    if (kEnter) {
        switch (selectedOption) {
            case 0: // Adventure
                // Code to handle Adventure menu
                break;
            case 1: // Survival
                // Code to handle Survival menu
                break;
            case 2: // Cityscape
                // Code to handle Cityscape menu
                break;
            case 3: // Dungeons
                // Code to handle Dungeons menu
                break;
        }
    }
} else {
    // Options menu navigation
    var prevSelectedOption = selectedControlOption;
    if (kDown) {
        selectedControlOption = (selectedControlOption + 1) mod controlOptions.length;
    } else if (kUp) {
        selectedControlOption = (selectedControlOption - 1 + controlOptions.length) mod controlOptions.length;
    }
    
    // Check for option selection changes
    if (prevSelectedOption != selectedControlOption) {
        // Play sound effect or update visual indicator for option selection change
    }
    
    // Execute option action on enter
    if (kEnter) {
        switch (selectedControlOption) {
            case 0: // Keyboard & Mouse
                // Code to handle Keyboard & Mouse controls
                break            case 1: // Gamepad
                // Code to handle Gamepad controls
                break;
            case 2: // Other
                // Code to handle Other controls
                break;
        }
    }
    
    // Go back to main menu on back button press
    if (kBack) {
        showOptions = false;
    }
}
