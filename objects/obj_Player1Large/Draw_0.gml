if jetpack_mode=1
{
	
sprite_body_offsetX=45;
sprite_body_offsetY=79;

sprite_set_offset(sprite_body, sprite_body_offsetX, sprite_body_offsetY);
	// Calculate body position
var body_x = x;
var body_y = y;
armF_dir=0;
armB_dir=0;

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
crad_armB = 35; // Adjust the radius value as per your requirements
crad_legF = 60; // Adjust the radius value as per your requirements
crad_legB = 60; // Adjust the radius value as per your requirements
crad_jet = 40; // Adjust the radius value as per your requirements

cdir_head = image_angle+90;
cdir_jet = image_angle+180;
cdir_eyes = image_angle+55;
cdir_armF = image_angle+130;
cdir_armB = image_angle+65;
cdir_legF = image_angle-120;
cdir_legB = image_angle-90;
}
else
{
crad_head = 60; // Adjust the radius value as per your requirements
crad_eyes = 65; // Adjust the radius value as per your requirements
crad_armF = 37; // Adjust the radius value as per your requirements
crad_armB = 35; // Adjust the radius value as per your requirements
crad_legF = 63; // Adjust the radius value as per your requirements
crad_legB = 62; // Adjust the radius value as per your requirements
crad_jet = 40; // Adjust the radius value as per your requirements

cdir_head = image_angle+90;
cdir_jet = image_angle;
cdir_eyes = image_angle+125;
cdir_armF = image_angle+45;
cdir_armB = image_angle+110;
cdir_legF = image_angle-70;
cdir_legB = image_angle-90;
}

// find "length" of circle:
clen_head = crad_head * pi * 2;
clen_jet = crad_jet * pi * 2;
clen_eyes = crad_head * pi * 2;
clen_armF = crad_armF * pi * 2;
clen_armB = crad_armB * pi * 2;
clen_legF = crad_legF * pi * 2;
clen_legB = crad_legB * pi * 2;



// find next angle on circle:
cnext_head = cdir_head + (3 * 360) / clen_head;
cnext_jet = cdir_jet + (3 * 360) / clen_jet;
cnext_eyes = cdir_eyes + (3 * 360) / clen_eyes;
cnext_armF = cdir_armF + (3 * 360) / clen_armF;
cnext_armB = cdir_armB + (3 * 360) / clen_armB;
cnext_legF = cdir_legF + (3 * 360) / clen_legF;
cnext_legB = cdir_legB + (3 * 360) / clen_legB;
// find coordinates of next point:
nx_head = cx + lengthdir_x(crad_head, cnext_head);
ny_head = cy + lengthdir_y(crad_head, cnext_head);
nx_jet = cx + lengthdir_x(crad_jet, cnext_jet);
ny_jet = cy + lengthdir_y(crad_jet, cnext_jet);
nx_eyes = nx_head + lengthdir_x(crad_eyes, cnext_eyes);
ny_eyes = ny_head + lengthdir_y(crad_eyes, cnext_eyes);
nx_armF = cx + lengthdir_x(crad_armF, cnext_armF);
ny_armF = cy + lengthdir_y(crad_armF, cnext_armF);
nx_armB = cx + lengthdir_x(crad_armB, cnext_armB);
ny_armB = cy + lengthdir_y(crad_armB, cnext_armB);
nx_legF = cx + lengthdir_x(crad_legF, cnext_legF);
ny_legF = cy + lengthdir_y(crad_legF, cnext_legF);
nx_legB = cx + lengthdir_x(crad_legB, cnext_legB);
ny_legB = cy + lengthdir_y(crad_legB, cnext_legB);


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

draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
// Draw the sprites
if (facing_right)
{
	draw_sprite_ext(sprArmArms, image_index, nx_armB, ny_armB, 1, 1, image_angle, -1, 1);
	draw_sprite_ext(sprLeg3, image_index, nx_legB, ny_legB, 1, 1, 0, -1, 1);
    draw_sprite_ext(sprJetBack, image_index, nx_jet, ny_jet, 1, 1, image_angle-(speed/1), -1, 1);
    draw_sprite_ext(sprBody, image_index, body_x, body_y, 1, 1, image_angle, -1, 1);
	draw_sprite_ext(sprHeadSanta, image_index, nx_head, ny_head, 1, 1, image_angle, -1, 1);
    draw_sprite_ext(sprEyes, image_index, nx_eyes, ny_eyes, 1, 1, head_direction, -1, 1);
	draw_sprite_ext(sprArmArms, image_index, nx_armF, ny_armF, 1, 1, armF_dir, -1, 1);
	draw_sprite_ext(sprLeg3, image_index, nx_legF, ny_legF, 1, 1, 0, -1, 1);
}
else
{
	draw_sprite_ext(sprArmArms, image_index, nx_armB, ny_armB, -1, 1, image_angle, -1, 1);
	draw_sprite_ext(sprLeg3, image_index, nx_legB, ny_legB, -1, 1, 0, -1, 1);
    draw_sprite_ext(sprJetBack, image_index, nx_jet, ny_jet, -1, 1, image_angle+(speed/1), -1, 1);
    draw_sprite_ext(sprBody, image_index, body_x, body_y, -1, 1, image_angle, -1, 1);
	draw_sprite_ext(sprHeadSanta, image_index, nx_head, ny_head, -1, 1, image_angle, -1, 1);
    draw_sprite_ext(sprEyes, image_index, nx_eyes, ny_eyes, -1, 1, head_direction, -1, 1);
	draw_sprite_ext(sprArmArms, image_index, nx_armF, ny_armF, -1, 1, armF_dir, -1, 1);
	draw_sprite_ext(sprLeg3, image_index, nx_legF, ny_legF, -1, 1, 0, -1, 1);
	
}



}
if jetpack_mode=2
{
	

sprite_body_offsetX=22;
sprite_body_offsetY=135;


sprite_set_offset(sprite_body, sprite_body_offsetX, sprite_body_offsetY);
	// Calculate body position
var body_x = x;
var body_y = y;
armF_dir=0;
armB_dir=0;

// retrieve variables for later use:
cx = x;
cy = y;


if (facing_right)
{
// find current angle on circle:
//cdir = point_direction(cx, cy, x, y);//image_angle+180;
crad_head = 115; // Adjust the radius value as per your requirements
crad_eyes = 65; // Adjust the radius value as per your requirements
crad_armF = 85; // Adjust the radius value as per your requirements
crad_armB = 95; // Adjust the radius value as per your requirements
crad_legF = 1; // Adjust the radius value as per your requirements
crad_legB = 25; // Adjust the radius value as per your requirements
crad_jet = 60; // Adjust the radius value as per your requirements

cdir_head = image_angle+75;
cdir_jet = image_angle+100;
cdir_eyes = image_angle+55;
cdir_armF = image_angle+90;
cdir_armB = image_angle+65;
cdir_legF = image_angle-120;
cdir_legB = image_angle-5;
}
else
{
crad_head = 115; // Adjust the radius value as per your requirements
crad_eyes = 65; // Adjust the radius value as per your requirements
crad_armF = 85; // Adjust the radius value as per your requirements
crad_armB = 95; // Adjust the radius value as per your requirements
crad_legF = 1; // Adjust the radius value as per your requirements
crad_legB = 25; // Adjust the radius value as per your requirements
crad_jet = 60; // Adjust the radius value as per your requirements

cdir_head = image_angle+105;
cdir_jet = image_angle+80;
cdir_eyes = image_angle+125;
cdir_armF = image_angle+90;
cdir_armB = image_angle+115;
cdir_legF = image_angle;
cdir_legB = image_angle-175;
}

// find "length" of circle:
clen_head = crad_head * pi * 2;
clen_jet = crad_jet * pi * 2;
clen_eyes = crad_head * pi * 2;
clen_armF = crad_armF * pi * 2;
clen_armB = crad_armB * pi * 2;
clen_legF = crad_legF * pi * 2;
clen_legB = crad_legB * pi * 2;



// find next angle on circle:
cnext_head = cdir_head + (3 * 360) / clen_head;
cnext_jet = cdir_jet + (3 * 360) / clen_jet;
cnext_eyes = cdir_eyes + (3 * 360) / clen_eyes;
cnext_armF = cdir_armF + (3 * 360) / clen_armF;
cnext_armB = cdir_armB + (3 * 360) / clen_armB;
cnext_legF = cdir_legF + (3 * 360) / clen_legF;
cnext_legB = cdir_legB + (3 * 360) / clen_legB;
// find coordinates of next point:
nx_head = cx + lengthdir_x(crad_head, cnext_head);
ny_head = cy + lengthdir_y(crad_head, cnext_head);
nx_jet = cx + lengthdir_x(crad_jet, cnext_jet);
ny_jet = cy + lengthdir_y(crad_jet, cnext_jet);
nx_eyes = nx_head + lengthdir_x(crad_eyes, cnext_eyes);
ny_eyes = ny_head + lengthdir_y(crad_eyes, cnext_eyes);
nx_armF = cx + lengthdir_x(crad_armF, cnext_armF);
ny_armF = cy + lengthdir_y(crad_armF, cnext_armF);
nx_armB = cx + lengthdir_x(crad_armB, cnext_armB);
ny_armB = cy + lengthdir_y(crad_armB, cnext_armB);
nx_legF = cx + lengthdir_x(crad_legF, cnext_legF);
ny_legF = cy + lengthdir_y(crad_legF, cnext_legF);
nx_legB = cx + lengthdir_x(crad_legB, cnext_legB);
ny_legB = cy + lengthdir_y(crad_legB, cnext_legB);


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

draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
// Draw the sprites
if (facing_right)
{
	draw_sprite_ext(sprArmArms, image_index, nx_armB-offsetX, ny_armB+offsetY, 1, 1, image_angle, -1, 1);
	//draw_sprite_ext(sprLeg3, image_index, nx_legB, ny_legB, 1, 1, 0, -1, 1);
	draw_sprite_ext(sprLeg, image_index, x+25-offsetX, y+offsetY, 1, 1, 0, -1, 1);
    draw_sprite_ext(sprJetBack, image_index, nx_jet-offsetX, ny_jet+offsetY, 1, 1, image_angle-(speed/1), -1, 1);
    draw_sprite_ext(sprBody, image_index, body_x-offsetX, body_y+offsetY, 1, 1, image_angle, -1, 1);
	draw_sprite_ext(sprHeadSanta, image_index, nx_head-offsetX, ny_head+offsetY, 1, 1, image_angle, -1, 1);
    draw_sprite_ext(sprEyes, image_index, nx_eyes-offsetX, ny_eyes+offsetY, 1, 1, head_direction, -1, 1);
	draw_sprite_ext(sprArmArms, image_index, nx_armF-offsetX, ny_armF+offsetY, 1, 1, armF_dir, -1, 1);
	draw_sprite_ext(sprLeg, image_index, nx_legF-offsetX, ny_legF+offsetY, 1, 1, 0, -1, 1);
}
else
{
	draw_sprite_ext(sprArmArms, image_index, nx_armB-offsetX, ny_armB+offsetY, -1, 1, image_angle, -1, 1);
	//draw_sprite_ext(sprLeg3, image_index, nx_legB, ny_legB, -1, 1, 0, -1, 1);
	draw_sprite_ext(sprLeg, image_index, x-25-offsetX, y+offsetY, -1, 1, 0, -1, 1);
    draw_sprite_ext(sprJetBack, image_index, nx_jet-offsetX, ny_jet+offsetY, -1, 1, image_angle+(speed/1), -1, 1);
    draw_sprite_ext(sprBody, image_index, body_x-offsetX, body_y+offsetY, -1, 1, image_angle, -1, 1);
	draw_sprite_ext(sprHeadSanta, image_index, nx_head-offsetX, ny_head+offsetY, -1, 1, image_angle, -1, 1);
    draw_sprite_ext(sprEyes, image_index, nx_eyes-offsetX, ny_eyes+offsetY, -1, 1, head_direction, -1, 1);
	draw_sprite_ext(sprArmArms, image_index, nx_armF-offsetX, ny_armF+offsetY, -1, 1, armF_dir, -1, 1);
	draw_sprite_ext(sprLeg, image_index, nx_legF-offsetX, ny_legF+offsetY, -1, 1, 0, -1, 1);



}
}

if jetpack_mode=3
{
	

sprite_body_offsetX=45;
sprite_body_offsetY=79;

sprite_set_offset(sprite_body, sprite_body_offsetX, sprite_body_offsetY);
	// Calculate body position
var body_x = x;
var body_y = y;
armF_dir=0;
armB_dir=0;

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
crad_armB = 35; // Adjust the radius value as per your requirements
crad_legF = 60; // Adjust the radius value as per your requirements
crad_legB = 60; // Adjust the radius value as per your requirements
crad_jet = 40; // Adjust the radius value as per your requirements

cdir_head = image_angle+90;
cdir_jet = image_angle+180;
cdir_eyes = image_angle+55;
cdir_armF = image_angle+130;
cdir_armB = image_angle+65;
cdir_legF = image_angle-120;
cdir_legB = image_angle-90;
}
else
{
crad_head = 60; // Adjust the radius value as per your requirements
crad_eyes = 65; // Adjust the radius value as per your requirements
crad_armF = 37; // Adjust the radius value as per your requirements
crad_armB = 35; // Adjust the radius value as per your requirements
crad_legF = 63; // Adjust the radius value as per your requirements
crad_legB = 62; // Adjust the radius value as per your requirements
crad_jet = 40; // Adjust the radius value as per your requirements

cdir_head = image_angle+90;
cdir_jet = image_angle;
cdir_eyes = image_angle+125;
cdir_armF = image_angle+45;
cdir_armB = image_angle+110;
cdir_legF = image_angle-70;
cdir_legB = image_angle-90;
}

// find "length" of circle:
clen_head = crad_head * pi * 2;
clen_jet = crad_jet * pi * 2;
clen_eyes = crad_head * pi * 2;
clen_armF = crad_armF * pi * 2;
clen_armB = crad_armB * pi * 2;
clen_legF = crad_legF * pi * 2;
clen_legB = crad_legB * pi * 2;



// find next angle on circle:
cnext_head = cdir_head + (3 * 360) / clen_head;
cnext_jet = cdir_jet + (3 * 360) / clen_jet;
cnext_eyes = cdir_eyes + (3 * 360) / clen_eyes;
cnext_armF = cdir_armF + (3 * 360) / clen_armF;
cnext_armB = cdir_armB + (3 * 360) / clen_armB;
cnext_legF = cdir_legF + (3 * 360) / clen_legF;
cnext_legB = cdir_legB + (3 * 360) / clen_legB;
// find coordinates of next point:
nx_head = cx + lengthdir_x(crad_head, cnext_head);
ny_head = cy + lengthdir_y(crad_head, cnext_head);
nx_jet = cx + lengthdir_x(crad_jet, cnext_jet);
ny_jet = cy + lengthdir_y(crad_jet, cnext_jet);
nx_eyes = nx_head + lengthdir_x(crad_eyes, cnext_eyes);
ny_eyes = ny_head + lengthdir_y(crad_eyes, cnext_eyes);
nx_armF = cx + lengthdir_x(crad_armF, cnext_armF);
ny_armF = cy + lengthdir_y(crad_armF, cnext_armF);
nx_armB = cx + lengthdir_x(crad_armB, cnext_armB);
ny_armB = cy + lengthdir_y(crad_armB, cnext_armB);
nx_legF = cx + lengthdir_x(crad_legF, cnext_legF);
ny_legF = cy + lengthdir_y(crad_legF, cnext_legF);
nx_legB = cx + lengthdir_x(crad_legB, cnext_legB);
ny_legB = cy + lengthdir_y(crad_legB, cnext_legB);


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

draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
// Draw the sprites
if (facing_right)
{
	draw_sprite_ext(sprArmArms, image_index, nx_armB, ny_armB, 1, 1, image_angle, -1, 1);
	draw_sprite_ext(sprLeg3, image_index, nx_legB, ny_legB, 1, 1, 0, -1, 1);
    draw_sprite_ext(sprJetBack, image_index, nx_jet, ny_jet, 1, 1, image_angle-(speed/1), -1, 1);
    draw_sprite_ext(sprBody, image_index, body_x, body_y, 1, 1, image_angle, -1, 1);
	draw_sprite_ext(sprHeadSanta, image_index, nx_head, ny_head, 1, 1, image_angle, -1, 1);
    draw_sprite_ext(sprEyes, image_index, nx_eyes, ny_eyes, 1, 1, head_direction, -1, 1);
	draw_sprite_ext(sprArmArms, image_index, nx_armF, ny_armF, 1, 1, armF_dir, -1, 1);
	draw_sprite_ext(sprLeg3, image_index, nx_legF, ny_legF, 1, 1, 0, -1, 1);
}
else
{
	draw_sprite_ext(sprArmArms, image_index, nx_armB, ny_armB, -1, 1, image_angle, -1, 1);
	draw_sprite_ext(sprLeg3, image_index, nx_legB, ny_legB, -1, 1, 0, -1, 1);
    draw_sprite_ext(sprJetBack, image_index, nx_jet, ny_jet, -1, 1, image_angle+(speed/1), -1, 1);
    draw_sprite_ext(sprBody, image_index, body_x, body_y, -1, 1, image_angle, -1, 1);
	draw_sprite_ext(sprHeadSanta, image_index, nx_head, ny_head, -1, 1, image_angle, -1, 1);
    draw_sprite_ext(sprEyes, image_index, nx_eyes, ny_eyes, -1, 1, head_direction, -1, 1);
	draw_sprite_ext(sprArmArms, image_index, nx_armF, ny_armF, -1, 1, armF_dir, -1, 1);
	draw_sprite_ext(sprLeg3, image_index, nx_legF, ny_legF, -1, 1, 0, -1, 1);
	
}



}