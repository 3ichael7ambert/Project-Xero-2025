function scr_player_1_init_particles(){

//PARTICLES

//global.partSysSmoke=part_system_create(part_smoke);
			//GM_Smoke
 _ptypeSmoke = part_type_create();
part_type_shape(_ptypeSmoke, pt_shape_smoke);
part_type_size(_ptypeSmoke, 0.2, 0.2, 0.01, 0);
part_type_scale(_ptypeSmoke, 1, 1);
part_type_speed(_ptypeSmoke, 1, 1, 0, 0);
part_type_direction(_ptypeSmoke, 80, 100, 0, 0);
part_type_gravity(_ptypeSmoke, 0, 270);
part_type_orientation(_ptypeSmoke, 0, 0, 0, 0, false);
part_type_colour3(_ptypeSmoke, $4B4B5E, $000000, $000000);
part_type_alpha3(_ptypeSmoke, 0.188, 0.161, 0);
part_type_blend(_ptypeSmoke, false);
part_type_life(_ptypeSmoke, 80, 180);


//global.partSysCharge=part_system_create(part_charge_wpn);
//GM_Warp_Lines
_ptypeCharge = part_type_create();
part_type_shape(_ptypeCharge, pt_shape_line);
part_type_size(_ptypeCharge, 2, 1, 0, 0);
part_type_scale(_ptypeCharge, 0.5, 0.1);
part_type_speed(_ptypeCharge, 3, 5, 0, 0);
part_type_direction(_ptypeCharge, 0, 360, 0, 0);
part_type_gravity(_ptypeCharge, 0, 270);
part_type_orientation(_ptypeCharge, 0, 0, 0, 0, true);

// Get the interpolated color
var charge_color1 = get_interpolated_color(wpn_charge-2, wpn_charge_max);
var charge_color2 = get_interpolated_color(wpn_charge, wpn_charge_max);
var charge_color3 = get_interpolated_color(wpn_charge+2, wpn_charge_max);
//part_type_colour1(_ptypeBlast, charge_color); // Single color for simplicity
part_type_colour3(_ptypeCharge, charge_color1, charge_color2, charge_color3);

//part_type_colour3(_ptypeCharge, $FFFFFF, $FFE500, $FF7B00);
part_type_alpha3(_ptypeCharge, 0, 1, 0);
part_type_blend(_ptypeCharge, false);
part_type_life(_ptypeCharge, 10*scale, 20*scale);
////






//FLAMETHROWER
//part_flamethrower
global._psFlamethrower = part_system_create();
//part_system_draw_order(global._psFlamethrower, true);

//GM_FlameIntensity
_ptypeFlamethrower = part_type_create();
part_type_shape(_ptypeFlamethrower, pt_shape_explosion);
part_type_size(_ptypeFlamethrower, 1*scale, 1.2*scale, 0.1, 0);
part_type_scale(_ptypeFlamethrower, 0.5, 0.5);
part_system_depth(global._psFlamethrower,depth-10);
part_type_speed(_ptypeFlamethrower, 7, 9, -0.2, 0);
part_type_direction(_ptypeFlamethrower, 356, 28, 0, 0);
part_type_gravity(_ptypeFlamethrower, -0.4, 270);
part_type_orientation(_ptypeFlamethrower, 73, 321, 0, 0, false);
part_type_colour3(_ptypeFlamethrower, $C1FDFF, $26AFFF, $0090FF);
part_type_alpha3(_ptypeFlamethrower, 1, 0.271, 0);
part_type_blend(_ptypeFlamethrower, true);
part_type_life(_ptypeFlamethrower, 58*scale, 66*scale);
//_pemitFlamethrower = part_emitter_create(global._psFlamethrower);
//part_emitter_region(_psFlamethrower, _pemitFlamethrower, 0.5, 1.5, -0.5, 0.5, ps_shape_line, ps_distr_gaussian);
//part_emitter_stream(_psFlamethrower, _pemitFlamethrower, _ptypeFlamethrower, 7);
//part_system_position(global._psFlamethrower, room_width/2, room_height/2);



//part_electric
global._psElec = part_system_create();
part_system_draw_order(global._psElec, true);

//GM_Electricity
_ptypeElec = part_type_create();
part_type_sprite(_ptypeElec, GM_Electricity_spr_Electricity1, false, true, false)
part_type_size(_ptypeElec, 0.5*scale, 1*scale, 0, 0);
part_type_scale(_ptypeElec, 1, 1);
part_type_speed(_ptypeElec, 0, 0, 0, 0);
part_type_direction(_ptypeElec, 0, 360, 0.1, 0);
part_type_gravity(_ptypeElec, 0, 270);
part_type_orientation(_ptypeElec, 0, 360, 0, 0, false);
part_type_colour3(_ptypeElec, $FFC119, $FF6100, $FF0800);
part_type_alpha3(_ptypeElec, 1, 0.439, 0);
part_type_blend(_ptypeElec, true);
part_type_life(_ptypeElec, 15*scale, 18*scale);




///DEBUG
//part_smoke_count = part_particles_count(global.partSysCharge);

}