function scr_Enemy_Robot_draw_jetpack_1(){
	sprite_body_offsetX=45;
sprite_body_offsetY=79;

sprite_set_offset(sprite_body, sprite_body_offsetX, sprite_body_offsetY);
	// Calculate body position
var body_x = x;
var body_y = y;

// retrieve variables for later use:
cx = x;
cy = y;


if (facing_right)
{
// find current angle on circle:
//cdir = point_direction(cx, cy, x, y);//image_angle+180;
crad_head = 60; // Adjust the radius value as per your requirements
crad_eyes = 65; // Adjust the radius value as per your requirements
crad_armF = 40; // Adjust the radius value as per your requirements
crad_fistF = 80; // Adjust the radius value as per your requirements ///
crad_armB = 35; // Adjust the radius value as per your requirements
crad_fistB = 70; // Adjust the radius value as per your requirements ///
crad_legF = 60; // Adjust the radius value as per your requirements
crad_legB = 60; // Adjust the radius value as per your requirements
crad_jet = 40; // Adjust the radius value as per your requirements

cdir_head = image_angle+90;
cdir_jet = image_angle+180;
cdir_eyes = image_angle+55;
cdir_armF = image_angle+130;
cdir_fistF = armF_dir-5;//image_angle+; ///
cdir_armB = image_angle+65;
cdir_fistB = image_angle+5; ///
cdir_legF = image_angle-120;
cdir_legB = image_angle-90;
}
else
{
crad_head = 60; // Adjust the radius value as per your requirements
crad_eyes = 65; // Adjust the radius value as per your requirements
crad_armF = 37; // Adjust the radius value as per your requirements
crad_fistF = 74; // Adjust the radius value as per your requirements ///
crad_armB = 35; // Adjust the radius value as per your requirements
crad_fistB = 70; // Adjust the radius value as per your requirements ///
crad_legF = 63; // Adjust the radius value as per your requirements
crad_legB = 62; // Adjust the radius value as per your requirements
crad_jet = 40; // Adjust the radius value as per your requirements

cdir_head = image_angle+90;
cdir_jet = image_angle;
cdir_eyes = image_angle+125;
cdir_armF = image_angle+45;
cdir_fistF = 180-armF_dir;//image_angle+45; ///
cdir_armB = image_angle+110;
cdir_fistB = image_angle+65;
cdir_legF = image_angle-70;
cdir_legB = image_angle-90;
}

// find "length" of circle:
clen_head = crad_head * pi * 2;
clen_jet = crad_jet * pi * 2;
clen_eyes = crad_head * pi * 2;
clen_armF = crad_armF * pi * 2;
clen_fistF = crad_fistF * pi * 2; ///
clen_armB = crad_armB * pi * 2;
clen_fistB = crad_fistB * pi * 2; ///
clen_legF = crad_legF * pi * 2;
clen_legB = crad_legB * pi * 2;



// find next angle on circle:
cnext_head = cdir_head + (3 * 360) / clen_head;
cnext_jet = cdir_jet + (3 * 360) / clen_jet;
cnext_eyes = cdir_eyes + (3 * 360) / clen_eyes;
cnext_armF = cdir_armF + (3 * 360) / clen_armF;
cnext_fistF = cdir_fistF + (3 * 360) / clen_fistF; ///
cnext_armB = cdir_armB + (3 * 360) / clen_armB;
cnext_armB = cdir_fistB + (3 * 360) / clen_fistB; ///
cnext_legF = cdir_legF + (3 * 360) / clen_legF;
cnext_legB = cdir_legB + (3 * 360) / clen_legB;
// find coordinates of next point:
nx_head = cx + lengthdir_x(crad_head*scale, cnext_head);
ny_head = cy + lengthdir_y(crad_head*scale, cnext_head);
nx_jet = cx + lengthdir_x(crad_jet*scale, cnext_jet);
ny_jet = cy + lengthdir_y(crad_jet*scale, cnext_jet);
nx_eyes = nx_head + lengthdir_x(crad_eyes*scale, cnext_eyes);
ny_eyes = ny_head + lengthdir_y(crad_eyes*scale, cnext_eyes);
nx_armF = cx + lengthdir_x(crad_armF*scale, cnext_armF);
ny_armF = cy + lengthdir_y(crad_armF*scale, cnext_armF);
//nx_fistF = cx + lengthdir_x(crad_fistF*scale, cnext_fistF); ///
//ny_fistF = cy + lengthdir_y(crad_fistF*scale, cnext_fistF); ///
nx_armB = cx + lengthdir_x(crad_armB*scale, cnext_armB);
ny_armB = cy + lengthdir_y(crad_armB*scale, cnext_armB);
//nx_fistB = cx + lengthdir_x(crad_fistB*scale, cnext_fistB); ///
//ny_fistB = cy + lengthdir_y(crad_fistB*scale, cnext_fistB); ///
//nx_fistF = nx_armF + lengthdir_x(crad_fistF*scale, cnext_fistF); ///
//ny_fistF = ny_armF + lengthdir_y(crad_fistF*scale, cnext_fistF); ///
if (facing_right==true) {
nx_fistF = nx_armF + lengthdir_x(crad_fistF*scale, cnext_fistF); ///
ny_fistF = ny_armF + lengthdir_y(crad_fistF*scale, cnext_fistF); ///
nx_fistB = nx_armB + lengthdir_x(crad_fistB*scale, cnext_fistB-65+hsp); ///
ny_fistB = ny_armB + lengthdir_y(crad_fistB*scale, cnext_fistB-65+hsp); ///
}
if (facing_right==false) {
nx_fistF = nx_armF + lengthdir_x(crad_fistF*scale, armF_dir); ///
ny_fistF = ny_armF + lengthdir_y(crad_fistF*scale, armF_dir); ///
nx_fistB = nx_armB + lengthdir_x(crad_fistB*scale, cnext_fistB+65-hsp); ///
ny_fistB = ny_armB + lengthdir_y(crad_fistB*scale, cnext_fistB+65-hsp); ///
}
//nx_fistB = nx_armB + lengthdir_x(crad_fistB*scale, cnext_fistB); ///
//ny_fistB = ny_armB + lengthdir_y(crad_fistB*scale, cnext_fistB); ///
nx_legF = cx + lengthdir_x(crad_legF*scale, cnext_legF);
ny_legF = cy + lengthdir_y(crad_legF*scale, cnext_legF);
nx_legB = cx + lengthdir_x(crad_legB*scale, cnext_legB);
ny_legB = cy + lengthdir_y(crad_legB*scale, cnext_legB);


// draw sprites





// Calculate head position based on body position and rotation
var head_offset_x = -10; // Adjust the x-offset for the head as needed
var head_offset_y = -60; // No initial y-offset for the head


// Calculate head direction based on body angle
var head_direction = 0 + image_angle;

// Calculate head position based on head direction
var head_direction_rotated_x = lengthdir_x(head_offset_x, head_direction);
var head_direction_rotated_y = lengthdir_y(head_offset_x, head_direction);
head_x = body_x + head_direction_rotated_x;
head_y = body_y + head_direction_rotated_y;


// Calculate eye offset based on head position and rotation
var eye_offset_x = 20; // Adjust the x-offset for the eyes as needed
var eye_offset_y = -50; // Adjust the y-offset for the eyes as needed
var eye_offset_rotated_x = lengthdir_x(eye_offset_x, head_direction);
var eye_offset_rotated_y = lengthdir_y(eye_offset_y, head_direction);
var eye_x = head_x + eye_offset_rotated_x;
var eye_y = head_y + eye_offset_rotated_y;

// Calculate eye movement
var eye_movement_range = 5; // Adjust the range of eye movement as needed
var eye_movement_x = random_range(-eye_movement_range, eye_movement_range);
var eye_movement_y = random_range(-eye_movement_range, eye_movement_range);

// Calculate new eye position based on mouse coordinates
var new_eye_x = eye_x + 9 * mouse_x / room_width;
var new_eye_y = eye_y + 9 * mouse_y / room_height;

// Apply eye movement
eye_x = new_eye_x + eye_movement_x +nx_eyes;
eye_y = new_eye_y + eye_movement_y+ny_eyes;

//bbox
//draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);

// Draw the sprites
if (facing_right)
{

		//draw_sprite_ext(sprArmArms, image_index, nx_armB, ny_armB, scale, scale, image_angle-65+hsp, color1,1);
		//draw_sprite_ext(sprFist, image_index, nx_fistB, ny_fistB, scale, scale, image_angle-65+hsp, color1,1); ///
	//STAND
	if walk=false && idle=true {
		draw_sprite_ext(sprArmArms, image_index, nx_armB, ny_armB, scale, scale, image_angle-65+hsp, color1,1);
		draw_sprite_ext(sprFist, image_index, nx_fistB, ny_fistB, scale, scale, image_angle-65+hsp, color1,1); ///
		draw_sprite_ext(sprLeg3, image_index, nx_legB, ny_legB, scale, scale, 0, color1,1);
		
	}
	if walk=true && idle=false {
		draw_sprite_ext(sprArmWalk, walk_armB, nx_armB, ny_armB, scale, scale, image_angle, color1,1);
		draw_sprite_ext(sprLeg2, walk_legB, nx_legB, ny_legB, scale, scale, 0, color1,1);
		
	}
    
	draw_sprite_ext(sprJetBack, image_index, nx_jet, ny_jet, scale, scale, image_angle-(speed/1), color1,1);
    draw_sprite_ext(sprite_body, sprite_body_idx, body_x, body_y, scale, scale, image_angle, color1,1);
	draw_sprite_ext(sprite_head, sprite_head_idx, nx_head, ny_head, scale, scale, image_angle, color1,1);
	draw_sprite_ext(sprite_eyes_img, sprite_eyes_idx, nx_head, ny_head, scale, scale, image_angle, c_white,1);
    draw_sprite_ext(sprite_eyes, sprite_eyes_pupil_idx, nx_eyes, ny_eyes, scale, scale, head_direction, c_white,1);
	
if weapon!=0 && weapon!=4 {
	draw_sprite_ext(sprArmArms, image_index, nx_armF, ny_armF, scale, scale, armF_dir, color1,1);
}

if (punch=false) {
			//draw_sprite_ext(sprArmArms, image_index, nx_armF, ny_armF, scale, scale, armF_dir, color1,1);
		}
		
	if weapon=0 {
		if (punch=false) {
			//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); //
			//draw_sprite_ext(sprArmArms, image_index, nx_armF, ny_armF, scale, scale, armF_dir, color1,1);
		}
		if (punch=true) {
			draw_sprite_ext(sprArmPunch, punch_img_idx, nx_armF, ny_armF, scale, scale, armF_dir, color1,1); //
		}
	}
	
	
	if weapon=1 {
		draw_sprite_ext(sprGun, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); //
	}
	if weapon=2 { //GUN2
		draw_sprite_ext(sprGun2, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
	}
	if weapon=3 { //GUN3
		draw_sprite_ext(sprGun3, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
	}
	
	
	if weapon=4 { //SWORD
	
	if (sword=false) {
			
			draw_sprite_ext(sprArmArms, image_index, nx_armF, ny_armF, scale, scale, armF_dir, color1,1);
			draw_sprite_ext(sprHandSword, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
	}
	if (sword=true) {
		
			draw_sprite_ext(spr_sword_arm, sword_img_idx, nx_armF, ny_armF, scale, scale, armF_dir, color1,1); //
			draw_sprite_ext(spr_sword_sword, sword_img_idx, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); //
		}
		
		
	}
	
	
	if weapon=5 { //SHOTGUN
		
		draw_sprite_ext(sprShotgun, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
	}
	if weapon=6 { //Raygun
		
		draw_sprite_ext(sprRayGun, 0, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		draw_sprite_ext(sprRayGun, 1, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
	}
	if weapon=7 { //Grenade
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		draw_sprite_ext(sprGrenadeLauncher, 1, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
	}
	if weapon=8 { //Rocket
		draw_sprite_ext(sprRocketLauncher, 1, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
	}
	if weapon=9 { //SNIPER
		draw_sprite_ext(sprSniper, 1, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
	}
	if weapon=10 { //FLAMETHROWER
		draw_sprite_ext(sprFlamethrower, 0, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
	}
	if weapon=11 { //TASER
		draw_sprite_ext(sprTaser, 0, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		draw_sprite_ext(sprTaser, taser_img+1, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		
	}
	if weapon=12 { //CHAINSAW
		draw_sprite_ext(sprChainsaw, 0, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		draw_sprite_ext(sprChainsaw, 1, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		draw_sprite_ext(sprChainsaw, chainsaw_blade+2, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); ///
		
	}
	
	if walk=false && idle=true {
		draw_sprite_ext(sprLeg3, image_index, nx_legF, ny_legF, scale, scale, 0, color1,1);
			
			if weapon=0 && punch=false {
				draw_sprite_ext(sprArmWalk, walk_armF, nx_armF, ny_armF, scale, scale, armF_dir, color1,1);
			}
		
	}
	if walk=true && idle=false {
		draw_sprite_ext(sprLeg2, walk_legF, nx_legF, ny_legF, scale, scale, 0, color1,1);
			
			if weapon=0 && punch=false {
				draw_sprite_ext(sprArmWalk, walk_armF, nx_armF, ny_armF, scale, scale, armF_dir, color1,1);
			}
		
	}
}
else
{
	
	if walk=false && idle=true  {
		draw_sprite_ext(sprArmArms, image_index, nx_armB, ny_armB, -scale, scale, image_angle+65-hsp, color1,1);
		//draw_sprite_ext(sprFist, image_index, nx_fistB, ny_fistB, -scale, scale, image_angle-65-hsp, color1,1); ///
		draw_sprite_ext(sprLeg3, image_index, nx_legB, ny_legB, -scale, scale, 0, color1,1);
	}
	if walk=false && idle=true  && punch=false && weapon!=0  {
		draw_sprite_ext(sprArmArms, image_index, nx_armB, ny_armB, -scale, scale, image_angle+65-hsp, color1,1);
		draw_sprite_ext(sprFist, image_index, nx_fistB, ny_fistB, -scale, scale, image_angle+65-hsp, color1,1); ///
		draw_sprite_ext(sprLeg3, image_index, nx_legB, ny_legB, -scale, scale, 0, color1,1);
	}
	if walk=true && idle=false {
		draw_sprite_ext(sprArmWalk, walk_armB, nx_armB, ny_armB, -scale, scale, image_angle+65-hsp, color1,1);
		draw_sprite_ext(sprLeg2, walk_legB, nx_legB, ny_legB, -scale, scale, 0, color1,1);
	}
    draw_sprite_ext(sprJetBack, image_index, nx_jet, ny_jet, -scale, scale, image_angle+(speed/1), color1,1);
    draw_sprite_ext(sprite_body, sprite_body_idx, body_x, body_y, -scale, scale, image_angle, color1,1);
	draw_sprite_ext(sprite_head, sprite_head_idx, nx_head, ny_head, -scale, scale, image_angle, color1,1);
	draw_sprite_ext(sprite_eyes_img, sprite_eyes_idx, nx_head, ny_head, -scale, scale, image_angle, c_white,1);
    draw_sprite_ext(sprite_eyes, sprite_eyes_pupil_idx, nx_eyes, ny_eyes, -scale, scale, head_direction, c_white,1);
	
	if ((weapon!=0) && (weapon!=4)) {
		draw_sprite_ext(sprArmArms, image_index, nx_armF, ny_armF, -scale, scale, armF_dir+180, color1,1);
	}
	
	if (punch=false) {
			//draw_sprite_ext(sprArmArms, image_index, nx_armF, ny_armF, -scale, scale, armF_dir+180, color1,1);
		}
		
	
	if weapon=0 {
		if (punch=false) {
			//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, scale, scale, armF_dir, color1,1); //
			//draw_sprite_ext(sprArmArms, image_index, nx_armF, ny_armF, -scale, scale, armF_dir+180, color1,1);
		}
		if (punch=true) {
			draw_sprite_ext(sprArmPunch, punch_img_idx, nx_armF, ny_armF, -scale, scale, armF_dir, color1,1); //
		}
	}
	
	
	if weapon=1 {
		//draw_sprite_ext(sprArmArms, image_index, nx_armF, ny_armF, -scale, scale, armF_dir+180, color1,1);
		draw_sprite_ext(sprGun, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
	}
	if walk=false && idle=true {
		if weapon=0 {
			draw_sprite_ext(sprArmWalk, walk_armF, nx_armF, ny_armF, -scale, scale, armF_dir+180, color1,1);
		}
		draw_sprite_ext(sprLeg3, image_index, nx_legF, ny_legF, -scale, scale, 0, color1,1);
	}
	if walk=true && idle=false {
		if weapon=0 {
			draw_sprite_ext(sprArmWalk, walk_armF, nx_armF, ny_armF, -scale, scale, armF_dir+180, color1,1);
		}
		draw_sprite_ext(sprLeg2, walk_legF, nx_legF, ny_legF, -scale, scale, 0, color1,1);
	}
	
	
	
	if weapon=0 { //FIST
		//draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
	}
	if weapon=1 { //GUN
		//draw_sprite_ext(sprGun, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
	}
	if weapon=2 { //GUN2
		draw_sprite_ext(sprGun2, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
	}
	if weapon=3 { //GUN3
		draw_sprite_ext(sprGun3, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
	}
	if weapon=4 { //SWORD
	
	if (sword=false) {
			
			draw_sprite_ext(sprArmArms, image_index, nx_armF, ny_armF, -scale, scale, armF_dir+180, color1,1);
			draw_sprite_ext(sprHandSword, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
	}
	if (sword=true) {
			draw_sprite_ext(spr_sword_arm, sword_img_idx, nx_armF, ny_armF, -scale, scale, armF_dir+180, color1,1); //
			draw_sprite_ext(spr_sword_sword, sword_img_idx, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); //
		}
		
		
	}
	if weapon=5 { //SHOTGUN
		
		draw_sprite_ext(sprShotgun, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
	}
	if weapon=6 { //Raygun
		
		draw_sprite_ext(sprRayGun, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		draw_sprite_ext(sprRayGun, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
	}
	if weapon=7 { //Grenade
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		draw_sprite_ext(sprGrenadeLauncher, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
	}
	if weapon=8 { //Rocket
		draw_sprite_ext(sprRocketLauncher, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
	}
	if weapon=9 { //SNIPER
		draw_sprite_ext(sprSniper, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
	}
	if weapon=10 { //FLAMETHROWER
		draw_sprite_ext(sprFlamethrower, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
	}
	if weapon=11 { //TASER
		draw_sprite_ext(sprTaser, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		draw_sprite_ext(sprTaser, taser_img+1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		
	}
	if weapon=12 { //CHAINSAW
		draw_sprite_ext(sprChainsaw, 0, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		draw_sprite_ext(sprFist, image_index, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		draw_sprite_ext(sprChainsaw, 1, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		draw_sprite_ext(sprChainsaw, chainsaw_blade+2, nx_fistF, ny_fistF, -scale, scale, armF_dir+180, color1,1); ///
		
	}

/*
	if walk=true && idle=false {
		draw_sprite_ext(sprLeg2, walk_legF, nx_legF, ny_legF, scale, scale, 0, color1,1);
			
			if weapon=0 && punch=false {
				draw_sprite_ext(sprArmWalk, walk_armF, nx_armF, ny_armF, -scale, scale, armF_dir, color1,1);
			}
		
	}
	*/
	
}



}