// Put this function in obj_building_extractor (top-level in the instance)


// Build a transform for a vertical side wall placed at world (x0,y0),
// shifted by +edge_dx relative to the provider's origin (x0,y0),
// facing "side-on" (no 90° roll). You can tweak yaw to aim left/right.
function __build_side_matrix(_prov, _edge_dx, _yaw_sign) {
    // For a side face, we want the plane to be vertical, so roll=0.
    // We'll face it by yaw (±90).
    var m = build_drawing_matrix(_prov.x, _prov.y, _edge_dx, 0, 0, 90 * _yaw_sign);
    return m;
}

// Quick neighbor check: is there a sibling object exactly one tile away?
function __has_neighbor_x(_prov, _dx, _obj) {
    // Look for any instance of _obj whose x is at prov.x + _dx (±tile_step) and ~same y.
    var inst = instance_position(_prov.x + _dx, _prov.y, _obj);
    return (inst != noone && inst != _prov);
}

// Emit one vertical side wall using the provider's sprite/frame.
// Quad is sprite-space: (0,0)-(w,0)-(w,h)-(0,h)
function __emit_side_wall(_builder, _M, _spr, _frm) {
    var w = sprite_get_width(_spr);
    var h = sprite_get_height(_spr);
    _builder.add_tile_pos(_M, _spr, _frm,  0,0,  w,0,  w,h,  0,h);
}



function _rebuild_mesh_mv() {
   // if (building_now) return;
   // building_now = true;

    // (optional) clear previous batches if your Tile3d supports it:
  //  if (is_undefined(builder.clear) == false) builder.clear();


with(objGround_mv){
	
	var _len = array_length(transform_selections);
	
	/// add in all faces
	for(var i = 0; i < _len; i++){
		var _pos = position_update[i];
		if(_pos == -1){
			obj_cave_extractor_mv.builder.add_tile_ext(transform_selections[i], sprite_width, sprite_height, sprite, transform_index[i]);
		} /*else if (_pos!=0){
			// add_tile_pos(_matrix, _sprite, _frame, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4)
			other.builder.add_tile_pos(transform_selections[i], spriteBG, transform_index[i], 
				_pos[0],_pos[1],_pos[2],_pos[3],_pos[4],_pos[5],_pos[6],_pos[7]
			);
		}*/ else {
			// add_tile_pos(_matrix, _sprite, _frame, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4)
			obj_cave_extractor_mv. builder.add_tile_pos(transform_selections[i], sprite, transform_index[i], 
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

with(objCeil_mv){
	
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

   mesh_dirty = false;
   // building_now = false;
   builder.build(sprSand);
}