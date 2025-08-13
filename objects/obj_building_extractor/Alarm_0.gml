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