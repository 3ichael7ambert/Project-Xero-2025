// Inherit the parent event
event_inherited();
#region Initialize some variables
//Instance type restriction
if parent.g_ragStatus = ragSt.dead || parent.g_ragStatus = ragSt.downed || global.pause { 
	phy_fixed_rotation = 0; exit;
} else phy_fixed_rotation = 1;
if tag != segTag.armF_a && tag != segTag.armB_a exit;

//Preparing some multipliers that will be used to adjust movement intensity,
//depending on the 'g_bal' variable from o_ragSpawner.
var _g_bal = parent.g_bal;
var _g_bal_perc = (min(60,abs(_g_bal))/60);
var _g_bal_perc_pSpd = abs(parent.phy_xspd)/5;

//If the walking key is being pressed by the player, then let the arms swing -
//to make it looks more like a natural walking
if parent.g_walking {
	{//Adjust values in this line ↓ to tweak arm-swing intensity during sprinting
	var _len = parent.len_arm_h*5 - parent.len_arm_h*min(2,_g_bal_perc_pSpd);
	}
	tarY = seg_y[0] + _len;
	
	//Match the x-axis of the arm to the opposite leg
	var _legPosDiff = parent.ins_legF_b.j_x - parent.ins_legF_a.j_x;
	var _legPosDiff2 = parent.ins_legB_b.j_x - parent.ins_legB_a.j_x;
	if tag == segTag.armF_a {
		tarX = seg_x[0]+_legPosDiff2*_g_bal_perc;
	} else {
		tarX = seg_x[0]+_legPosDiff*_g_bal_perc;
	};

//Else if the movement isn't controlled by the player, then let the arms do balancing act
} else {
	//Calculate the destination for the IK Arm
	if abs(_g_bal) > 25 || abs(parent.phy_xspd) > 2 {
		var _len = parent.len_arm_h*2 + parent.len_arm_h*2*_g_bal_perc + parent.len_arm_h*2*_g_bal_perc_pSpd;
		//When the ragdoll tilt to the ←LEFT
		if _g_bal < 0 {
			tarX = seg_x[0] + lengthdir_x(_len, 45);
			tarY = seg_y[0] + lengthdir_y(_len, 45);
		//When the ragdoll tilt to the RIGHT→
		} else {
			tarX = seg_x[0] + lengthdir_x(_len, 225);
			tarY = seg_y[0] + lengthdir_y(_len, 225);

		};
	} else {
		//Prevent glitching while lower the arm
		var aChk = abs(angle_difference(seg_get_angle(0),seg_get_angle(1))) > 90;
		tarX = parent.j_x_legf_b + (aChk?100:0)*sign(_g_bal);
		tarY = parent.j_y_legf_b - (aChk?10:0);
	};
};
#endregion

#region Generate animations for the arm
var spd = 3 + 6*_g_bal_perc;
var aD = (id=parent.ins_armF_a?5:-5);
if parent.g_walking {
	arm_move_towards(tarX,tarY,spd*2.5*_g_bal_perc_pSpd);
} else {
	arm_move_towards(tarX+aD,tarY-aD*3,spd);
};
//Apply a counterbalancing force to the chest
with (parent.ins_chest) {
    phy_angular_velocity += -phy_rotation*6;
};
#endregion

#region Rotate arm fixtures to make them synchronize to the coresponding IK segment
if parent.alarm[0]=-1 {
//Transform normal degree to Box2D degree
event_user(0);
var sAng0 = -point_direction(seg_x[0], seg_y[0], acx, acy)-90;
var sAng1 = -point_direction(acx, acy, seg_x[2], seg_y[2])-90;

//Perform synchronization
phy_rotation = sAng0;
lArm.phy_rotation = sAng1;
};
#endregion

#region Finishing
arm_reconnect(1,parent.j_x_armf_a,parent.j_y_armf_a);
#endregion
