/// @description build things


/// add_tile_ext = function(_matrix, _width, _height, _sprite, _frame) 
with(objSidewalk){
	
	var _len = array_length(transform_selections);
	
	/// add in all faces
	for(var i = 0; i < _len; i++){
		other.builder.add_tile_ext(transform_selections[i], sprite_width, sprite_height, sprSidewalk, 0);
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