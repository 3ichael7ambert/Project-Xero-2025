/// @description build things


/// add_tile_ext = function(_matrix, _width, _height, _sprite, _frame) 
with(objSidewalk){
	
	var _len = array_length(transform_selections);
	
	/// add in all faces
	for(var i = 0; i < _len; i++){
		var _pos = position_update[i];
		if(_pos == -1){
			other.builder.add_tile_ext(transform_selections[i], sprite_width, sprite_height, sprSidewalk, transform_index[i]);
		} else {
			// add_tile_pos(_matrix, _sprite, _frame, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4)
			other.builder.add_tile_pos(transform_selections[i], sprSidewalk, transform_index[i], 
				_pos[0],_pos[1],_pos[2],_pos[3],_pos[4],_pos[5],_pos[6],_pos[7]
			);
		}
		
	}
	
}


/// BUILDING DRAW BUILD (faces + storefront + windows)
with (objBuilding_new) {

    // --- params from instance
    var w        = building_width;
    var h        = building_height;
    var d        = building_depth;
    var z_front  = building_z;
   // var TILE     = TILE; // assuming this exists on the instance

    // --- anchor (front face centered on x,y)
    var x0 = x - (w - 1) * 0.5 * TILE;  // leftmost column X
    var y0 = y;                         // ground Y


    // ======================================================
    // FRONT WALL — PASS 1: base wall tiles (use POS, not EXT)
    // ======================================================
    for (var i = 0; i < w; i++) {
        var xx = x0 + i * TILE-32;
        for (var j = 0; j < h; j++) {
            var yy = y0 - j * TILE;
            var M  = build_drawing_matrix(xx, yy, z_front, 0, 0, 0);

            // Full tile in 0..TILE local plane; matches storefront/windows plane
            other.builder.add_tile_pos(M, spr_front, frm_front,
                0, 0,   TILE, 0,
                TILE, TILE,   0, TILE);
        }
    }

    // ------------------------------------------------------
    // FRONT WALL — PASS 2: ground-floor storefront (overlay)
    // ------------------------------------------------------
    var frame_px     = 4;
    var kickplate_px = 12;
    var transom_px   = 12;

    // Choose a door column, never the very last column
    var center_col = round((w - 1) * 0.5);
    var bias       = floor(lerp(-1, 1, hash01(x div TILE, y div TILE, 11, 0))); // -1/0/1
    var min_col    = 0;
    var max_col    = max(0, w - 2); // <= w-2 avoids right-edge spill
    var door_col   = clamp(center_col + bias, min_col, max_col);

    // Optional: z-bias to avoid z-fighting with wall
    // var z_eps = 0.25;

    for (var i = 0; i < w; i++) {
        if (i >= w - 1) continue; // skip final col for all glass

        var xx = x0 + i * TILE;
        var yy = y0;                        // ground row (j==0)
        var M  = build_drawing_matrix(xx, yy, z_front /*- z_eps*/, 0, 0, 0);

        var xL = frame_px;
        var xR = TILE - frame_px;

        if (i == door_col) {
            // Bottom-anchored bands
            var yKick1  = frame_px;
            var yKick2  = frame_px + kickplate_px;
            var yTr2    = TILE - frame_px;
            var yTr1    = yTr2 - transom_px;
            var yGlass1 = yKick2;
            var yGlass2 = yTr1;

            // clamp for safety
            yKick1  = _clamp(yKick1,  0, TILE);
            yKick2  = _clamp(yKick2,  0, TILE);
            yTr1    = _clamp(yTr1,    0, TILE);
            yTr2    = _clamp(yTr2,    0, TILE);
            yGlass1 = _clamp(yGlass1, 0, TILE);
            yGlass2 = _clamp(yGlass2, 0, TILE);

            // Door glass
            other.builder.add_tile_pos(M, spr_door, frm_door,
                xL, yGlass1,  xR, yGlass1,
                xR, yGlass2,  xL, yGlass2);

            // Kickplate
            if (kickplate_px > 0) {
                other.builder.add_tile_pos(M, spr_store_glass, frm_store_glass,
                    xL, yKick1,  xR, yKick1,
                    xR, yKick2,  xL, yKick2);
            }

            // Transom
            if (transom_px > 0) {
                other.builder.add_tile_pos(M, spr_store_glass, frm_store_glass,
                    xL, yTr1,  xR, yTr1,
                    xR, yTr2,  xL, yTr2);
            }

        } else {
            // Large storefront pane
            var yKick1 = frame_px;
            var yKick2 = frame_px + kickplate_px;
            var yTr2   = TILE - frame_px;
            var yTr1   = yTr2 - transom_px;

            yKick1 = _clamp(yKick1, 0, TILE);
            yKick2 = _clamp(yKick2, 0, TILE);
            yTr1   = _clamp(yTr1,   0, TILE);
            yTr2   = _clamp(yTr2,   0, TILE);

            // Main glass
            other.builder.add_tile_pos(M, spr_store_glass, frm_store_glass,
                xL, yKick2,  xR, yKick2,
                xR, yTr1,    xL, yTr1);

            // Kickplate
            if (kickplate_px > 0) {
                other.builder.add_tile_pos(M, spr_store_glass, frm_store_glass,
                    xL, yKick1,  xR, yKick1,
                    xR, yKick2,  xL, yKick2);
            }

            // Transom
            if (transom_px > 0) {
                other.builder.add_tile_pos(M, spr_store_glass, frm_store_glass,
                    xL, yTr1,  xR, yTr1,
                    xR, yTr2,  xL, yTr2);
            }

            // Optional center mullion
            var mull  = frame_px;
            var midxL = (TILE * 0.5) - mull * 0.5;
            var midxR = (TILE * 0.5) + mull * 0.5;
            other.builder.add_tile_pos(M, spr_front, frm_front,
                midxL, yKick2,  midxR, yKick2,
                midxR, yTr1,    midxL, yTr1);
        }
    }

    // ------------------------------------------------------
    // FRONT WALL — PASS 3: upper-floor windows (overlay)
    // ------------------------------------------------------
    for (var i = 0; i < w; i++) {
        if (i >= w - 1) continue; // avoid last column spill

        for (var j = 1; j < h; j++) {
            var keep = hash01(x div TILE, y div TILE, j, i) > 0.15; // ~85% coverage
            if (!keep) continue;

            var xx = x0 + i * TILE;
            var yy = y0 - j * TILE;
            var M  = build_drawing_matrix(xx, yy, z_front /*- z_eps*/, 0, 0, 0);

            var wm_l = 10, wm_r = 10, wm_t = 12, wm_b = 16;
            var x1 = wm_l,         y1 = wm_t;
            var x2 = TILE - wm_r,  y2 = TILE - wm_b;

            y1 = _clamp(y1, 0, TILE);
            y2 = _clamp(y2, 0, TILE);

            other.builder.add_tile_pos(M, spr_window, frm_window,
                x1, y1,  x2, y1,
                x2, y2,  x1, y2);

            // Optional mid-rail
            var rail_h = 4;
            var rail_y = _clamp(lerp(y1, y2, 0.52), 0, TILE);
            other.builder.add_tile_pos(M, spr_front, frm_front,
                x1, rail_y - rail_h*0.5,  x2, rail_y - rail_h*0.5,
                x2, rail_y + rail_h*0.5,  x1, rail_y + rail_h*0.5);
        }
    }

    // ==========================
    // LEFT / RIGHT / ROOF (same)
    // ==========================
    // LEFT WALL: depth × height, yaw +90, flush with left edge
    var x_left = x0 - TILE * 0.5;
    for (var k = 0; k < d; k++) {
        var zz = z_front + k * TILE;
        for (var j = 0; j < h; j++) {
            var yy = y0 - j * TILE+32;
            var M = build_drawing_matrix(x_left, yy, zz + 32, 0, 90, 0);
            other.builder.add_tile_ext(M, TILE, TILE, spr_side, frm_side);
        }
    }

    // RIGHT WALL: depth × height, yaw -90, flush with right edge
    var x_right = x0 + w * TILE - TILE * 0.5;
    for (var k = 0; k < d; k++) {
        var zz = z_front + k * TILE;
        for (var j = 0; j < h; j++) {
            var yy = y0 - j * TILE+32;
            var M = build_drawing_matrix(x_right, yy, zz + 32, 0, -90, 0);
            other.builder.add_tile_ext(M, TILE, TILE, spr_side, frm_side);
        }
    }

    // ROOF: w × d, flat at the top
    var y_top = y0 - h * TILE + 64;
    for (var i = 0; i < w; i++) {
        var xx = x0 + i * TILE;
        for (var k = 0; k < d; k++) {
            var zz = z_front + k * TILE;
            var M = build_drawing_matrix(xx, y_top, zz + 32, 90, 0, 0);
            other.builder.add_tile_ext(M, TILE, TILE, spr_roof, frm_roof);
        }
    }

    // (Optional) roof lip at front
    var Mlip = build_drawing_matrix(x, y_top, z_front, 0, 0, 0);
    other.builder.add_tile_pos(Mlip, spr_roof, frm_roof, 0,0, 64,0, 64,8, 0,8);
}



/*
with(objBuilding_back){
	var _len = array_length(transform_selections);
	
	/// add in all faces
	for(var i = 0; i < _len; i++){
		other.builder.add_tile_ext(transform_selections[i], sprite_width, sprite_height, sprSidewalk, 0);
	}
}
*/
//instance_destroy(objSidewalk);


/// finish up
builder.build(sprSidewalk);