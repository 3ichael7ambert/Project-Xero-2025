// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_splash(){
	//Generated for GMS2 in Geon FX v1.2.4
	//Put this code in Create event


	//NewEffect Particle Types
	//splash
	var _pt_splash = part_type_create();
	part_type_shape(_pt_splash, pt_shape_ring);
	part_type_size(_pt_splash, 0.020, 0.020, 0.020, 0);
	part_type_scale(_pt_splash, 1, 0.75);
	part_type_orientation(_pt_splash, 0, 0, 0, 0, 0);
	part_type_color3(_pt_splash, 16776960, 12615680, c_black);
	part_type_alpha3(_pt_splash, 0.30, 1, 0.1);
	part_type_blend(_pt_splash, 1);
	part_type_life(_pt_splash, 30, 30);
	part_type_speed(_pt_splash, 0, 0, 0, 0);
	part_type_direction(_pt_splash, 0, 360, 0, 0);
	part_type_gravity(_pt_splash, 0, 0);

	//droplet
	var _pt_droplet = part_type_create();
	part_type_shape(_pt_droplet, pt_shape_disk);
	part_type_size(_pt_droplet, 0.01, 0.050, 0, 0);
	part_type_scale(_pt_droplet, 1, 1);
	part_type_orientation(_pt_droplet, 0, 0, 0, 0, 0);
	part_type_color3(_pt_droplet, 16776960, 12615680, 4194304);
	part_type_alpha3(_pt_droplet, 1, 0.20, 0);
	part_type_blend(_pt_droplet, 1);
	part_type_life(_pt_droplet, 2, 40);
	part_type_speed(_pt_droplet, 1, 2, 0, 0);
	part_type_direction(_pt_droplet, 45, 135, 0, 0);
	part_type_gravity(_pt_droplet, 0.10, 270);

	//Linking Particle Types together (Death and Step)
	part_type_step(_pt_splash, 1, _pt_droplet);


	//Destroying Emitters
	//part_emitter_destroy(ps, pe_splash);
	partArray_add(_pt_splash);
	partArray_add(_pt_droplet);
	
	return _pt_splash;
}