/// @description Insert description here
// You can write your code in this editor
if (weapon==0) { //fist
	//draw_sprite_ext(sprite_index,parent.punch_img_idx,parent.nx_armF,parent.ny_armF,scale,scale,image_angle,c_white,1);
} else if (weapon==3) {
	exit;
	draw_self();
} else if (weapon==4) { //sword
	sprite_index=parent.spr_sword_fx;
	if (parent.facing_right) {
		//draw_sprite_ext(sprite_index,parent.sword_img_idx,parent.nx_armF,parent.ny_armF,scale,scale,image_angle,c_white,1);
	} else {
		//draw_sprite_ext(sprite_index,parent.sword_img_idx,parent.nx_armF,parent.ny_armF,scale,-scale,image_angle,c_white,1);
	}
}
else if (weapon==10) { //flamethrower
	//exit;
	draw_self();
	
}else if (weapon==11) { //taser
	//exit;
	draw_self();
	
}else if (weapon==12) { //chainsaw
	//exit;
	draw_self();
	
	
}else
	
	{
	draw_self();
}