// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setup_part_snow(_lifeStart=1, _lifeEnd=120){
	//Generated for GMS2 in Geon FX v1.2.4
	//Put this code in Create event

	//snow Particle Types
	//snow
	var pt_snow = part_type_create();
	part_type_shape(pt_snow, pt_shape_smoke);
	part_type_size(pt_snow, 0.25, 1.25, 0, 0);
	part_type_scale(pt_snow, 0.10, 0.10);
	part_type_orientation(pt_snow, 0, 360, 0, 20, 0);
	part_type_color3(pt_snow, 16777215, 16777215, 16777215);
	part_type_alpha3(pt_snow, 1, 1, 1);
	part_type_blend(pt_snow, 0);
	part_type_life(pt_snow, _lifeStart,_lifeEnd);
	part_type_speed(pt_snow, 1, 4, 0, 0);
	part_type_direction(pt_snow, 270, 270, 0, 8);
	part_type_gravity(pt_snow, 0, 0);

	//melt
	var pt_melt = part_type_create();
	part_type_shape(pt_melt, pt_shape_explosion);
	part_type_size(pt_melt, 1, 1, 0, 0);
	part_type_scale(pt_melt, 0.05, 0.05);
	part_type_orientation(pt_melt, 0, 360, 0, 0, 0);
	part_type_color3(pt_melt, 16777215, 16777215, 16776960);
	part_type_alpha3(pt_melt, 0.80, 0.50, 0);
	part_type_blend(pt_melt, 0);
	part_type_life(pt_melt, 2, 60);
	part_type_speed(pt_melt, 0, 0, 0, 0);
	part_type_direction(pt_melt, 0, 360, 0, 0);
	part_type_gravity(pt_melt, 0, 0);

	//Linking Particle Types together (Death and Step)
	part_type_death(pt_snow, 1, pt_melt);

	partArray_add(pt_snow);
	partArray_add(pt_melt);
	
	return(pt_snow);

}