/// @description setup_rock(id2,sprite);
/// @param id2
/// @param sprite
function setup_rock(argument0, argument1) {
	/*
	Created by: Rayu Johnson
	This function creates a particle type: splash
	*/
	var _id, _id2, _spr;
	_id = part_type_create();
	_id2 = argument0;
	_spr = argument1;

	part_type_sprite(_id, _spr, 0, 0, 1);
	/*
	splash particle properties
	*/
	part_type_life(_id, 30, 60);
	part_type_size(_id, 1, 1, -.01, 0);
	part_type_orientation(_id, 0, 360, 5, 5, 0 );
	part_type_direction(_id, 85, 95, 0, 5);
	part_type_speed(_id, 5, 5, 0, 0);
	part_type_gravity(_id, .2, 270);
	part_type_step(_id,-2,_id2);
	partArray_add(_id);
	return(_id);



}
