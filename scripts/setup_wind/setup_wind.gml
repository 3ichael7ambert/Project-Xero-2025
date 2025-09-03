/// @description  setup_wind(id2,sprite);
/// @param id2
/// @param sprite
function setup_wind(argument0, argument1) {
	/*
	Created by: Rayu Johnson
	This function creates a particle type: splash
	*/
	var _id, _id2;
	_id = part_type_create();
	_id2 = argument0;

	part_type_sprite(_id,argument1,0,0,1);
	part_type_colour3(_id,c_white,c_blue,c_white);
	part_type_direction(_id,135,135,-20,5);
	part_type_speed(_id,3,3,.5,0);
	part_type_size(_id,.5,.5,0,.5);
	part_type_life(_id, 60, 60);
	part_type_step(_id, 3, _id2);
	partArray_add(_id);
	return(_id);



}
