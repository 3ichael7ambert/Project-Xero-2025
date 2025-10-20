/// objBuilding_sky.Create — per-building params only
event_inherited();
randomize();

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

spr_front   = sprBuilding_walls;   frm_front   = building_style;
spr_side    = sprBuilding_walls;   frm_side    = building_style;
spr_roof    = sprBuilding_roof;    frm_roof    = roof_style;
spr_window  = sprBuilding_windows; frm_window  = window_style;
spr_door    = sprBuilding_door;    frm_door    = door_style;
spr_store_glass = sprBuilding_windows; frm_store_glass = window_front_style;

// **key:** this tells the builder to flip vertical growth
build_downward = false;

image_xscale=building_width;
image_yscale=-(building_height);
image_indx=irandom(13);


show_debug_message($"xscale {image_xscale }, yscale { image_yscale}");
