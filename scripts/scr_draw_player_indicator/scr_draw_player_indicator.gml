
/// @desc Draws player label above their head if multiplayer
/// Call this in the Draw GUI event of each player object

function scr_draw_player_indicator(_player){

switch (_player) {
	case 1:
		draw_col = c_red;
		break;
	case 2:
		draw_col = c_blue;
		break;
	case 3:
		draw_col = c_green;
		break;
	case 4:
		draw_col = c_yellow;
		break;
}
	
var player_num = _player 
if (global.players > 1) ||   (global.players == 1) {
    
    // Position above player's head
    //var screen_x = camera_get_view_x(view_camera[0]) + x;
    //var screen_y = camera_get_view_y(view_camera[0]) + y;
	var screen_x = x;
    var screen_y = y;

    var text = "P" + string(player_num);
    var offset_y = -64;

    // Draw the player number
    draw_set_color(draw_col);
    draw_set_halign(fa_center);
    draw_text(screen_x, screen_y + offset_y-5, text);
    
    // Draw a small downward triangle
    var tri_w = 8;
    var tri_h = 6;
    draw_triangle(screen_x - tri_w / 2, screen_y + offset_y + 14,
                  screen_x + tri_w / 2, screen_y + offset_y + 14,
                  screen_x, screen_y + offset_y + 14 + tri_h,
                  false);
}

}