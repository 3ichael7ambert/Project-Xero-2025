/// @description  SET UP VARIABLES
randomize();
event_inherited();
//b1,w1,b2,b3,b4,brick1,(brick2),brick3,brick4,w2,wood1,wood2,metal1,wood3,wood4,metal2,window3,


/// Basic per-building config (no drawing here)
TILE = 64;

building_width  = irandom_range(5, 7);   // columns
building_height = irandom_range(7, 11);  // floors
building_depth  = irandom_range(3,5);                     // tiles “back” from the front face
building_z      = 10;                     // base Z for the front face (use 0 unless you have a Z system)


build_style=choose(1,2);
// TEMP: use the same sprite for all parts so they share a texture page.
// Swap these to real building sprites later (then we’ll add auto-batching).
/*
building_style = choose(
						"white1",    //2
						"white2",    //3
						"greyBlock", //4
						"redBrick",  //5
						"redGreyBrick", //6
						"blueBrick", //7
						"greyBrick", //8
						"wood1", //10
						"wood2", //11
						"steelGrid", //12
						"wood3",  //13
						"darkWood",  //14
						"metalBBumps" //15
						);
window_style = choose(
						"glass1",    //1
						"glass2",    //9
						"glass3", //16
						);
*/
building_style=irandom_range(0,13);
roof_style=irandom_range(0,13);
window_style=irandom_range(0,2);
door_style=irandom_range(0,16);
window_front_style = irandom_range(0,2);

spr_front = sprBuilding_walls;  frm_front = building_style;   // facade frame
spr_side  = sprBuilding_walls;  frm_side  = building_style;   // side wall frame
spr_roof  = sprBuilding_roof;  frm_roof  = roof_style;  // roof frame
spr_window = sprBuilding_windows; frm_window  = window_style;
spr_door = sprBuilding_door;	  frm_door  = door_style;

spr_store_glass = sprBuilding_windows; frm_store_glass = window_front_style;




/*
fenceMatrix = build_drawing_matrix_scale(x,y-32,300,0,0,0,1,1,10);

swMatrix1 = build_drawing_matrix(x,y,300,90,0,0);
swMatrix2 = build_drawing_matrix(x,y,236,90,0,0);
swMatrix3 = build_drawing_matrix(x,y,172,90,0,0);
swMatrix4 = build_drawing_matrix(x,y,128,90,0,0);
swMatrix5 = build_drawing_matrix(x,y,64,90,0,0);
swMatrix6 = build_drawing_matrix(x,y,0,90,0,0);
swMatrix7 = build_drawing_matrix(x,y,-64,90,0,0);

//swMatrixCurb = build_drawing_matrix(x,y,-128,0,0,0);
swMatrixCurb = build_drawing_matrix_scale(x+32,y,-96,0,0,0,1,1,1);

//draw_sprite_3d_pos(sprSidewalk,0,swMatrixCurb,0,0,64,0,64,8,0,8);

swMatrixStreet = build_drawing_matrix(x,y+8,-128,90,0,0);

transform_selections = [
	fenceMatrix,swMatrix1,swMatrix2,swMatrix3,swMatrix4,swMatrix5,swMatrix6,swMatrix7,swMatrixCurb,swMatrixStreet
];

transform_index = array_create(10, 0);
transform_index[0] = 6; //fence
transform_index[8] = 0; //curb
transform_index[9] = 12; //steet

// draw_sprite_3d_pos(sprSidewalk,0,swMatrixCurb,0,0,64,0,64,8,0,8);
position_update = array_create(10, -1);
position_update[8] = [0,0,64,0,64,8,0,8];