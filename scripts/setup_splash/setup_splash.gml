/// @description setup_splash(sprite);
/// @param sprite
function setup_splash(argument0) {
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
	part_type_life(_id, 30, 60);
	part_type_size(_id, .1, .2, 0, .1);
	part_type_orientation(_id, 0, 360, 0, 5, 0 );
	part_type_direction(_id, 70, 110, 0, 0);
	part_type_speed(_id, 1, 3, 0, 0);
	part_type_gravity(_id, .05, 270);
	partArray_add(_id);
	return(_id);



}
