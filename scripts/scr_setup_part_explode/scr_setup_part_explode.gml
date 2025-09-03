// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setup_part_explode(){
	//Generated for GMS2 in Geon FX v1.2.4
	//Put this code in Create event
	//explode Particle Types
	//shockwave
	var pt_shockwave = part_type_create();
	part_type_shape(pt_shockwave, pt_shape_flare);
	part_type_size(pt_shockwave, 2, 2, 1, 0);
	part_type_scale(pt_shockwave, 1, 1);
	part_type_orientation(pt_shockwave, 0, 0, 0, 0, 0);
	part_type_color3(pt_shockwave, 16777215, 16777215, 16777215);
	part_type_alpha3(pt_shockwave, 1, 0.25, 0);
	part_type_blend(pt_shockwave, 1);
	part_type_life(pt_shockwave, 8, 8);
	part_type_speed(pt_shockwave, 0, 0, 0, 0);
	part_type_direction(pt_shockwave, 0, 360, 0, 0);
	part_type_gravity(pt_shockwave, 0, 0);

	//explosion
	var pt_explosion = part_type_create();
	part_type_shape(pt_explosion, pt_shape_explosion);
	part_type_size(pt_explosion, 0, 0, 0.20, 0);
	part_type_scale(pt_explosion, 1, 1);
	part_type_orientation(pt_explosion, 0, 360, 0, 0, 0);
	part_type_color3(pt_explosion, 65535, 4235519, 255);
	part_type_alpha3(pt_explosion, 0.50, 0.50, 0);
	part_type_blend(pt_explosion, 1);
	part_type_life(pt_explosion, 10, 10);
	part_type_speed(pt_explosion, 0.20, 0.20, 0, 0);
	part_type_direction(pt_explosion, 0, 360, 0, 0);
	part_type_gravity(pt_explosion, 0, 0);

	//Linking Particle Types together (Death and Step)
	part_type_step(pt_shockwave, 2, pt_explosion);

	partArray_add(pt_shockwave);
	partArray_add(pt_explosion);
	
	return(pt_shockwave);
}