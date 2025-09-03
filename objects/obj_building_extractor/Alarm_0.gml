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

if (build_style==1) {
    // --- params from instance
    var w        = building_width;
    var h        = building_height;
    var d        = building_depth;
    var z_front  = building_z;
	var z_doors  = z_front-1;
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
        var M  = build_drawing_matrix(xx, yy, z_doors /*- z_eps*/, 0, 0, 0);

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
                xR, yGlass2,  xL, yGlass2, true);

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
            var M  = build_drawing_matrix(xx, yy, z_doors /*- z_eps*/, 0, 0, 0);

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



if (build_style==2) {
    // --- params from instance
    var w        = building_width;
    var h        = building_height;
    var d        = building_depth;
    var z_front  = building_z;
	var z_doors  = z_front-1;
   // var TILE     = TILE; // assuming this exists on the instance

    // --- anchor (front face centered on x,y)
    var x0 = x - (w - 1) * 0.5 * TILE;  // leftmost column X
    var y0 = y;                         // ground Y


    // ======================================================
    // FRONT WALL — PASS 1: base wall tiles (use POS, not EXT)
    // ======================================================
    for (var i = 0; i < w; i++) {
        var xx = x0 + i * TILE-32;
		var pythag_corner=sqrt(TILE*TILE+TILE*TILE);
        for (var j = 0; j < h; j++) {
            var yy = y0 - j * TILE;
            var M  = build_drawing_matrix(xx, yy, z_front, 0, 0, 0);
            var Ml  = build_drawing_matrix(xx+TILE, yy, z_front, 0, 135, 0);
            var Mr  = build_drawing_matrix(xx+TILE, yy, z_front+TILE, 0, -135, 0);
            // Full tile in 0..TILE local plane; matches storefront/windows plane
			if (i==0) {
	            other.builder.add_tile_pos(Ml, spr_front, frm_front,
	                0, 0,   pythag_corner, 0,
	                pythag_corner, TILE,   0, TILE);
			} else if (i==w-1) {
	            other.builder.add_tile_pos(Mr, spr_front, frm_front,
	                0, 0,   pythag_corner, 0,
	                pythag_corner, TILE,   0, TILE);
			} else {
	            other.builder.add_tile_pos(M, spr_front, frm_front,
	                0, 0,   TILE, 0,
	                TILE, TILE,   0, TILE);
			}
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

    for (var i = 1; i < w-2; i++) {
        if (i >= w - 1) continue; // skip final col for all glass

        var xx = x0 + i * TILE;
        var yy = y0;                        // ground row (j==0)
        var M  = build_drawing_matrix(xx, yy, z_doors /*- z_eps*/, 0, 0, 0);

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
                xR, yGlass2,  xL, yGlass2, true);

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
    for (var i = 1; i < w-2; i++) {
        if (i >= w - 1) continue; // avoid last column spill

        for (var j = 1; j < h; j++) {
            var keep = hash01(x div TILE, y div TILE, j, i) > 0.15; // ~85% coverage
            if (!keep) continue;

            var xx = x0 + i * TILE;
            var yy = y0 - j * TILE;
            var M  = build_drawing_matrix(xx, yy, z_doors /*- z_eps*/, 0, 0, 0);

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
    for (var k = 1; k < d-1; k++) {
        var zz = z_front + k * TILE;
        for (var j = 0; j < h; j++) {
            var yy = y0 - j * TILE+32;
            var M = build_drawing_matrix(x_left, yy, zz + 32, 0, 90, 0);
            other.builder.add_tile_ext(M, TILE, TILE, spr_side, frm_side);
        }
    }

    // RIGHT WALL: depth × height, yaw -90, flush with right edge
    var x_right = x0 + w * TILE - TILE * 0.5;
    for (var k = 1; k < d-1; k++) {
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
        var xx = x0 + i * TILE - TILE/2;
        for (var k = 0; k < d; k++) {
			
			if (i==0) && (k==0) { //front left
				var zz = z_front + k * TILE;
	            var M = build_drawing_matrix(xx, y_top, zz, 90, 0, 0);
	           // other.builder.add_tile_ext(M, TILE, TILE, spr_roof, frm_roof); }
				other.builder.add_tile_pos(M,spr_roof,frm_roof,0,0-TILE,0+TILE,0-TILE,0+TILE,0,0,0-TILE);
			}
			else if (i==0) && (k==d-1) { //back left
				var zz = z_front + k * TILE;
	            var M = build_drawing_matrix(xx, y_top, zz, -90, 0, 0);
	           // other.builder.add_tile_ext(M, TILE, TILE, spr_roof, frm_roof); }
				
				other.builder.add_tile_pos(M,spr_roof,frm_roof,0+TILE,0+TILE,0+TILE,0,0,0,0+TILE,0+TILE);
			}
			else if (i==w-1) && (k==0) { //front right
				var zz = z_front + k * TILE;
	            var M = build_drawing_matrix(xx, y_top, zz + TILE, 90, 0, 0);
	           // other.builder.add_tile_ext(M, TILE, TILE, spr_roof, frm_roof); }
				other.builder.add_tile_pos(M,spr_roof,frm_roof,0,0,0,0+TILE,0,0+TILE,0+TILE,0);
			}
			else if (i==w-1) && (k==d-1) { //back right
				var zz = z_front + k * TILE;
	            var M = build_drawing_matrix(xx, y_top, zz, 90, 0, 0);
				other.builder.add_tile_pos(M,spr_roof,frm_roof,0,0,0,0-TILE,0,0-TILE,0+TILE,0);
	           // other.builder.add_tile_ext(M, TILE, TILE, spr_roof, frm_roof); 
				}
			else 
			{
	            var zz = z_front + k * TILE;
	            var M = build_drawing_matrix(xx + 32, y_top, zz + 32, 90, 0, 0);
	            other.builder.add_tile_ext(M, TILE, TILE, spr_roof, frm_roof);
			}	
        }
		
    }

    // (Optional) roof lip at front
    var Mlip = build_drawing_matrix(x, y_top, z_front, 0, 0, 0);
    other.builder.add_tile_pos(Mlip, spr_roof, frm_roof, 0,0, 64,0, 64,8, 0,8);
}




if (build_style==3) {
    // --- params from instance
    var w        = building_width;
    var h        = building_height;
    var d        = building_depth;
    var z_front  = building_z;
	var z_doors  = z_front-1;
   // var TILE     = TILE; // assuming this exists on the instance

    // --- anchor (front face centered on x,y)
    var x0 = x - (w - 1) * 0.5 * TILE;  // leftmost column X
    var y0 = y;                         // ground Y


    // ======================================================
    // FRONT WALL — PASS 1: base wall tiles (use POS, not EXT)
    // ======================================================
    for (var i = 0; i < w; i++) {
        var xx = x0 + i * TILE-32;
		var pythag_corner=sqrt(TILE*TILE+TILE*TILE);
		var pythag_corner_1=sqrt((TILE/2)*(TILE/2)+TILE*TILE);
        for (var j = 0; j < h; j++) {
            var yy = y0 - j * TILE;
            var M  = build_drawing_matrix(xx, yy, z_front, 0, 0, 0);
            var Mlback  = build_drawing_matrix(xx+TILE/2, yy, z_front+(TILE*1.5)+TILE, 0, -67.5, 0);
            var Ml  = build_drawing_matrix(xx, yy, z_front+(TILE/2)+TILE, 0, -45, 0);
            var Mlfront  = build_drawing_matrix(xx, yy, z_front+(TILE/2), 0, -22.5, 0);
			
			var Mrback  = build_drawing_matrix(xx, yy, z_front+(TILE*1.5), 0, 67.5, 0);
            var Mr  = build_drawing_matrix(xx, yy, z_front+(TILE/2), 0, 45, 0);
          //  var Mr  = build_drawing_matrix(xx, yy, z_front, 0, 45, 0);
			var Mrfront  = build_drawing_matrix(xx, yy, z_front, 0, 22.5, 0);
			
            
            // Full tile in 0..TILE local plane; matches storefront/windows plane
			if (i==0) {
	            other.builder.add_tile_pos(Mlback, spr_front, frm_front,
	                0, 0,   pythag_corner_1, 0,
	                pythag_corner_1, TILE,   0, TILE);
			} else if (i==1) {
	            other.builder.add_tile_pos(Ml, spr_front, frm_front,
	                0, 0,   pythag_corner, 0,
	                pythag_corner, TILE,   0, TILE);
			} else if (i==2) {
	            other.builder.add_tile_pos(Mlfront, spr_front, frm_front,
	                0, 0,   pythag_corner_1, 0,
	                pythag_corner_1, TILE,   0, TILE);
			} else if (i==w-1) {
	            other.builder.add_tile_pos(Mrback, spr_front, frm_front,
	                0, 0,   pythag_corner_1, 0,
	                pythag_corner_1, TILE,   0, TILE);
					
			} else if (i==w-2) {
	            other.builder.add_tile_pos(Mr, spr_front, frm_front,
	                0, 0,   pythag_corner, 0,
	                pythag_corner, TILE,   0, TILE); 
			} else if (i==w-3) {
	            other.builder.add_tile_pos(Mrfront, spr_front, frm_front,
	                0, 0,   pythag_corner_1, 0,
	                pythag_corner_1, TILE,   0, TILE);
			} else {
	            other.builder.add_tile_pos(M, spr_front, frm_front,
	                0, 0,   TILE, 0,
	                TILE, TILE,   0, TILE);
			}
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

    for (var i = 3; i < w-4; i++) {
        if (i >= w - 1) continue; // skip final col for all glass

        var xx = x0 + i * TILE;
        var yy = y0;                        // ground row (j==0)
        var M  = build_drawing_matrix(xx, yy, z_doors /*- z_eps*/, 0, 0, 0);

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
                xR, yGlass2,  xL, yGlass2, true);

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
    for (var i = 3; i < w-4; i++) {
        if (i >= w - 1) continue; // avoid last column spill

        for (var j = 1; j < h; j++) {
            var keep = hash01(x div TILE, y div TILE, j, i) > 0.15; // ~85% coverage
            if (!keep) continue;

            var xx = x0 + i * TILE;
            var yy = y0 - j * TILE;
            var M  = build_drawing_matrix(xx, yy, z_doors /*- z_eps*/, 0, 0, 0);

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
    var x_left = (TILE/2) + x0 - TILE * 0.5;
    for (var k = 3; k < d-1; k++) {
        var zz = z_front + k * TILE;
        for (var j = 0; j < h; j++) {
            var yy = y0 - j * TILE+32;
            var M = build_drawing_matrix(x_left, yy, zz + 32, 0, 90, 0);
            other.builder.add_tile_ext(M, TILE, TILE, spr_side, frm_side);
        }
    }

    // RIGHT WALL: depth × height, yaw -90, flush with right edge
    var x_right = -(TILE/2) + x0 + w * TILE - TILE * 0.5;
    for (var k = 3; k < d-1; k++) {
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
        var xx = x0 + i * TILE - TILE/2;
        for (var k = 0; k < d; k++) {
			
			if (i==0) && (k==0) { //front left
				var zz = z_front + k * TILE;
	            var M = build_drawing_matrix(xx, y_top, zz, 90, 0, 0);
	           // other.builder.add_tile_ext(M, TILE, TILE, spr_roof, frm_roof); }
				other.builder.add_tile_pos(M,spr_roof,frm_roof,0,0-TILE,0+TILE,0-TILE,0+TILE,0,0,0-TILE);
			}
			else if (i==0) && (k==d-1) { //back left
				var zz = z_front + k * TILE;
	            var M = build_drawing_matrix(xx, y_top, zz + TILE, 90, 0, 0);
	           // other.builder.add_tile_ext(M, TILE, TILE, spr_roof, frm_roof); }
				
				other.builder.add_tile_pos(M,spr_roof,frm_roof,0,0+TILE,0+TILE,0+TILE,0+TILE,0,0,0+TILE);
			}
			else if (i==w-1) && (k==0) { //front right
				var zz = z_front + k * TILE;
	            var M = build_drawing_matrix(xx, y_top, zz + TILE, 90, 0, 0);
	           // other.builder.add_tile_ext(M, TILE, TILE, spr_roof, frm_roof); }
				other.builder.add_tile_pos(M,spr_roof,frm_roof,0,0,0,0+TILE,0,0+TILE,0+TILE,0);
			}
			else if (i==w-1) && (k==d-1) { //back right
				var zz = z_front + k * TILE;
	            var M = build_drawing_matrix(xx, y_top, zz, 90, 0, 0);
				other.builder.add_tile_pos(M,spr_roof,frm_roof,0,0,0,0-TILE,0,0-TILE,0+TILE,0);
	           // other.builder.add_tile_ext(M, TILE, TILE, spr_roof, frm_roof); 
				}
			else 
			{
	            var zz = z_front + k * TILE;
	            var M = build_drawing_matrix(xx + 32, y_top, zz + 32, 90, 0, 0);
	            other.builder.add_tile_ext(M, TILE, TILE, spr_roof, frm_roof);
			}	
        }
		
    }

    // (Optional) roof lip at front
    var Mlip = build_drawing_matrix(x, y_top, z_front, 0, 0, 0);
    other.builder.add_tile_pos(Mlip, spr_roof, frm_roof, 0,0, 64,0, 64,8, 0,8);
}


/*
if (build_style==2) {
   with (objBuilding_new) {
    // --- params from instance
    var w        = building_width;
    var h        = building_height;
    var d        = building_depth;
    var z_front  = building_z;
   // var TILE     = TILE;

    // --- anchor (front face centered on x,y)
    var x0 = x - (w - 1) * 0.5 * TILE;  // leftmost column world X
    var y0 = y;                          // ground world Y

    // --- helpers
    function hash01(a,b,c,d) {
        var xh = (a * 73856093) ^ (b * 19349663) ^ (c * 83492791) ^ (d * 2654435761);
        xh = (xh ^ (xh << 13)) & $ffffffff;
        xh = (xh ^ (xh >> 17)) & $ffffffff;
        xh = (xh ^ (xh << 5 )) & $ffffffff;
        return (xh & $7fffffff) / 2147483647;
    }
    function _clamp(v,a,b){ return max(a, min(b, v)); }

    // If your tiles needed a -32 previously, set this to -TILE*0.5
    var center_bias = 0;

    // ======================================================
    // FRONT WALL — PASS 1: base wall tiles (use POS so planes match glass)
    // (Skip edge columns visually? No—draw full front; glass will skip edges.)
    // ======================================================
    for (var i = 0; i < w; i++) {
        var xx = x0 + i * TILE + center_bias;
        for (var j = 0; j < h; j++) {
            var yy = y0 - j * TILE;
            var M  = build_drawing_matrix(xx, yy, z_front, 0, 0, 0);
            other.builder.add_tile_pos(M, spr_front, frm_front,
                0, 0,   TILE, 0,
                TILE, TILE,   0, TILE);
        }
    }

    // ======================================================
    // FRONT CORNER WEDGES (45° each)
    // ======================================================
    // Planes where your straight side walls would be:
    var x_left_plane  = x0 - TILE * 0.5;                 // left side wall plane X
    var x_right_plane = x0 + w * TILE - TILE * 0.5;      // right side wall plane X
    var z_front_plane = z_front;

    // Offset so a TILE×TILE face rotated 45° lines up with both planes
    var o = TILE * 0.5 * 0.70710678; // TILE/2 * sqrt(2)/2

    // FRONT-LEFT corner wedge (+45° yaw)
    for (var j = 0; j < h; j++) {
        var yy = y0 - j * TILE;
        // center of face sits o inward on X and Z from the true corner seam
        var M  = build_drawing_matrix(x_left_plane + o, yy, z_front_plane + o, 0, 45, 0);
        other.builder.add_tile_ext(M, TILE, TILE, spr_side, frm_side);
    }

    // FRONT-RIGHT corner wedge (−45° yaw)
    for (var j = 0; j < h; j++) {
        var yy = y0 - j * TILE;
        var M  = build_drawing_matrix(x_right_plane - o, yy, z_front_plane + o, 0, -45, 0);
        other.builder.add_tile_ext(M, TILE, TILE, spr_side, frm_side);
    }

    // ======================================================
    // FRONT WALL — PASS 2: ground-floor storefront (overlay, SKIP EDGES)
    // ======================================================
    var frame_px     = 4;
    var kickplate_px = 12;
    var transom_px   = 12;

    // Choose a door column within [1, w-2] so it won't collide with wedges
    var center_col = round((w - 1) * 0.5);
    var bias       = floor(lerp(-1, 1, hash01(x div TILE, y div TILE, 11, 0))); // -1/0/1
    var min_col    = (w >= 3) ? 1 : 0;
    var max_col    = (w >= 3) ? (w - 2) : max(0, w-1);
    var door_col   = clamp(center_col + bias, min_col, max_col);

    for (var i = 1; i < w-1; i++) { // skip i=0 and i=w-1 for glass
        var xx = x0 + i * TILE + center_bias;
        var yy = y0;
        var M  = build_drawing_matrix(xx, yy, z_front, 0, 0, 0);

        var xL = frame_px;
        var xR = TILE - frame_px;

        if (i == door_col) {
            var yKick1  = frame_px;
            var yKick2  = frame_px + kickplate_px;
            var yTr2    = TILE - frame_px;
            var yTr1    = yTr2 - transom_px;
            var yGlass1 = yKick2;
            var yGlass2 = yTr1;

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

    // ======================================================
    // FRONT WALL — PASS 3: upper-floor windows (overlay, SKIP EDGES)
    // ======================================================
    for (var i = 1; i < w-1; i++) {
        for (var j = 1; j < h; j++) {
            var keep = hash01(x div TILE, y div TILE, j, i) > 0.15;
            if (!keep) continue;

            var xx = x0 + i * TILE + center_bias;
            var yy = y0 - j * TILE;
            var M  = build_drawing_matrix(xx, yy, z_front, 0, 0, 0);

            var wm_l = 10, wm_r = 10, wm_t = 12, wm_b = 16;
            var x1 = wm_l,         y1 = wm_t;
            var x2 = TILE - wm_r,  y2 = TILE - wm_b;

            y1 = _clamp(y1, 0, TILE);
            y2 = _clamp(y2, 0, TILE);

            other.builder.add_tile_pos(M, spr_window, frm_window,
                x1, y1,  x2, y1,
                x2, y2,  x1, y2);

            // Mid-rail (optional)
            var rail_h = 4;
            var rail_y = _clamp(lerp(y1, y2, 0.52), 0, TILE);
            other.builder.add_tile_pos(M, spr_front, frm_front,
                x1, rail_y - rail_h*0.5,  x2, rail_y - rail_h*0.5,
                x2, rail_y + rail_h*0.5,  x1, rail_y + rail_h*0.5);
        }
    }

    // ======================================================
    // SIDE WALLS — start at depth k=1 (hex wedge occupied k=0)
    // ======================================================
    var x_left  = x_left_plane;   // same planes as above
    var x_right = x_right_plane;

    for (var k = 1; k < d; k++) {                 // LEFT
        var zz = z_front + k * TILE;
        for (var j = 0; j < h; j++) {
            var yy = y0 - j * TILE;
            var M  = build_drawing_matrix(x_left, yy, zz + 32, 0, 90, 0);
            other.builder.add_tile_ext(M, TILE, TILE, spr_side, frm_side);
        }
    }

    for (var k = 1; k < d; k++) {                 // RIGHT
        var zz = z_front + k * TILE;
        for (var j = 0; j < h; j++) {
            var yy = y0 - j * TILE;
            var M  = build_drawing_matrix(x_right, yy, zz + 32, 0, -90, 0);
            other.builder.add_tile_ext(M, TILE, TILE, spr_side, frm_side);
        }
    }

    // ======================================================
    // ROOF (unchanged). If you want matching hex caps, say the word.
    // ======================================================
    var y_top = y0 - h * TILE + 32;
    for (var i = 0; i < w; i++) {
        var xx = x0 + i * TILE + center_bias;
        for (var k = 0; k < d; k++) {
            var zz = z_front + k * TILE;
            var M  = build_drawing_matrix(xx, y_top, zz + 32, 90, 0, 0);
            other.builder.add_tile_ext(M, TILE, TILE, spr_roof, frm_roof);
        }
    }

    // (Optional) roof lip at front
    var Mlip = build_drawing_matrix(x, y_top, z_front, 0, 0, 0);
    other.builder.add_tile_pos(Mlip, spr_roof, frm_roof, 0,0, 64,0, 64,8, 0,8);
   }

} //end build_style == 2
*/
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

///
// BEACH LEVEL
///
with (obj_tree3D_infinite) {
		var _len = array_length(transform_selections);
	
	/// add in all faces
	for(var i = 0; i < _len; i++){
		var _pos = position_update[i];
		if(_pos == -1){
			other.builder.add_tile_ext(transform_selections[i], sprite_width, sprite_height, sprPalmTree_parts, transform_index[i]);
		} else {
			// add_tile_pos(_matrix, _sprite, _frame, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4)
			other.builder.add_tile_pos(transform_selections[i], sprPalmTree_parts, transform_index[i], 
				_pos[0],_pos[1],_pos[2],_pos[3],_pos[4],_pos[5],_pos[6],_pos[7]
			);
		}
		/*
	  if (transom_px > 0) {
                other.builder.add_tile_pos(M, spr_store_glass, frm_store_glass, xL, yTr1,  xR, yTr1, xR, yTr2,  xL, yTr2);
            }
			*/
	}
}




with(obj_block3D_infinite){
	
	var _len = array_length(transform_selections);
	
	/// add in all faces
	for(var i = 0; i < _len; i++){
		var _pos = position_update[i];
		if(_pos == -1){
			other.builder.add_tile_ext(transform_selections[i], sprite_width, sprite_height, sprite, transform_index[i]);
		} /*else if (_pos!=0){
			// add_tile_pos(_matrix, _sprite, _frame, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4)
			other.builder.add_tile_pos(transform_selections[i], spriteBG, transform_index[i], 
				_pos[0],_pos[1],_pos[2],_pos[3],_pos[4],_pos[5],_pos[6],_pos[7]
			);
		}*/ else {
			// add_tile_pos(_matrix, _sprite, _frame, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4)
			other.builder.add_tile_pos(transform_selections[i], sprite, transform_index[i], 
				_pos[0],_pos[1],_pos[2],_pos[3],_pos[4],_pos[5],_pos[6],_pos[7]
			);
		}
		
	}
	/*
	  if (transom_px > 0) {
                other.builder.add_tile_pos(M, spr_store_glass, frm_store_glass, xL, yTr1,  xR, yTr1, xR, yTr2,  xL, yTr2);
            }
			*/
}


builder.build(sprSidewalk);