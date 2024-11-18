/// @desc Define the size of the next ragdoll before it spawned.
/// @func ragdoll_define_size()
/// @arg scaler				A multiplier.
/// @arg head_radius
/// @arg chest_w
/// @arg chest_h
/// @arg hip_h
/// @arg hip_w
/// @arg leg_h
/// @arg leg_w
/// @arg arm_h
/// @arg arm_w
/// @arg foot_h
/// @arg foot_w
function ragdoll_define_size() {
	/*
		Note:
		This function can be used to pre-define the size of the NEXT spawned ragdoll.
			e.g.:
			ragdoll_define_size(blah blah blah);
			ragdoll_spawn(blah);
		
		If you didn't call this function before using "ragdoll_spawn()", 
		then the newly spawned ragdoll will be at a default size.
	*/

	__rgSizeArr = [
					argument[0],
					argument[1],
					argument[2],
					argument[3],
					argument[4],
					argument[5],
					argument[6],
					argument[7],
					argument[8],
					argument[9],
					argument[10],
					argument[11],
				  ];



}
