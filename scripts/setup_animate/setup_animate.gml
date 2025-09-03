/// @description  setup_animate(sprite, life);
/// @param sprite
/// @param  life
function setup_animate(argument0, argument1) {


	var _id;
	_id = part_type_create();

	part_type_sprite(_id,argument0,true,true,false);
	part_type_life(_id,argument1,argument1);

	partArray_add(_id);
	return(_id);



}

/// @description  setup_animate(sprite, life);
/// @param sprite
/// @param  life_pcnt
/// @param rotate-face
function setup_animate_ext(argument0, argument1, argument2 = false) {


	var _life, _id;
	_id = part_type_create();
	_life = sprite_get_number(argument0) * argument1;

	part_type_sprite(_id,argument0,true,false,false);
	part_type_life(_id,_life,_life);
	if(argument2){
		part_type_orientation(_id,0,360,0,0,true);
	}

	partArray_add(_id);
	return(_id);



}
