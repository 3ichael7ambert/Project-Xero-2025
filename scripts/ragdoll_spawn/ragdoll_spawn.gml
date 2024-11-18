/// @desc spawn a ragdoll, returns its instance id
/// @func ragdoll_spawn(x, y, depth, customSpr[opt], spr_head, spr_chest, spr_hip, spr_fArmA, spr_fArmB, spr_bArmA, spr_bArmB, spr_fLegA, spr_fLegB, spr_fFoot, spr_bLegA, spr_bLegB, spr_bFoot);
/// @arg x					x position
/// @arg y					y position
/// @arg depth				depth
/// @arg customSpr[opt]		use custom sprite for each body part (true) or let the ragdoll decide (false)
/// @arg spr_head
/// @arg spr_chest
/// @arg spr_hip
/// @arg spr_fArmA
/// @arg spr_fArmB
/// @arg spr_bArmA
/// @arg spr_bArmB
/// @arg spr_fLegA
/// @arg spr_fLegB
/// @arg spr_fFoot
/// @arg spr_bLegA
/// @arg spr_bLegB
/// @arg spr_bFoot
function ragdoll_spawn() {

	var _rx = argument[0], _ry = argument[1], _rd = argument[2], _customSpr = argument[3];
	var _spr_head = noone, _spr_chest = noone, _spr_hip = noone, _spr_fArmA = noone, _spr_fArmB = noone, 
		_spr_bArmA = noone, _spr_bArmB = noone, _spr_fLegA = noone, _spr_fLegB = noone, _spr_fFoot = noone, 
		_spr_bLegA = noone, _spr_bLegB = noone, _spr_bFoot = noone;
	
	if !variable_instance_exists(id,"__rgSizeArr") __rgSizeArr = [];
	if array_length_1d(__rgSizeArr) < 1 {
		__rgSizeArr = [1.2,		//scaler
					   20,		//head-radius
					   12, 22,  //chest w/h
					   12, 12,  //hip w/h
					   8, 22,	//leg w/h
					   7, 20,	//arm w/h
					   14, 4	//foot w/h
					   ];
	};

	if argument_count > 4 && _customSpr {
		_spr_head = argument[4]; _spr_chest = argument[5]; _spr_hip = argument[6];
		_spr_fArmA = argument[7]; _spr_fArmB = argument[8];
		_spr_bArmA = argument[9]; _spr_bArmB = argument[10];
		_spr_fLegA = argument[11]; _spr_fLegB = argument[12]; _spr_fFoot = argument[13];
		_spr_bLegA = argument[14]; _spr_bLegB = argument[15]; _spr_bFoot = argument[16];
	};

	var _rid = instance_create_depth(_rx, _ry, _rd, o_ragSpawner);
	with (_rid) {
	    spr_head = _spr_head;
	    spr_chest = _spr_chest;
	    spr_hip = _spr_hip;
	    spr_fArmA = _spr_fArmA;
	    spr_fArmB = _spr_fArmB;
	    spr_bArmA = _spr_bArmA;
	    spr_bArmB = _spr_bArmB;
	    spr_fLegA = _spr_fLegA;
	    spr_fLegB = _spr_fLegB;
	    spr_fFoot = _spr_fFoot;
	    spr_bLegA = _spr_bLegA;
	    spr_bLegB = _spr_bLegB;
	    spr_bFoot = _spr_bFoot;
		scaler = other.__rgSizeArr[0];
		len_head = other.__rgSizeArr[1];
		len_chest_w = other.__rgSizeArr[2];
		len_chest_h = other.__rgSizeArr[3];
		len_hip_w = other.__rgSizeArr[4];
		len_hip_h = other.__rgSizeArr[5];
		len_leg_w = other.__rgSizeArr[6];
		len_leg_h = other.__rgSizeArr[7];
		len_arm_w = other.__rgSizeArr[8];
		len_arm_h = other.__rgSizeArr[9];
		len_foot_w = other.__rgSizeArr[10];
		len_foot_h = other.__rgSizeArr[11];
		__spawnedbyscript = 1;
		event_user(1);
	};
	__rgSizeArr = [];
	return(_rid);




}
