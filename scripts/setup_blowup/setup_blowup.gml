/// @description setup_blowup(0-sprite,1-min_life,2-max_life,3-min_scale,4-max_scale,5-scaling,6-move);
/// @param 0-sprite
/// @param 1-min_life
/// @param 2-max_life
/// @param 3-min_scale
/// @param 4-max_scale
/// @param 5-scaling
/// @param 6-move
function setup_blowup() {
	/*
	Created by: Rayu Johnson
	This function creates a particle type: blowup
	*/
	var _values;

	for (var i=0; i<argument_count; i+=1)
	{
	    _values[i+1] = argument[i];
	};
	_values[0] = part_type_create();

	/*
	splash particle properties
	*/
	part_type_alpha2(_values[0], .75, 0);
	part_type_sprite(_values[0],_values[1],false,true,false);
	part_type_life(_values[0], _values[2], _values[3]);
	part_type_size(_values[0], _values[4], _values[5], _values[6], 0);
	part_type_orientation(_values[0], 0, 360, 0, 0, 0 );
	if(_values[7] == true){
	    part_type_direction(_values[0],0,360,0,0);
	    part_type_speed(_values[0],2,2,.01,0);
	}
	part_type_blend(_values[0], true);
	partArray_add(_values[0]);
	return(_values[0]);



}
