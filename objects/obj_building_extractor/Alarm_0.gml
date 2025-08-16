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



with (objBuilding_new) {
      //  var TILE = TILE; // from instance
        var w = building_width;
        var h = building_height;
        var d = building_depth;
        var z_front = building_z;

        // World anchor for the front wall:
        // center the front facade on (x,y), columns extend left/right in X,
        // floors stack upward in Y, front face sits at z_front.
        var x0 = x - (w - 1) * 0.5 * TILE;  // leftmost column X
        var y0 = y;                         // ground Y

        // FRONT WALL: w × h, facing street (rotX = 90)
        for (var i = 0; i < w; i++) {
            var xx = x0 + i * TILE;
            for (var j = 0; j < h; j++) {
                var yy = y0 - j * TILE;
                var M = build_drawing_matrix(xx, yy, z_front, 0, 0, 0);
                other.builder.add_tile_ext(M, TILE, TILE, spr_front, frm_front);
            }
        }

        // LEFT WALL: depth × height, yaw +90 (faces right), flush with left edge
        var x_left = x0 - TILE * 0.5;
        for (var k = 0; k < d; k++) {
            var zz = z_front + k * TILE; // go “back” in -Z
            for (var j = 0; j < h; j++) {
                var yy = y0 - j * TILE;
                var M = build_drawing_matrix(x_left, yy, zz+32, 0, 90, 0);
                other.builder.add_tile_ext(M, TILE, TILE, spr_side, frm_side);
            }
        }

        // RIGHT WALL: depth × height, yaw -90 (faces left), flush with right edge
        var x_right = x0 + w * TILE - TILE * 0.5;
        for (var k = 0; k < d; k++) {
            var zz = z_front + k * TILE;
            for (var j = 0; j < h; j++) {
                var yy = y0 - j * TILE;
                var M = build_drawing_matrix(x_right, yy, zz+32, 0, -90, 0);
                other.builder.add_tile_ext(M, TILE, TILE, spr_side, frm_side);
            }
        }

        // ROOF: w × d, flat at the top
        var y_top = y0 - h * TILE + 32;
        for (var i = 0; i < w; i++) {
            var xx = x0 + i * TILE;
            for (var k = 0; k < d; k++) {
                var zz = z_front + k * TILE;
                var M = build_drawing_matrix(xx, y_top, zz+32, 90, 0, 0);
                other.builder.add_tile_ext(M, TILE, TILE, spr_roof, frm_roof);
            }
        }

        // (Optional) roof lip at the front using a thin quad:
        // var Mlip = build_drawing_matrix(x, y_top, z_front, 0, 0, 0);
        // other.builder.add_tile_pos(Mlip, spr_roof, frm_roof, 0,0, 64,0, 64,8, 0,8);
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