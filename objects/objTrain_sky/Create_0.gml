/// objBuilding_sky.Create — per-building params only
event_inherited();
randomize();

scene="train";
/*
TILE = 64;

// default footprint (can be overridden by spawner)

//building_width  = irandom_range(5, 7);
//building_height = irandom_range(7, 11);
building_width  = irandom_range(6, 6);
building_height = irandom_range(7, 7);
building_depth  = irandom_range(3, 5);
building_z      = -10;

// choose façade set
build_style = 1;//choose(1,2,3);

// frames/styles (replace with your atlases)
building_style = irandom_range(0,13);
roof_style     = irandom_range(0,13);
window_style   = irandom_range(0,2);
door_style     = irandom_range(0,16);
window_front_style = irandom_range(0,2);
*/
spr_front   = sprTrain;   frm_front   = 0;
spr_side    = sprTrain;   frm_side    = 2;
spr_roof    = sprTrain;    frm_roof    = 1;




show_debug_message($"train xscale {image_xscale }, yscale { image_yscale}");
