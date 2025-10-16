// Put this function in obj_building_extractor (top-level in the instance)
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