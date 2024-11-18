/// @description  SET UP VARIABLES

// MAXIMUM HEIGHT OF THE CUBOID
max_depth = 256;

// OBJECT TO "FOLLOW"
obj_to_follow = objTownPlayer;

// NEW CALCULATION FOR TOWN ROOM "MY_DISTANCE" (ADDS TO THE FOLLOWER'S Y VALUE)
my_distance = 512;

// A FACTOR TO "SLOW DOWN" THE EFFECT, CHANGE THIS TO MAKE THE EFFECT
// MORE DRASTIC

factor = 16;

// INITIALISE OTHER VARIABLES
hdepth = 0;
vdepth = 0;
depth = -y;

