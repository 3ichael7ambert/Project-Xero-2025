///@desc:Switch the primary leg

//Foot destination update
with (parent) {
    event_user(0);
};

//Calculate destination for the IK Arm
with (pair) {
	var pc = parent.ins_hip.phy_speed_x/8 *10;
	startX = seg_x[2]; startY = seg_y[2];
	tarX = parent.g_legStep_sPos[0] + parent.phy_xspd + pc;
	tarY = parent.g_legStep_sPos[1] + parent.phy_yspd;
	tarD = abs(tarX - foot.phy_position_x);
	
	//Fault tolerant: if the destination is behind the leg, then force to perform a leg switch.
	var mul = 1;
	if parent.g_bal > 0 {
		while (tarX < foot.phy_position_x) {
			mul ++;
			tarX = parent.g_legStep_sPos[0] + parent.phy_xspd*mul + pc;
			//show_debug_message("001# Calculation failed. Retry attempt "+string(mul-1));
			if mul > 10 break;
		};
	} else {
		while (tarX > foot.phy_position_x) {
			mul ++;
			tarX = parent.g_legStep_sPos[0] + parent.phy_xspd*mul + pc;
			if mul > 10 break;
			//show_debug_message("002# Calculation failed. Retry attempt "+string(mul-1));
		};
		if tarX > foot.phy_position_x event_user(0);
	};
};

pair.alarm[0] = -1;
parent.foot_turn = pair;
parent.foot_idle = id;