// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setup_part_slush(_lifeStart=1, _lifeEnd=50){
	//Generated for GMS2 in Geon FX v1.2.4
	//Put this code in Create event

	//slush Particle Types
	//rain
	var _pt_slush_ = part_type_create();
	part_type_shape(_pt_slush_, pt_shape_smoke);
	part_type_size(_pt_slush_, 0.5, 1, -0.005, 0);
	part_type_scale(_pt_slush_, 0.10, 0.10);
	part_type_orientation(_pt_slush_, 0, 360, 0, 0, 1);
	part_type_color3(_pt_slush_, c_white, c_ltgray, 16776960);
	part_type_alpha3(_pt_slush_, 1, 0.50, 0.50);
	part_type_blend(_pt_slush_, 0);
	part_type_life(_pt_slush_, _lifeStart, _lifeEnd);
	part_type_speed(_pt_slush_, 6, 8, 0, 0);
	part_type_direction(_pt_slush_, 270, 270, 0, 0);
	part_type_gravity(_pt_slush_, 0, 0);

	//splash
	var _pt_splash_ = part_type_create();
	part_type_shape(_pt_splash_, pt_shape_explosion);
	part_type_size(_pt_splash_, 0.5, 0.5, 0.50, 0);
	part_type_scale(_pt_splash_, 0.05, 0.05);
	part_type_orientation(_pt_splash_, 0, 0, 0, 0, 0);
	part_type_color3(_pt_splash_, 16777215, 16776960, 16711680);
	part_type_alpha3(_pt_splash_, 0.50, 0.20, 0);
	part_type_blend(_pt_splash_, 0);
	part_type_life(_pt_splash_, 5, 10);
	part_type_speed(_pt_splash_, 0, 0, 0, 0);
	part_type_direction(_pt_splash_, 0, 360, 0, 0);
	part_type_gravity(_pt_splash_, 0, 0);

	//Linking Particle Types together (Death and Step)
	part_type_death(_pt_slush_, 1, _pt_splash_);
	
	partArray_add(_pt_slush_);
	partArray_add(_pt_splash_);
	return(_pt_slush_);
}