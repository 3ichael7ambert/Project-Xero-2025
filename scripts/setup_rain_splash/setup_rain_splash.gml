/// @description setup_rain_splash(sprite);
/// @param sprite
function setup_rain_splash(argument0) {
	/*
	Created by: Rayu Johnson
	This function creates a particle type: splash
	*/
	var _id, _spr;
	_id = part_type_create();
	_spr = argument0;

	part_type_sprite(_id, _spr, 1, 1, 0);
	/*
	splash particle properties
	*/
	part_type_life(_id, 10, 10);
	part_type_size(_id, .5, 1, 0, 0);
	part_type_alpha2(_id,1,0);
	partArray_add(_id);
	return(_id);



}
