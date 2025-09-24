/// @description Insert description here
// You can write your code in this editor


if (weapon==3) {
	part_type_size(_ptypeBlast, (wpn_charge/20)*scale, (wpn_charge/20)*scale, 0, 0);
	var charge_color1 = get_interpolated_color(wpn_charge-1, wpn_charge_max);
	var charge_color2 = get_interpolated_color(wpn_charge, wpn_charge_max);
	var charge_color3 = get_interpolated_color(wpn_charge+1, wpn_charge_max);
	
	
	part_type_size(_ptypeBlast, wpn_charge/10*scale, wpn_charge/10*scale, -.1, 0);
	part_type_colour3(_ptypeBlast, charge_color1, charge_color2, charge_color3);
	part_type_speed(_ptypeBlast, wpn_charge/2, wpn_charge/2, 0, 0);
	part_type_life(_ptypeBlast, wpn_charge, wpn_charge);
	
	
	part_particles_create(global.partSysBlast,x,y,_ptypeBlast,100);
			
}
