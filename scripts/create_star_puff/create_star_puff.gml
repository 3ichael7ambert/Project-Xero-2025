// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_star_puff(){
	//Generated for GMS2 in Geon FX v1.2.4
	//Put this code in Create event


	//NewEffect Particle Types
	//Effect1
	var pt_Effect1 = part_type_create();
	part_type_shape(pt_Effect1, pt_shape_spark);
	part_type_size(pt_Effect1, 0.5, 0.5, 0.035, 0);
	part_type_scale(pt_Effect1, 1, 1);
	part_type_orientation(pt_Effect1, 0, 0, 0, 0, 0);
	part_type_color3(pt_Effect1, 33023, 65535, 16777215);
	part_type_alpha3(pt_Effect1, 1, 1, 0);
	part_type_blend(pt_Effect1, 1);
	part_type_life(pt_Effect1, 12, 15);
	part_type_speed(pt_Effect1, 0, 0, 0, 0);
	part_type_direction(pt_Effect1, 0, 360, 0, 0);
	part_type_gravity(pt_Effect1, 0, 0);

	//Destroying Emitters
	//part_emitter_destroy(ps, pe_Effect1);
	partArray_add(pt_Effect1);
	
	return pt_Effect1;
}