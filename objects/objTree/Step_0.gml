/// @description  CALCULATE DEPTH AND SCALE

// SET SCALE BASED ON THE POSITION OF THE FOLLOWED OBJECT

my_scale = min_scale+(((obj_to_follow.y+my_distance)/max_distance)*factor);


// MAKE SURE SCALE IS NOT OUTSIDE OF THE RANGE SET IN THE CREATE EVENT

my_scale = min(my_scale,max_scale);
my_scale = max(my_scale,min_scale);

// SET DRAW DEPTH TO MAKE OBJECTS CLOSER TO THE BOTTOM OF THE SCREEN DRAW LAST

depth = -y+32;

