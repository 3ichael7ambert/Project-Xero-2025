/// @description setup_fire(sprite);
/// @param sprite
function setup_fire(argument0) {
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
	part_type_size(_id, .25, .5, 0, .1);
	part_type_orientation(_id, 360, 0, 0, 5, 0 );
	part_type_direction(_id, 0, 180, 0, 5);
	part_type_speed(_id, .5, .5, 0, .1);
	part_type_colour3(_id,c_yellow,c_red,c_dkgray);
	part_type_alpha3(_id,.5,.5,.2);
	part_type_gravity(_id,.02,90);
	part_type_blend(_id, true);
	partArray_add(_id);
	return(_id);



}
