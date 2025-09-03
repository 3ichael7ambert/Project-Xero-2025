// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_heal_field(){
	//Generated for GMS2 in Geon FX v1.2.4
	//Put this code in Create event

	//NewEffect Particle Types
	//Effect2
	var pt_Effect2 = part_type_create();
	part_type_shape(pt_Effect2, pt_shape_flare);
	part_type_size(pt_Effect2, 1, 1, 0, 0);
	part_type_scale(pt_Effect2, 1, 1);
	part_type_orientation(pt_Effect2, 0, 0, 0, 0, 0);
	part_type_color3(pt_Effect2, 8388608, 16776960, 8388608);
	part_type_alpha3(pt_Effect2, 1, 0.50, 1);
	part_type_blend(pt_Effect2, 1);
	part_type_life(pt_Effect2, 45, 45);
	part_type_speed(pt_Effect2, 0, 0, 0, 0);
	part_type_direction(pt_Effect2, 0, 360, 0, 0);
	part_type_gravity(pt_Effect2, 0, 0);

	//Effect1
	var pt_Effect1 = part_type_create();
	part_type_shape(pt_Effect1, pt_shape_circle);
	part_type_size(pt_Effect1, 0.50, 0.50, 0.05, 0.10);
	part_type_scale(pt_Effect1, 1, 1);
	part_type_orientation(pt_Effect1, 0, 0, 0, 0, 0);
	part_type_color3(pt_Effect1, 8388608, 12615680, 16776960);
	part_type_alpha3(pt_Effect1, 0.80, 0.50, 0);
	part_type_blend(pt_Effect1, 1);
	part_type_life(pt_Effect1, 10, 10);
	part_type_speed(pt_Effect1, 2, 2, 0, 0);
	part_type_direction(pt_Effect1, 90, 90, 0, 0);
	part_type_gravity(pt_Effect1, 0, 0);

	//Linking Particle Types together (Death and Step)
	part_type_step(pt_Effect2, 1, pt_Effect1);

	partArray_add(pt_Effect2);
	partArray_add(pt_Effect1);
	return(pt_Effect2);
}