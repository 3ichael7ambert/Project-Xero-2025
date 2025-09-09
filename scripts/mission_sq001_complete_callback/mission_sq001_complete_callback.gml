/// @description Custom callback for the "Clear the Rubble" mission.
function mission_sq001_complete_callback() {
	var _output = 
    "**************************************************\n* SPECIAL CALLBACK: You cleared all the rubble!  *\n**************************************************\n"
    // You could put any game logic here, like opening a door, spawning a boss, etc.
	instance_activate_object(objBird);
	show_message(_output);
}