function scr_Enemy_Robot_step_horz_mov(
modified_bbox_bottom,
modified_bbox_left,
modified_bbox_right,
modified_bbox_top){

// Horizontal movement

// Check for horizontal collisions
	if place_meeting(bbox_left-10+hsp,y-20,floor_obj) || place_meeting(bbox_right+10+hsp,y-20,floor_obj) {
		hsp = 0; // Stop horizontal movement when no key is pressed
		hsp_walk=0;
		walk=false;
		idle=true;
		wall_direction=0;
	}
	
	
if (place_meeting(x + hsp, y, obj_block_64)) {
    while (!place_meeting(x + sign(hsp), y, obj_block_64)) {
        x += sign(hsp);
    }
    hsp = 0; // Stop horizontal movement
}

if (hsp_walk>0) && (hsp_walk>hsp_walk_max) {hsp_walk=hsp_walk_max;}
if (hsp_walk<0) && (abs(hsp_walk)>hsp_walk_max) {hsp_walk=-hsp_walk_max;}
if wall_jump_force>0 {wall_jump_force-=1;}
if wall_jump_force<0 {wall_jump_force+=1;}

x += hsp + wall_jump_force + hsp_walk; // Apply horizontal movement

// Vertical movement
vsp += grav;
y += vsp; // Apply vertical movement

if (vsp > 10) vsp = 10; // Limit maximum fall speed

// Check for vertical collisions
if (place_meeting(x, y + modified_bbox_bottom, obj_block_64)) {
    while (!place_meeting(x, y + sign(vsp), obj_block_64)) {
        y += sign(vsp);
    }
    vsp = 0; // Stop vertical movement
	isJumping = false;
}




if !place_empty(x,y,floor_obj) {
	grav=0;
	vsp=0;
	isJumping=false;
	jumpSpeed=0;
	
}



// Jetpack modes 1 and 2 gravity
if (jetpack_mode == 1 || jetpack_mode == 2) {
	if  place_empty(x,y,floor_obj) {
    grav = 0.5; // Adjust this value as needed
	} else {
    grav = 0;
	vsp=0;
	isJumping=false; // Reset gravity when on the sidewalk
   // y -= 10; // Adjust the vertical position to stay on the floor
	}
}


// Update the bounding box coordinates
sprite_set_bbox(sprXeroBlank, modified_bbox_left, modified_bbox_top, modified_bbox_right, modified_bbox_bottom);


}