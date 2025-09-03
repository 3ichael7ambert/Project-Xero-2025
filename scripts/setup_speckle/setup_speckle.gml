/// @description setup_speckle(sprite);
/// @param sprite
function setup_speckle(argument0) {
	/*
	Created by: Rayu Johnson
	This function creates a particle type: speckle
	*/
	var _id, _spr;
	_id = part_type_create();
	_spr = argument0;

	part_type_sprite(_id, _spr, 1, 1, 0);
	/*
	healing crosses
	*/
	part_type_life(_id, 10, 40);
	part_type_size(_id, 1, 1, 0, .15);
	part_type_direction(_id, 90, 90, 0, 0);
	part_type_speed(_id, 1, 2, -.1, 0);
	part_type_direction(_id, 0, 360, 0, 0);
	partArray_add(_id);
	return(_id);



}
