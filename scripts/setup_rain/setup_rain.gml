/// @description setup_rain(sprite,death_id);
/// @param sprite
/// @param death_id
function setup_rain(argument0, argument1) {
	/*
	Created by: Rayu Johnson
	This function creates a particle type: splash
	*/
	var _id, _spr, _id2;
	_id = part_type_create();
	_spr = argument0;
	_id2 = argument1;

	part_type_sprite(_id, _spr, 0, 0, 1);
	/*
	splash particle properties
	*/
	part_type_life(_id, 10, 60);
	part_type_size(_id, 1, 1, 0, 0);
	part_type_orientation(_id, 0, 0, 0, 0, 0 );
	part_type_direction(_id, 268, 272, 0, 0);
	part_type_speed(_id, 16, 16, 0, 0);
	part_type_death(_id,1,_id2);
	partArray_add(_id);
	return(_id);



}
