/// @description Insert description here
// You can write your code in this editor


draw_set_color(c_white);
draw_set_alpha(0.6);
draw_rectangle(16,16,320,224,0);
draw_set_color(c_black);
draw_set_alpha(1);
draw_text(32,32,string_hash_to_newline("#FPS: "+string(fps)+
"#FPS REAL: "+string(fpsreal)
+"##ARROW KEYS TO MOVE PLAYER#ENTER TO GO TO NEXT ROOM"+"##HOUR: "+string(current_hour)+"#Min:"+string(current_minute)));



gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);

// Set the spacing between repeated sprites
var spacing = 64;
/*
// Loop through the X-axis
for (var xx = 0; xx < room_width; x += spacing) {
    // Loop through the Y-axis
    for (var yy = 0; yy < room_height; y += spacing) {
        // Draw the 3D sprite at the specified coordinates
        draw_sprite_3d(sprSidewalk, 0, xx, yy, 320, 0, 0, 0);
    }
}
*/

gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);