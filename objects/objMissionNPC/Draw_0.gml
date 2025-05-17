/// @description Insert description here
// You can write your code in this editor

draw_self();

if (show_msg && !global.mission_active && distance_to_object(target)<50) {
    draw_text(x, y - 32, "Press [Enter] or (A) to accept mission");
}

if (mission_active) {
    draw_text(x, y - 48, "Mission Active");
}
