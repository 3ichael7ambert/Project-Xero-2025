/// @description create_effect(x, y, sprite, animation_speed, hspeed, vspeed, colour, alpha)
/// @param x
/// @param  y
/// @param  sprite
/// @param  animation_speed
/// @param  hspeed
/// @param  vspeed
/// @param  colour
/// @param  alpha
function create_effect(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7) {
	var a = instance_create(argument0, argument1, objEffect);
	a.sprite_index = argument2;
	a.image_speed = argument3;
	a.hspeed = argument4;
	a.vspeed = argument5;
	a.image_blend = argument6;
	a.image_alpha = argument7;
	return a;




}
