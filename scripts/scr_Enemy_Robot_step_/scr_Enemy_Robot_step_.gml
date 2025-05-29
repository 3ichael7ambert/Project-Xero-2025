function scr_Enemy_Robot_step_(){

if (room=rm_boss) || (room=rmCity) || (room=rm_Infinite_beach) {
cm_x=global.CameraManager.x;
cm_y=global.CameraManager.y;
} else {
cm_x=mouse_x;
cm_y=mouse_y;
}









if (jetpack_mode==1)
{
// Horizontal movement

	if (move_left) 
	{
		facing_right = false;
		if !place_meeting(bbox_left,y-30,floor_obj) 
		{
			hsp_walk -= 1.4;
			walk=true;
			idle=false;
			wall_direction = -1;
			//walk_armF++;
		}
	} 
	else if (move_right) 
	{
		facing_right = true;
		if !place_meeting(bbox_right,y-20,floor_obj) 
		{
			hsp_walk += 1.4;
			walk=true;
			idle=false;
			wall_direction = 1;
			//walk_armF++;
		}
	} 
	else 
	{
		hsp_walk = 0; // Stop horizontal movement when no key is pressed
		walk=false;
		idle=true;
		wall_direction=0;
		//walk_armF=0;
	}


//WALK
	if walk_legF>16 {walk_legF=0;}
	if walk_legB<0 {walk_legB=16;}
	if walk_armF>18 {walk_armF=0;}
	if walk_armB<0 {walk_armB=18;}
	if walk=true { walk_legB-=1; walk_legF+=1;  walk_armB+=1; walk_armF-=1;} else {walk_legB=0; walk_legF=0; walk_armB=0; walk_armF=0;}

}
if jetpack_mode=2 || jetpack_mode==3 
{
    if (move_left) 
	{   if place_empty(x-bbox_left+hsp,y-20,floor_obj) {
        hsp -= 0.4;
		} else 
		if place_meeting(bbox_left-10+hsp,y-20,floor_obj) && wall_hold=false {
        wall_hold=true;
		//hsp=0;
		} else {
		hsp = 0;
		}
		if mouse_aim=false {
        facing_right = false;
		}
    }
    if (move_right) 
	{
        if place_empty(x+bbox_right,y,floor_obj)  {
        hsp += 0.4;
		} else 
		if place_meeting(bbox_right+10+hsp,y-20,floor_obj) && wall_hold=false {
        wall_hold=true;
		//hsp=0;
		}  else {
		hsp = 0;
		}
		if mouse_aim=false {
        facing_right = true;
		}
		if place_meeting(bbox_left-10+hsp,y-20,floor_obj) || place_meeting(bbox_right+10+hsp,y-20,floor_obj) {
		hsp = 0; // Stop horizontal movement when no key is pressed
		walk=false;
		idle=true;
		wall_direction=0;
	}
    }
}

// Jumping logic
if (move_up) {
    if (jetpack_mode == 3) && place_empty(x,bbox_top,floor_obj)
	{
        vsp -= 0.4;
    } 
	
	if jetpack_mode==1 || jetpack_mode==2 
	{
		if (!isJumping && !place_empty(x,y,floor_obj)) 
		{
        isJumping = true;
        jumpSpeed = jumpHeight;
		} 
		
		else 
		{
	 //isJumping = false;
		}
		if (isJumping=true) 
		{
			//WALLJUMP
			if (place_meeting(bbox_left-20, y-40, floor_obj))
			{
				
					//vsp = -jumpSpeed;
					jumpSpeed = jumpHeight;
					wall_jumping = true;
					wall_jump_force=20;
					alarm[3] = 30;
				
			}
			if (place_meeting(bbox_right+20, y-40, floor_obj))
			{
				//vsp = -jumpSpeed;
					jumpSpeed = jumpHeight;
					wall_jumping = true;
					wall_jump_force=-20;
					alarm[3] = 30;
			}
		}
		

	}
}

    if (move_down) && place_empty(x,bbox_bottom,floor_obj) {
        if jetpack_mode=3 {
			vsp += 0.4;
		}
	}


if (isJumping) {
    y -= jumpSpeed;
	y-=10;
    jumpSpeed -= grav;
}

///JETPACK2 offsets
if (facing_right) {
offsetX=25*scale;
} else {
offsetX=-25*scale;
}
offsetY=75*scale;





if hsp > 20
    hsp = 20;
if hsp < -20
    hsp = -20;
if vsp > 20
    vsp = 20;
if vsp < -20
    vsp = -20;
	




angle_head = image_angle;
angle_body = image_angle;
angle_jet = image_angle;
angle_armF = image_angle;
angle_armB = image_angle;
angle_legB = image_angle;
angle_legF = image_angle;
}