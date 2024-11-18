/// @description  DRAW THE BOTTOM AND THE SIDES IN THE DRAW EVENT
//  SO THAT THEY WILL NOT COVER THE TOP OF OTHER CUBES
gpu_set_zwriteenable(true);
 gpu_set_ztestenable(true);
 
 if building==0 {
	 ///FRONT
if place_meeting(x+64,y,objBuilding) && place_meeting(x-64,y,objBuilding)
{
		//ROOF
	if !place_meeting(x,y-64,objBuilding) 
	{

/*
		draw_sprite_3d(sprite,subimg,x,y,128,90,0,0);
		draw_sprite_3d(sprite,subimg,x,y,192,90,0,0);
		draw_sprite_3d(sprite,subimg,x,y,256,90,0,0);
		*/
		draw_sprite_3d(sprite,subimg,roofMatrix);
		draw_sprite_3d(sprite,subimg,roofMatrix2);
		draw_sprite_3d(sprite,subimg,roofMatrix3);
	}
	//FRONT
	//draw_sprite_3d(sprite,subimg,x,y,64,0,0,0);
	draw_sprite_3d(sprite,subimg,frontMatrix);
	


}

///RIGHT
if !place_meeting(x+64,y,objBuilding) && place_meeting(x-64,y,objBuilding)
{
	


	var c = sprite_get_width(sprite); // Width of the sprite
	var a = c * dcos(45); //ax
	var b = c * dsin(45); //by bz

	draw_sprite_3d_pos(sprite,subimg,rightMatrix1,0,0,90.5,0,90.5,64,0,64);
	draw_sprite_3d(sprite,subimg,rightMatrix2);
	draw_sprite_3d_pos(sprite,subimg,rightMatrix3,0,0,90.5,0,90.5,64,0,64);
	
	/*
	draw_sprite_3d_pos(sprite,subimg,x,y,64,0,45,0,0,0,90.5,0,90.5,64,0,64);
	draw_sprite_3d(sprite,subimg,x+64,y,128,0,90,0);
	draw_sprite_3d_pos(sprite,subimg,x,y,256,0,-45,0,0,0,90.5,0,90.5,64,0,64);
	*/
	

		//ROOF
	if !place_meeting(x,y-64,objBuilding) 
	{
		draw_sprite_3d_pos(sprite,subimg,roofMatrix,0,0,64,0,64,0,0,64);
		draw_sprite_3d(sprite,subimg,roofMatrix2);
		draw_sprite_3d_pos(sprite,subimg,roofMatrix3,0,0,64,64,64,64,0,64);

		
	}
	
}

/// Left
if place_meeting(x+64,y,objBuilding) && !place_meeting(x-64,y,objBuilding)
{
		var c = sprite_get_width(sprite); // Width of the sprite

	var a = c * dcos(45); //ax
	var b = c * dsin(45); //by bz
	

	
	draw_sprite_3d_pos(sprite,subimg,leftMatrix1,0,0,90.5,0,90.5,64,0,64);
	draw_sprite_3d(sprite,subimg,leftMatrix2);
	draw_sprite_3d_pos(sprite,subimg,leftMatrix3,0,0,90.5,0,90.5,64,0,64);
	/*
	draw_sprite_3d_pos(sprite,subimg,x,y,128,0,-45,0,0,0,90.5,0,90.5,64,0,64);
	draw_sprite_3d(sprite,subimg,x,y,128,0,90,0);
	draw_sprite_3d_pos(sprite,subimg,x,y,192,0,45,0,0,0,90.5,0,90.5,64,0,64);
	*/
			//ROOF
	if !place_meeting(x,y-64,objBuilding) 
	{
		draw_sprite_3d_pos(sprite,subimg,roofMatrix,0,0,90.5,0,64,0,64,64);
		draw_sprite_3d(sprite,subimg,roofMatrix2);
		draw_sprite_3d_pos(sprite,subimg,roofMatrix3,64,0,64,64,64,64,0,64);
		
	}
	

	
}
}




 if building==1 {
if place_meeting(x+64,y,objBuilding) && place_meeting(x-64,y,objBuilding)
{
		//ROOF
	if !place_meeting(x,y-64,objBuilding) 
	{
		draw_sprite_3d(sprite,subimg,roofMatrix);
		draw_sprite_3d(sprite,subimg,roofMatrix2);
		draw_sprite_3d(sprite,subimg,roofMatrix3);
	}
	//FRONT
	draw_sprite_3d(sprite,subimg,frontMatrix);
	


}




///RIGHT
if !place_meeting(x+64,y,objBuilding) && place_meeting(x-64,y,objBuilding)
{
	var c = sprite_get_width(sprite); // Width of the sprite
	var a = c * dcos(45); //ax
	var b = c * dsin(45); //by bz

	draw_sprite_3d(sprite,subimg,frontMatrix);
	//draw_sprite_3d_pos(sprite,subimg,x,y,64,0,45,0,0,0,90.5,0,90.5,64,0,64);
	draw_sprite_3d(sprite,subimg,rightMatrix1b);
	draw_sprite_3d(sprite,subimg,rightMatrix2b);
	draw_sprite_3d(sprite,subimg,rightMatrix3b);
	//draw_sprite_3d_pos(sprite,subimg,x,y,256,0,-45,0,0,0,90.5,0,90.5,64,0,64);
		//ROOF
	if !place_meeting(x,y-64,objBuilding) 
	{
		//draw_sprite_3d_pos(sprite,subimg,x,y,128,90,0,0,0,0,64,0,64,0,0,64);
		draw_sprite_3d(sprite,subimg,roofMatrix);
		draw_sprite_3d(sprite,subimg,roofMatrix2);
		draw_sprite_3d(sprite,subimg,roofMatrix3);
		//draw_sprite_3d_pos(sprite,subimg,x,y,256,90,0,0,0,0,64,64,64,64,0,64);

		
	}
	
}





/// Left
if place_meeting(x+64,y,objBuilding) && !place_meeting(x-64,y,objBuilding)
{
		var c = sprite_get_width(sprite); // Width of the sprite

	var a = c * dcos(45); //ax
	var b = c * dsin(45); //by bz
	
	draw_sprite_3d(sprite,subimg,frontMatrix);
	//draw_sprite_3d_pos(sprite,subimg,x,y,128,0,-45,0,0,0,90.5,0,90.5,64,0,64);
	draw_sprite_3d(sprite,subimg,leftMatrix1b);
	draw_sprite_3d(sprite,subimg,leftMatrix2b);
	draw_sprite_3d(sprite,subimg,leftMatrix3b);
	//draw_sprite_3d_pos(sprite,subimg,x,y,192,0,45,0,0,0,90.5,0,90.5,64,0,64);
			//ROOF
	if !place_meeting(x,y-64,objBuilding) 
	{
		//draw_sprite_3d_pos(sprite,subimg,x,y,128,90,0,0,0,0,90.5,0,64,0,64,64);
		draw_sprite_3d(sprite,subimg,roofMatrix);
		draw_sprite_3d(sprite,subimg,roofMatrix2);
		draw_sprite_3d(sprite,subimg,roofMatrix3);
		//draw_sprite_3d_pos(sprite,subimg,x,y,256,90,0,0,64,0,64,64,64,64,0,64);
		
	}
	

	
}
}




gpu_set_zwriteenable(false);
 gpu_set_ztestenable(false);
 

matrix_set(matrix_world, matrix_build_identity());

