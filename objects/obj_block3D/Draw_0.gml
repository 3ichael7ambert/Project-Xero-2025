/// @description Insert description here
// You can write your code in this editor
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
// BOTOM
if ((place_meeting(x + 64, y, obj_block3D) || place_meeting(x + 64, y, obj_block3D)) && y > room_height / 2) {
    for (var i = 0; i < 10; i++) {
        draw_sprite_3d_matrix(sprSidewalk, 0, x, y, i * 64, 90, 0, 0);
        draw_sprite_3d_matrix(sprSidewalk, 0, x, y, -64, 45, 0, 0); //45degree
    }

    // Fill empty spaces between bottom and top
    for (var j = y;j>(y-dist_to_top); j -= 64) {
        draw_sprite_3d_matrix(sprSidewalk, 0, x, j, 576, 0, 0, 0);
    }
}

// TOP
if ((place_meeting(x + 64, y, obj_block3D) || place_meeting(x + 64, y, obj_block3D)) && y < room_height / 2) {
    for (var i = 0; i < 10; i++) {
        draw_sprite_3d_matrix(sprSidewalk, 0, x, y, i * 64, 90, 0, 0);
        draw_sprite_3d_matrix(sprSidewalk, 0, x, y, -64, 135, 0, 0); //45degree
    }
}

// LEFT
if (place_meeting(x, y + 64, obj_block3D) && x < room_width / 2) {
    for (var i = 0; i < 10; i++) {
        draw_sprite_3d_matrix(sprSidewalk, 0, x+64, y, i * 64, 0, 90, 0);
		
        draw_sprite_3d_matrix(sprSidewalk, 0, x+64, y, -64, 0, 90, 0);
		draw_sprite_3d_matrix(sprSidewalk, 0, x+64, y, -64, 0, -135, 0); //45degree
    }
}

// RIGHT
if (place_meeting(x, y + 64, obj_block3D) && x > room_width / 2) {
    for (var i = 0; i < 10; i++) {
        draw_sprite_3d_matrix(sprSidewalk, 0, x, y, i * 64, 0, 90, 0);
		
		draw_sprite_3d_matrix(sprSidewalk, 0, x, y, -64, 0, 90, 0);
        draw_sprite_3d_matrix(sprSidewalk, 0, x, y, -64, 0, -45, 0); //45degree
    }
}

gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);