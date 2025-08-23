function scr_building_skyline(){

/// City row generator
 TILE = 64;
 Y_BUILD = 3584;       // your fixed ground Y
 layer_name = "InstancesBuildings"; // adjust to your layer

var tiles_total   = floor(room_width / TILE);

// Optional: padding on both edges so you don’t touch the walls
var left_pad_t    = irandom_range(3,5);
var right_pad_t   = irandom_range(3,5);

// The minimum gap we promise to leave at the end; keeps last building off the edge
var end_safety_t  = 3;

// Start cursor in tiles
var cur_t = left_pad_t;

while (true) {
    // Random building params (in tiles)
    var w_t = irandom_range(5, 7);    // width (columns)
    var h_t = irandom_range(7, 11);   // height (floors)
    var d_t = irandom_range(3, 5);    // depth (tiles)
    
    // Random gap AFTER this building (in tiles)
    var gap_t = irandom_range(1, 3);

    // If this building would overflow the row, try to shrink width once…
    var max_w_fit = max(0, tiles_total - right_pad_t - end_safety_t - cur_t);
    if (w_t > max_w_fit) {
        // If shrinking still can’t fit, we’re done
        if (max_w_fit < 5) break;
        w_t = clamp(w_t, 5, max_w_fit);
    }

    // Compute center X (pixels) for this building
    var cx = (cur_t + w_t * 0.5) * TILE;
    var cy = Y_BUILD;

    // Random Z **in tiles** → convert to pixels
    var z_front_t = irandom_range(5, 15);
    var z_front_px = z_front_t;// * TILE;

    // Random style (1=flat front, 2=45° corner variant—hook this into your draw)
    var style = choose(1, 2);

    // Spawn the building
    var inst = instance_create_layer(cx, cy, layer_name, objBuilding_new);
    with (inst) {
        // pass params to the building
        TILE            = TILE;         // keep its local TILE in sync
        building_width  = w_t;
        building_height = h_t;
        building_depth  = d_t;
        building_z      = z_front_px;
        build_style     = style;
    }

    // Advance cursor by this building + gap
    cur_t += w_t + gap_t;

    // Stop if we don’t have space for even the minimum building (5 tiles) + right safety
    if (cur_t + 5 + right_pad_t + end_safety_t > tiles_total) break;
}


}



function scr_building_skyline_bg(_y,_z,_w,_h,_d,_padl,_padr,_cur_t,_end_gap){

//scr_building_skyline_bg(3584,irandom_range(5, 15),irandom_range(5, 7),irandom_range(7, 11),irandom_range(3, 5),irandom_range(1,2),irandom_range(1,2),-3,-3)

/// City row generator
 TILE = 64;
 Y_BUILD = _y;       // your fixed ground Y
 layer_name = "InstancesBuildings"; // adjust to your layer

var tiles_total   = floor(room_width / TILE);

// Optional: padding on both edges so you don’t touch the walls
var left_pad_t    = _padl;
var right_pad_t   = _padr;

// The minimum gap we promise to leave at the end; keeps last building off the edge
var end_safety_t  = _end_gap;

// Start cursor in tiles
var cur_t = _cur_t;

while (true) {
    // Random building params (in tiles)
    var w_t = _w;    // width (columns)
    var h_t = _h;   // height (floors)
    var d_t = _d;    // depth (tiles)
    
    // Random gap AFTER this building (in tiles)
    var gap_t = irandom_range(3, 5);

    // If this building would overflow the row, try to shrink width once…
    var max_w_fit = max(0, tiles_total - right_pad_t - end_safety_t - cur_t);
    if (w_t > max_w_fit) {
        // If shrinking still can’t fit, we’re done
        if (max_w_fit < 5) break;
        w_t = clamp(w_t, 5, max_w_fit);
    }

    // Compute center X (pixels) for this building
    var cx = (cur_t + w_t * 0.5) * TILE;
    var cy = Y_BUILD;

    // Random Z **in tiles** → convert to pixels
    var z_front_t = _z;
    var z_front_px = z_front_t;// * TILE;

    // Random style (1=flat front, 2=45° corner variant—hook this into your draw)
    var style = choose(1, 2);

    // Spawn the building
    var inst = instance_create_layer(cx, cy, layer_name, objBuilding_new);
    with (inst) {
        // pass params to the building
        TILE            = TILE;         // keep its local TILE in sync
        building_width  = w_t;
        building_height = h_t;
        building_depth  = d_t;
        building_z      = z_front_px;
        build_style     = style;
    }

    // Advance cursor by this building + gap
    cur_t += w_t + gap_t;

    // Stop if we don’t have space for even the minimum building (5 tiles) + right safety
    if (cur_t + 1 + right_pad_t + end_safety_t > tiles_total) break;
}


}