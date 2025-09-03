/// @description setup_crystal(id2,sprite);
/// @param id2
/// @param sprite
function setup_crystal(argument0, argument1) {
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
	part_type_life(_id, 60, 60);
	part_type_size(_id, .1, .2, .01, 0);
	part_type_orientation(_id, 20, 160, 0, 0, 0 );
	part_type_death(_id,12,_id2);
	part_type_colour2(_id,c_blue,c_white);
	part_type_alpha2(_id,1,.5);
	partArray_add(_id);
	return(_id);



}
