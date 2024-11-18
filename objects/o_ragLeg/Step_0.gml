// Inherit the parent event
event_inherited();
#region (For foot instance) Calculates a reasonable angle when contacting with the floor
if tag = segTag.footF || tag = segTag.footB {
	for (var i = 0; i < array_length_1d(global.floorObjs); ++i) {
		phy_fixed_rotation = 1;
		var i2 = 1;
		var coll = physics_test_overlap(j_sensor_x,j_sensor_y+i2,0,global.floorObjs[i]);
		while (!coll) {
			i2++;
			coll = physics_test_overlap(j_sensor_x,j_sensor_y+i2,0,global.floorObjs[i]);
			if i2 > parent.g_maxLength_com2feet break;
		};
		var s1y = j_sensor_y+i2;
	
		i2 = 1;
		coll = physics_test_overlap(j_sensor2_x,j_sensor2_y+i2,0,global.floorObjs[i]);
		while (!coll) {
			i2++;
			coll = physics_test_overlap(j_sensor2_x,j_sensor2_y+i2,0,global.floorObjs[i]);
			if i2 > parent.g_maxLength_com2feet break;
		};
		var s2y = j_sensor2_y+i2;
	
		fAng = -point_direction(j_sensor_x, s1y, j_sensor2_x, s2y)+180;
		phy_rotation = fAng;
	};
};
#endregion

#region Initialize some variables
//Instance type restriction
if tag != segTag.legF_a && tag != segTag.legB_a exit;

//Moves only when the ragdoll status is 'idle' or 'balancing'
if parent.g_ragStatus = ragSt.dead || parent.g_ragStatus = ragSt.downed || global.pause { 
	#region prevent glitching when fell on the ground
	if parent.g_ragStatus != ragSt.dead {
		seg_x[0] = parent.j_x_legf_a;
		seg_y[0] = parent.j_y_legf_a;
		seg_x[1] = parent.j_x_legf_b;
		seg_y[1] = parent.j_y_legf_b;
		seg_x[2] = parent.j_x_footf;
		seg_y[2] = parent.j_y_footf;
		acx = seg_x[1];
		acy = seg_y[1];
		tarX=foot.phy_position_x;
		tarY=foot.phy_position_y;
	};
	phy_fixed_rotation = 0; lLeg.phy_fixed_rotation = 0;
	#endregion
	exit;
} else { phy_fixed_rotation = 1; lLeg.phy_fixed_rotation = 1; };
footst = parent.foot_st[tag];
#endregion

#region Generate walking animation for the leg
//Gather some gravity info from parent
var _g_bal = parent.g_bal;
var _g_spdx = parent.phy_xspd;
var _g_bal_perc = min(30,abs(_g_bal))/30;
var _g_bal_perc_pSpd = abs(_g_spdx)/6;
var _g_bal_perc_pImp = abs(parent.g_impulse)/3;
var _g_lm = parent.g_floorHeight;

//Match tarY to the body's Y-Axis (Prevent glitch when falling).
tarY += parent.phy_yspd;

var spd = 6 + 8*_g_bal_perc + 6*_g_bal_perc_pSpd;
//If this is the current walking leg
if id = parent.foot_turn {
	fSticking = 0;
	pair.fSticking = 1;
	//show_debug_message(abs(parent.g_impulse))
	if abs(parent.g_impulse) > 1 {
		event_user(0);
		event_perform(ev_alarm, 0);
	};
	
	//Stop walking if destination distance is less than 5px
	if abs(tarD) < 5 event_user(0);
	
	//Switch the primary leg once the current one reached its destination.
	if tarReached { 
		tarReached = 0; pair.tarReached = 0;
		if alarm[0] = -1 {
			alarm[0] = max(1, 30 - _g_bal_perc*10 - 10*_g_bal_perc_pSpd - 30*_g_bal_perc_pImp); //switch leg
			//audio_play_sound_at(asset_get_index("sound"+string(irandom(8))),phy_position_x,phy_position_y,0,0,0,1,0,1);
		};
		pair.alarm[0] = -1;
	
	//Else: Walk to the destination.
	} else if alarm[0] = -1 {
		var reached = 0, liftP = 0;
		if sign(foot.phy_position_x-tarX) = sign(_g_bal) reached = 1;
			
		if reached {
			//Once the destination is reached, perform a pre-switch event before the actual switch.
			event_user(0);
		} else {
			if stepping = 0 {
				liftP = tarD / 40;
				var lmD = _g_lm - lm_prev;
				liftH = (-15 + -15*liftP + 4*parent.g_movingForward) * (abs(lmD) < 2?1:0);
				stepping = 1;
			};
			arm_move_towards(tarX+_g_spdx,tarY+liftH,spd);
			
			//Check if a foot is stumbled on an obstacle
			//WIP.
			//var lLegD_Compare = point_distance(foot.phy_position_x,foot.phy_position_y,lLeg.phy_position_x,lLeg.phy_position_y) - lLegD;
			//if abs(lLegD_Compare) > 10 {
			//	with (parent) {
			//		alarm[1]=-1;alarm[2]=-1;alarm[3]=-1;alarm[4]=-1;
			//		g_ragStatus = ragSt.dead;
			//	};
			//};
		};
		

	};

//If this is NOT the current walking leg
} else {
	stepping = 0;		//Start to putting down the foot
	if !fSticking {
		with (parent.ins_hip) {
			//phy_speed_y += -40;
		};
		fSticking = 1;		//Make the foot stick to the floor (Freezes its x-axis)
	}
	pair.fSticking = 0; //Unfreeze the opposite foot
};

//Lowers the inactive leg
if !stepping {
	arm_move_towards(seg_x[2], tarY, spd/2);
	var bend = abs(angle_difference(seg_get_angle(0),seg_get_angle(1)));
	if bend > 50 {
		seg_apply_force(1, bend/50 *5, 270);
	};
};

//Making the inactive foot stick to the floor
//Wasted. Make things even worse.
//if fSticking {
	//foot.phy_position_x = foot.phy_position_xprevious;
	//seg_x[2] = foot.phy_position_x;
//};
#endregion

#region Rotate leg fixtures to make them synchronize to the coresponding IK segment
if parent.alarm[0]=-1 {
//Transform normal degree to Box2D degree
event_user(1);
var sAng0 = -point_direction(seg_x[0], seg_y[0], acx, acy)-90;
var sAng1 = -point_direction(acx, acy, seg_x[2], seg_y[2])+270;

//Perform synchronization 
phy_rotation = sAng0;
lLeg.phy_rotation = sAng1;
//foot.phy_position_x = seg_x[2];
//foot.phy_position_y = seg_y[2];
};
#endregion

#region Finishing
arm_reconnect(1,parent.j_x_legf_a,parent.j_y_legf_a);
lm_prev = _g_lm;
#endregion

