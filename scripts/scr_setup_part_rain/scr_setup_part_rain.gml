// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setup_part_rain(_lifeStart=1, _lifeEnd=50){
	//Generated for GMS2 in Geon FX v1.2.4
	//Put this code in Create event

	//NewEffect Particle Types
	//rain
	var _pt_rain_ = part_type_create();
	part_type_shape(_pt_rain_, pt_shape_line);
	part_type_size(_pt_rain_, 1, 1, 0, 0);
	part_type_scale(_pt_rain_, 1, 0.10);
	part_type_orientation(_pt_rain_, 0, 0, 0, 0, 1);
	part_type_color3(_pt_rain_, 16776960, 16776960, 16776960);
	part_type_alpha3(_pt_rain_, 0.60, 0.30, 0.30);
	part_type_blend(_pt_rain_, 0);
	part_type_life(_pt_rain_, _lifeStart, _lifeEnd);
	part_type_speed(_pt_rain_, 10, 15, 0, 0);
	part_type_direction(_pt_rain_, 270, 270, 0, 0);
	part_type_gravity(_pt_rain_, 0, 0);

	//splash
	var _pt_splash_ = part_type_create();
	part_type_shape(_pt_splash_, pt_shape_circle);
	part_type_size(_pt_splash_, 1, 1, 0.25, 0);
	part_type_scale(_pt_splash_, 0.10, 0.10);
	part_type_orientation(_pt_splash_, 0, 0, 0, 0, 0);
	part_type_color3(_pt_splash_, 16776960, 16776960, 16711680);
	part_type_alpha3(_pt_splash_, 0.50, 0.50, 0);
	part_type_blend(_pt_splash_, 0);
	part_type_life(_pt_splash_, 5, 15);
	part_type_speed(_pt_splash_, 0, 0, 0, 0);
	part_type_direction(_pt_splash_, 0, 360, 0, 0);
	part_type_gravity(_pt_splash_, 0, 0);

	//Linking Particle Types together (Death and Step)
	part_type_death(_pt_rain_, 1, _pt_splash_);
	
	partArray_add(_pt_rain_);
	partArray_add(_pt_splash_);
	
	return(_pt_rain_);
}