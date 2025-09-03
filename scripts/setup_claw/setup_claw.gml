/// @description setup_claw(sprite);
/// @param sprite
function setup_claw(argument0) {
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
	part_type_life(_id, 35, 35);
	part_type_orientation(_id, 0, 0, 0, 0, true);
	part_type_speed(_id, 2, 2, .05, 0);
	part_type_direction(_id, 30, 60, 5, 0);
	part_type_alpha3(_id,1,.5,0);
	part_type_size(_id,.2,.2,.02,0);
	partArray_add(_id);
	return(_id);



}
