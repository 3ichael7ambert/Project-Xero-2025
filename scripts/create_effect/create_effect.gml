/// @description create_effect(x, y, sprite, animation_speed, hspeed, vspeed, colour, alpha)
/// @param x
/// @param  y
/// @param  sprite
/// @param  animation_speed
/// @param  hspeed
/// @param  vspeed
/// @param  colour
/// @param  alpha
function create_effect(xx, yy, spr_idx, img_spd, hsp, vsp, img_blnd, img_alph) {
	var a = instance_create(xx, yy, objEffect);
	a.sprite_index = spr_idx;
	a.image_speed = img_spd;
	a.hspeed = hsp;
	a.vspeed = vsp;
	a.image_blend = img_blnd;
	a.image_alpha = img_alph;
	return a;




}
