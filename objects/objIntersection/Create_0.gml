/// @description  SET UP VARIABLES

event_inherited();
// MAXIMUM HEIGHT OF THE CUBOID
max_depth = 256;

// OBJECT TO "FOLLOW"
obj_to_follow = objMazePlayer;

// A FACTOR TO "SLOW DOWN" THE EFFECT, CHANGE THIS TO MAKE THE EFFECT
// MORE DRASTIC

factor = 32;

// INITIALISE OTHER VARIABLES
hdepth = 0;
vdepth = 0;
depth = 200;
/*
if place_empty(x+64,y,objSidewalk) && x<room_width+360
{
	instance_create_layer(x+64,y,"InstancesSidewalk",objSidewalk);
}
*/