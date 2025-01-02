/// @description Insert description here
// You can write your code in this editor
randomize();

spark=choose(true,false);

col1=make_color_hsv(irandom(255),255,255);
col2=make_color_hsv(irandom(255),255,255);
col3=make_color_hsv(irandom(255),255,255);

hsp=irandom_range(-2,2);
vsp=irandom_range(-15,-25);
grav=.1;
depth=100;

life=irandom_range(100,200);


//part_Firework_trail
_psFireworkTrail = part_system_create();
part_system_depth(_psFireworkTrail,depth);

//Emitter
_ptypeFireworkTrail = part_type_create();
part_type_shape(_ptypeFireworkTrail, pt_shape_sphere);
part_type_size(_ptypeFireworkTrail, 0.2, 0.3, -0.05, 0);
part_type_scale(_ptypeFireworkTrail, 1, 1);
part_type_speed(_ptypeFireworkTrail, 1, 2, 0, 0);
part_type_direction(_ptypeFireworkTrail, 0, 360, 0, 0);
part_type_gravity(_ptypeFireworkTrail, 1, 270);
part_type_orientation(_ptypeFireworkTrail, 0, 0, 0, 0, false);
part_type_colour3(_ptypeFireworkTrail, col1, col2, col3);
part_type_alpha3(_ptypeFireworkTrail, 1, 1, 0);
part_type_blend(_ptypeFireworkTrail, false);
part_type_life(_ptypeFireworkTrail, 10, 20);

//part_Firework_Explode
_psFireworkExplode = part_system_create();
part_system_depth(_psFireworkExplode,depth);

//Emitter
_ptypeFireworkExplode = part_type_create();
part_type_shape(_ptypeFireworkExplode, pt_shape_sphere);
part_type_size(_ptypeFireworkExplode, 0.2, 0.3, -0.01, 0);
part_type_scale(_ptypeFireworkExplode, 1, 1);

part_type_speed(_ptypeFireworkExplode, 20, 30, 0, 0);
part_type_direction(_ptypeFireworkExplode, 0, 360, 0, 0);
part_type_gravity(_ptypeFireworkExplode, 1, 270);
part_type_orientation(_ptypeFireworkExplode, 0, 0, 0, 0, false);
part_type_colour3(_ptypeFireworkExplode, col1, col2, col3);
part_type_alpha3(_ptypeFireworkExplode, 1, 1, 0);
part_type_blend(_ptypeFireworkExplode, false);
part_type_life(_ptypeFireworkExplode, 200, 500);

