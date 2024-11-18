image_angle=0;
facing_right = true;

// Set initial variables
hsp = 0; // Horizontal speed
vsp = 0; // Vertical speed
gravity = 0; // Gravity value
jump_speed = -10; // Jump speed

//sprites
sprite_body=sprBody;
sprite_body_offsetX=45;
sprite_body_offsetY=79;
sprite_head=sprHeadSanta;
sprite_armF=sprArmArms;
sprite_legF=sprLeg3;

offsetX=23;
offsetY=56;

var cx, cy, crad, clen, cdir, cnext, nx, ny;

head_offset = 80; // Offset value for the head sprite
arm_offset = 40; // Offset value for the front arm
body_width = sprite_get_width(sprite_index);

transition_speed=5;

jetpack_mode=3;

//gamepad
// Initialize movement variables
move_left = 0;
move_right = 0;
move_up = 0;
move_down = 0;
//direction = 0;


if jetpack_mode=1 
{
angle_head = image_angle;
cx=x;
cy=y;
nx_armB=x;
ny_armB=y;
nx_legB=x;
ny_legB=y;
nx_head=x;
ny_head=y;
nx_body=x;
ny_body=y;

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
}
if jetpack_mode=2 
{
angle_head = image_angle;
cx=x;
cy=y;
nx_armB=x;
ny_armB=y;
nx_legB=x;
ny_legB=y;
nx_head=x;
ny_head=y;
nx_body=x;
ny_body=y;

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
}

if jetpack_mode=3 
{
angle_head = image_angle;
cx=x;
cy=y;
nx_armB=x;
ny_armB=y;
nx_legB=x;
ny_legB=y;
nx_head=x;
ny_head=y;
nx_body=x;
ny_body=y;

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
}
