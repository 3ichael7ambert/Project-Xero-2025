// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_small_flame(){
	//Generated for GMS2 in Geon FX v1.2.4
	//Put this code in Create event


	//effect_fire_small Particle Types
	//flame
	var pt_flame = part_type_create();
	part_type_shape(pt_flame, pt_shape_explosion);
	part_type_size(pt_flame, 0.02, 0.10, 0.01, 0);
	part_type_scale(pt_flame, 1, 1);
	part_type_orientation(pt_flame, 0, 360, 0, 50, 0);
	part_type_color3(pt_flame, 65535, 4235519, 255);
	part_type_alpha3(pt_flame, 0.35, 0.20, 0.15);
	part_type_blend(pt_flame, 0);
	part_type_life(pt_flame, 10, 15);
	part_type_speed(pt_flame, 0, 0, 0.075, 0);
	part_type_direction(pt_flame, 90, 90, 0, 10);
	part_type_gravity(pt_flame, 0, 0);

	//smoke
	var pt_smoke = part_type_create();
	part_type_shape(pt_smoke, pt_shape_cloud);
	part_type_size(pt_smoke, 0.25, 0.50, 0, 0);
	part_type_scale(pt_smoke, 1, 1);
	part_type_orientation(pt_smoke, 0, 360, 0, 5, 0);
	part_type_color3(pt_smoke, 0, c_dkgray, c_white);
	part_type_alpha3(pt_smoke, 0, 0.15, 0);
	part_type_blend(pt_smoke, 0);
	part_type_life(pt_smoke, 1, 30);
	part_type_speed(pt_smoke, 1, 3, 0, 0);
	part_type_direction(pt_smoke, 90, 90, 0, 0);
	part_type_gravity(pt_smoke, 0, 0);

	//Linking Particle Types together (Death and Step)
	part_type_death(pt_flame, 1, pt_smoke);

	array_push(_partArray, pt_flame);
	array_push(_partArray, pt_smoke);
	return pt_flame;

}