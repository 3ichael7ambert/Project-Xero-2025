/// @description  setup_emit(id2,color);
/// @param id2
/// @param color
function setup_emit(argument0, argument1) {
	/*
	Created by: Rayu Johnson
	This function creates a particle type: splash
	*/
	var _id, _id2;
	_id = part_type_create();
	_id2 = argument0;

	part_type_shape(_id,pt_shape_pixel);
	part_type_colour1(_id,argument1);
	part_type_life(_id, 60, 60);
	part_type_step(_id, -2, _id2);
	partArray_add(_id);
	return(_id);



}
