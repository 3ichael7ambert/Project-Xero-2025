/// @description setup_explode(sprite);
/// @param sprite
function setup_explode(argument0) {
	/*
	Created by: Rayu Johnson
	This function creates a particle type: splash
	*/
	var _id, _spr;
	_id = part_type_create();
	_spr = argument0;

	part_type_sprite(_id, _spr, 0, 0, 1);
	/*
	splash particle properties
	*/
	part_type_life(_id, 15, 90);
	part_type_size(_id, .1, .5, 0, 0);
	part_type_orientation(_id, 0, 0, 0, 0, true );
	part_type_direction(_id, 0, 360, 0, 5);
	part_type_speed(_id, 3, 4, 0, 0);
	part_type_alpha3(_id,1,.75,0);
	partArray_add(_id);
	return(_id);



}
