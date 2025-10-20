/// objChunk_sky.Create
// Do NOT read tile_size/chunk_w/etc. yet — they aren’t assigned.
// Define a builder we can call later (after fields are set).
build_now = function () {
    // safe to read now (will be called after assignments)
    var TILE   = tile_size;
    var x_left = chunk_x * chunk_w * TILE;

    var cur_t = 0;
    while (cur_t < chunk_w) {
        var w_t = irandom_range(5, 7);
        var h_t = irandom_range(7, 12);
        var d_t = irandom_range(3, 5);
		d_t = max(d_t, 2); // at least 2 tiles deep


        var remaining = max(0, chunk_w - cur_t);
        if (w_t > remaining) {
            if (remaining < 5) break;
            w_t = remaining;
        }

        var cx = x_left + (cur_t + w_t * 0.5) * TILE;
        var cy = roofline_y;

        var inst = instance_create_layer(cx, cy+((12-h_t)*TILE), layer_name, objBuilding_sky);
        with (inst) {
		    TILE            = TILE;
		    building_width  = w_t;
		    building_height = h_t;
		    building_depth  = d_t;
			image_xscale=((building_width*TILE)-TILE/2)/TILE;
			image_yscale=-(building_height-1);

		    // MAKE building_z PIXELS HERE (one-time conversion)
		    building_z      = other.building_z * TILE;

		   // build_style     = 1;// other.build_style;
		    build_downward  = true;
		}

		

        cur_t += w_t + irandom_range(1, 3);
    }
};

// Kick the build to an alarm so assignments can happen first.
alarm[0] = 1;
with (obj_cave_extractor_sky) {
	//_rebuild_mesh_mv();
	alarm[0]=10;
}
