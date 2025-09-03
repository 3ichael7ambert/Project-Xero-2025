/// @description setup_wander(sprite);
/// @param sprite
function setup_wander(argument0) {
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
	part_type_life(_id, 60, 240);
	part_type_size(_id, .1, .5, 0, .1);
	part_type_orientation(_id, 0, 360, 0, 0, 0 );
	part_type_direction(_id, 0, 360, 0, 15);
	part_type_speed(_id, .1, .5, 0, .25);
	//part_type_colour1(_id,c_lime);
	partArray_add(_id);
	return(_id);



}
