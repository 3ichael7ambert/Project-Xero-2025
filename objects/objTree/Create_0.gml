/// @description  SET UP VARIABLES

// MINIMUM HEIGHT OF THE TREE ON SCREEN
min_scale = 0.3;

// MAXIMUM HEIGHT OF THE TREE ON SCREEN
max_scale = 1;

// OBJECT TO "FOLLOW"
obj_to_follow = objTownPlayer;

// ADDS TO THE FOLLOWER'S Y VALUE
my_distance = -768;

// THE DISTANCE AWAY THE PLAYER SHOULD BE WHEN THE TREE IS FULL SIZE
max_distance = 768;

// FACTOR
factor = max_scale-min_scale;

// INITIALISE OTHER VARIABLES
my_scale = 0;

depth = -y+32;

