/// @desc set appearance for any ragdoll segment
/// @func ragdoll_set_segment_spr(ragdollID, segID, sprite_index, subimg);
/// @arg ragdollID			the instance id returned by 'ragdoll_spawn()'
/// @arg segID				ins_head, ins_chest, ins_hip, ins_legF_a, ins_legF_b, ins_footF, ins_legB_a, ins_legB_b, ins_footB, ins_armF_a, ins_armF_b, ins_armB_a, ins_armB_b,
/// @arg sprite_index		
/// @arg subimg		
/// @arg image_xscale	
/// @arg image_yscale	
/// @arg image_blend	
/// @arg image_alpha
function ragdoll_set_segment_spr() {
	var _seg = argument[1];
	with (argument[0]) {
	    _seg.sprite_index = argument[2];
	    _seg.image_index = argument[3];
		_seg.image_xscale = argument[4];
		_seg.image_yscale = argument[5];
		_seg.image_blend = argument[6];
		_seg.image_alpha = argument[7];
	};


}
