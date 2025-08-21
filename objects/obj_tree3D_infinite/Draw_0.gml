/// @description Insert description here
// You can write your code in this editor
/*
gpu_set_zwriteenable(true);
//gpu_set_ztestenable(true);

//backleaves

//BACK Leaves
		draw_sprite_3d_part(sprite, 3, x*scale, y-(y_origin*6*scale), z-32*scale, -90, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 3, x*scale, y-32-(y_origin*6*scale)*scale, z-32*scale, -45, 0, 0,0,0,sw,sh,scale,scale,c_white,1); //down back 45
		draw_sprite_3d_part(sprite, 3, x*scale, y+32-(y_origin*6*scale)*scale, z-32*scale, -135, 0, 0,0,0,sw,sh,scale,scale,c_white,1); //up back  45
//Back right 45
		
		draw_sprite_3d_part(sprite, 3, x+32*scale, y-(y_origin*6*scale)*scale, z-48*scale, -45, 90, 90,0,0,sw,sh,scale,scale,c_white,1); //right back 45 flat
		
		
		
//Back left 45	
	
		draw_sprite_3d_part(sprite, 3, x+64*scale, y-(y_origin*6*scale)*scale, z*scale, -135, 90, 90,0,0,sw,sh,scale,scale,c_white,1); //right back 45 flat
		
//trunk
        draw_sprite_3d_part(sprite, 1, x*scale, y-(y_origin*scale)*scale, z*scale, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 2, x*scale, y-(y_origin*2*scale)*scale, z*scale, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 1, x*scale, y-(y_origin*3*scale)*scale, z*scale, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 2, x*scale, y-(y_origin*4*scale)*scale, z*scale, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 1, x*scale, y-(y_origin*5*scale)*scale, z*scale, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 0, x*scale, y-(y_origin*6*scale)*scale, z*scale, 0, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		
//front leaves

//front right 45	
	
	draw_sprite_3d_part(sprite, 3, x-32*scale, y-(y_origin*6*scale)*scale, z*scale, 45, 90, 90,0,0,sw,sh,scale,scale,c_white,1); //right back 45 flat
	draw_sprite_3d_part(sprite, 3, x+32*scale, y+32-(y_origin*6*scale)*scale, z+32*scale, 45, -45, 135,0,0,sw,sh,scale,scale,c_white,1); //right back 45 flat
	
	
//front left 45	
	
	draw_sprite_3d_part(sprite, 3, x+32*scale, y-(y_origin*6*scale)*scale, z+32*scale, 135, 90, 90,0,0,sw,sh,scale,scale,c_white,1); //right back 45 flat
	draw_sprite_3d_part(sprite, 3, x+64*scale, y+16-(y_origin*6*scale)*scale, z+16*scale, 45, 45, -135,0,0,sw,sh,scale,scale,c_white,1); //right back 45 flat
	
	
//FLAT

		draw_sprite_3d_part(sprite, 3, x*scale, y-(y_origin*6*scale)*scale, z+64, 90, 0, 0,0,0,sw,sh,scale,scale,c_white,1);
		
		draw_sprite_3d_part(sprite, 3, x*scale, y-(y_origin*6*scale)*scale, z-32*scale, 0, 90, 90,0,0,sw,sh,scale,scale,c_white,1); //riightside flat
		draw_sprite_3d_part(sprite, 3, x+64*scale, y-(y_origin*6*scale)*scale, z, 0, 90, -90,0,0,sw,sh,scale,scale,c_white,1);//leftside flat
		
		
		draw_sprite_3d_part(sprite, 3, x*scale, y+32-(y_origin*6*scale)*scale, z, 0, 0, 90,0,0,sw,sh,scale,scale,c_white,1); //riightside 
		draw_sprite_3d_part(sprite, 3, x+64*scale, y-32-(y_origin*6*scale)*scale, z, 0, 0, -90,0,0,sw,sh,scale,scale,c_white,1);//leftside 
		
		draw_sprite_3d_part(sprite, 3, x*scale, y-32-(y_origin*6*scale)*scale, z+32, 45, 0, 0,0,0,sw,sh,scale,scale,c_white,1); //down 45
		draw_sprite_3d_part(sprite, 3, x*scale, y+32-(y_origin*6*scale)*scale, z+32, 135, 0, 0,0,0,sw,sh,scale,scale,c_white,1); //up 45
		
		
		
		
		//draw_sprite_3d_part(sprite, 3, x*scale, y-32-(y_origin*6*scale)*scale, z+32, 45, 90, 0,0,0,sw,sh,scale,scale,c_white,1); //down 45 90right
		//draw_sprite_3d_part(sprite, 3, x*scale, y+32-(y_origin*6*scale)*scale, z+32, 135, 90, 0,0,0,sw,sh,scale,scale,c_white,1); //up 45 90right
		
		
		/*
		draw_sprite_3d_part(sprite, 4, x, y-(y_origin*5*scale), z, 0, 0, 90,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 3, x, y-(y_origin*5*scale), z, 0, 0, -90,0,0,sw,sh,scale,scale,c_white,1);
		
		draw_sprite_3d_part(sprite, 4, x, y-(y_origin*5*scale), z, 0, 0, 65,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 3, x, y-(y_origin*5*scale), z, 0, 0, -65,0,0,sw,sh,scale,scale,c_white,1);
		
		draw_sprite_3d_part(sprite, 4, x, y-(y_origin*5*scale), z, 0, 0, 125,0,0,sw,sh,scale,scale,c_white,1);
		draw_sprite_3d_part(sprite, 3, x, y-(y_origin*5*scale), z, 0, 0, -125,0,0,sw,sh,scale,scale,c_white,1);
		*/
		
        

		
		/*

gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);


//GPT
/*
/// @description Draws a 3D palm tree with correctly aligned leaves
// Enables depth sorting
gpu_set_zwriteenable(true);
//gpu_set_ztestenable(true);

var leaf_index = 3;
var trunk_segments = [1, 2, 1, 2, 1, 0];
var trunk_height = 6;
var base_x = x * scale;
var base_y = y - (y_origin * scale) * scale;
var base_z = z * scale;

// Draw trunk
for (var i = 0; i < trunk_height; i++) {
    draw_sprite_3d_part(sprite, trunk_segments[i], base_x, base_y - (i * y_origin * scale), base_z, 0, 0, 0, 0, 0, sw, sh, scale, scale, c_white, 1);
}

// Leaf positions
var angles = [0, 45, 90, 135, 180, 225, 270, 315];
var height_offset = -y_origin * 6 * scale;

// Flat leaves
for (var i = 0; i < array_length(angles); i++) {
    var angle = angles[i];
    draw_sprite_3d_part(sprite, leaf_index, base_x + lengthdir_x(32 * scale, angle), base_y + height_offset, base_z + lengthdir_y(32 * scale, angle), 0, angle, 0, 0, 0, sw, sh, scale, scale, c_white, 1);
}

// Upward 45-degree leaves
for (var i = 0; i < array_length(angles); i++) {
    var angle = angles[i];
    draw_sprite_3d_part(sprite, leaf_index, base_x + lengthdir_x(32 * scale, angle), base_y + height_offset + 16 * scale, base_z + lengthdir_y(32 * scale, angle), 45, angle, 0, 0, 0, sw, sh, scale, scale, c_white, 1);
}

// Downward 45-degree leaves
for (var i = 0; i < array_length(angles); i++) {
    var angle = angles[i];
    draw_sprite_3d_part(sprite, leaf_index, base_x + lengthdir_x(32 * scale, angle), base_y + height_offset - 16 * scale, base_z + lengthdir_y(32 * scale, angle), -45, angle, 0, 0, 0, sw, sh, scale, scale, c_white, 1);
}

// Disables depth sorting
gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);
*/