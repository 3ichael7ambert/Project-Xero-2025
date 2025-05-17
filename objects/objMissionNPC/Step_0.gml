/// @description Insert description here
// You can write your code in this editor


if (instance_exists(target)) {
    var dist = point_distance(x, y, target.x, target.y);
    
    show_msg = (dist < interaction_range);
    
    if (show_message && !global.mission_active) {
        var key_pressed = keyboard_check_pressed(vk_enter);
        var gamepad_pressed = gamepad_button_check_pressed(0, gp_face1); // A button

        if (key_pressed || gamepad_pressed) {
            global.mission_active = true;
            global.current_mission = id;
            mission_active = true;

            // Trigger mission controller or content
          //  instance_create_layer(x, y, "Controllers", objMissionController);
        }
    }
}
