#region Update some variables
//Get the coordinate of each physics joint. 
{
#region head
j_x_head = physics_joint_get_value(j_head,phy_joint_anchor_1_x);
j_y_head = physics_joint_get_value(j_head,phy_joint_anchor_1_y);
with (ins_head) {
	j_x = other.j_x_head;
	j_y = other.j_y_head;
}; 
#endregion
#region body
with (ins_chest) {
	j_x = other.j_x_head;
	j_y = other.j_y_head;
};
j_x_body = physics_joint_get_value(j_body,phy_joint_anchor_1_x);
j_y_body = physics_joint_get_value(j_body,phy_joint_anchor_1_y);
with (ins_hip) {
	j_x = other.j_x_body;
	j_y = other.j_y_body;
};
#endregion
#region legs
j_x_legf_a = physics_joint_get_value(j_legF_a,phy_joint_anchor_1_x);
j_y_legf_a = physics_joint_get_value(j_legF_a,phy_joint_anchor_1_y);
j_x_legf_b = physics_joint_get_value(j_legF_b,phy_joint_anchor_1_x);
j_y_legf_b = physics_joint_get_value(j_legF_b,phy_joint_anchor_1_y);
j_x_legb_a = physics_joint_get_value(j_legB_a,phy_joint_anchor_1_x);
j_y_legb_a = physics_joint_get_value(j_legB_a,phy_joint_anchor_1_y);
j_x_legb_b = physics_joint_get_value(j_legB_b,phy_joint_anchor_1_x);
j_y_legb_b = physics_joint_get_value(j_legB_b,phy_joint_anchor_1_y);
with (ins_legF_a) {
	j_x = other.j_x_legf_a;
	j_y = other.j_y_legf_a;
};
with (ins_legF_b) {
	j_x = other.j_x_legf_b;
	j_y = other.j_y_legf_b;
};
with (ins_legB_a) {
	j_x = other.j_x_legb_a;
	j_y = other.j_y_legb_a;
};
with (ins_legB_b) {
	j_x = other.j_x_legb_b;
	j_y = other.j_y_legb_b;
};
////////////////////////////////////////////////////////////////////////////////
#endregion
#region arms
j_x_armf_a = physics_joint_get_value(j_armF_a,phy_joint_anchor_1_x);
j_y_armf_a = physics_joint_get_value(j_armF_a,phy_joint_anchor_1_y);
j_x_armf_b = physics_joint_get_value(j_armF_b,phy_joint_anchor_1_x);
j_y_armf_b = physics_joint_get_value(j_armF_b,phy_joint_anchor_1_y);
j_x_armb_a = physics_joint_get_value(j_armB_a,phy_joint_anchor_1_x);
j_y_armb_a = physics_joint_get_value(j_armB_a,phy_joint_anchor_1_y);
j_x_armb_b = physics_joint_get_value(j_armB_b,phy_joint_anchor_1_x);
j_y_armb_b = physics_joint_get_value(j_armB_b,phy_joint_anchor_1_y);
with (ins_armF_a) {
	j_x = other.j_x_armf_a;
	j_y = other.j_y_armf_a;
};
with (ins_armF_b) {
	j_x = other.j_x_armf_b;
	j_y = other.j_y_armf_b;
};
with (ins_armB_a) {
	j_x = other.j_x_armb_a;
	j_y = other.j_y_armb_a;
};
with (ins_armB_b) {
	j_x = other.j_x_armb_b;
	j_y = other.j_y_armb_b;
};
////////////////////////////////////////////////////////////////////////////////
#endregion
#region feet
j_x_footf = physics_joint_get_value(j_footF,phy_joint_anchor_1_x);
j_y_footf = physics_joint_get_value(j_footF,phy_joint_anchor_1_y);
j_x_footb = physics_joint_get_value(j_footB,phy_joint_anchor_1_x);
j_y_footb = physics_joint_get_value(j_footB,phy_joint_anchor_1_y);
j_x_footfs = physics_joint_get_value(j_footF_sensor,phy_joint_anchor_1_x);
j_y_footfs = physics_joint_get_value(j_footF_sensor,phy_joint_anchor_1_y);
j_x_footfs2 = physics_joint_get_value(j_footF_sensor,phy_joint_anchor_2_x);
j_y_footfs2 = physics_joint_get_value(j_footF_sensor,phy_joint_anchor_2_y);
j_x_footbs = physics_joint_get_value(j_footB_sensor,phy_joint_anchor_1_x);
j_y_footbs = physics_joint_get_value(j_footB_sensor,phy_joint_anchor_1_y);
j_x_footbs2 = physics_joint_get_value(j_footB_sensor,phy_joint_anchor_2_x);
j_y_footbs2 = physics_joint_get_value(j_footB_sensor,phy_joint_anchor_2_y);
with (ins_footF) {
	j_x = other.j_x_footf;
	j_y = other.j_y_footf;
	j_sensor_x = other.j_x_footfs;
	j_sensor_y = other.j_y_footfs;
	j_sensor2_x = other.j_x_footfs2;
	j_sensor2_y = other.j_y_footfs2;
};
with (ins_footB) {
	j_x = other.j_x_footb;
	j_y = other.j_y_footb;
	j_sensor_x = other.j_x_footbs;
	j_sensor_y = other.j_y_footbs;
	j_sensor2_x = other.j_x_footbs2;
	j_sensor2_y = other.j_y_footbs2;
};

#endregion
}

#region Compute COM
var g_totalMass = 0, g_totalSpdX = 0, g_totalSpdY = 0;
var g_totalCoordinate; g_totalCoordinate = [0,0];
#region List of body segment that participates COM computing.
var list; 
list[0] = ins_head;
list[1] = ins_footF;
list[2] = ins_footB; 
list[3] = ins_chest; 
list[4] = ins_hip;
//list[5] = ins_armF_a;
//list[6] = ins_armB_a;
#endregion
//Begin to gather physics information from each body segment
for (var i = 0; i < array_length_1d(list); ++i) {
	if list[i] != noone {
	    with (list[i]) {
			g_totalMass += phy_mass;
			g_totalSpdX += phy_speed_x;
			g_totalSpdY += phy_speed_y;
			g_totalCoordinate[0] += phy_position_x * phy_mass;
			g_totalCoordinate[1] += phy_position_y * phy_mass;
		};
	};
};
//Calculate the COM.
var gtperc = g_totalSpdX/array_length_1d(list);
g_impulse = g_totalSpdX_prev - gtperc;
g_totalSpdX_prev = gtperc;
g_com[0] = g_totalCoordinate[0]/g_totalMass + (gtperc/10)*10 +3;
g_com[1] = g_totalCoordinate[1]/g_totalMass;

var segxf = ins_legF_a.seg_x[1];
var segxb = ins_legB_a.seg_x[1];

//Calculate the horizontal balance vector.
g_bal = g_com[0] - (segxf + (segxb - segxf)/2);
#endregion
#region Check if the ragdoll is in mid-air
var flChk = 0;
for (var i = 0; i < array_length_1d(global.floorObjs); ++i) {
	with (ins_footF) {
		if physics_test_overlap(phy_position_x,phy_position_y+parent.len_foot_h*.8,phy_rotation,global.floorObjs[i]) { 
			parent.foot_st[tag] = footSt.ground;
			flChk += 1;
		} else parent.foot_st[tag] = footSt.air;
		footst = parent.foot_st[tag];
	};
	with (ins_footB) {
		if physics_test_overlap(phy_position_x,phy_position_y+parent.len_foot_h*.8,phy_rotation,global.floorObjs[i]) { 
			parent.foot_st[tag] = footSt.ground;
			flChk += 1;
		} else parent.foot_st[tag] = footSt.air;
		footst = parent.foot_st[tag];
	};
	with (ins_hip) {
		var i2 = 1;
		var coll = physics_test_overlap(parent.g_com[0],parent.g_com[1]-parent.len_hip_h+i2,0,global.floorObjs[i]);
		while (!coll) {
			i2++;
			coll = physics_test_overlap(parent.g_com[0],parent.g_com[1]-parent.len_hip_h+i2,0,global.floorObjs[i]);
			if i2 > parent.g_maxLength_com2feet break;
		};
	};
	if flChk > 0 break;
};
g_legs_maxSLength = i2;
g_floorHeight = g_com[1] + g_legs_maxSLength;
//var fhD = g_floorHeight - g_floorHeightPrev;
//show_debug_message(fhD);
//g_floorHeightPrev = g_floorHeight;
#endregion
#endregion

#region Player interactions
//Kill
if keyboard_check(ord("K")) { g_ragStatus = ragSt.dead; alarm[2]=-1;alarm[3]=-1;alarm[4]=-1;alarm[5]=-1;alarm[6]=-1; };

//Push
var g_movespd = .4;
var ad = -keyboard_check(vk_left) + keyboard_check(vk_right);
if ad != 0 {
	with (ins_chest) {
		phy_speed_x += g_movespd*ad;
		phy_angular_velocity += 60*ad;
	}
	with (ins_hip) {
		phy_speed_x += g_movespd*ad;
	};
};

//Walk
var lr = -keyboard_check(ord("A")) + keyboard_check(ord("D"));
if lr != 0 {
	g_walking = true; //Used to alter arm animations
	with (ins_chest) {
		phy_speed_x += g_movespd*lr;
		phy_angular_velocity += 60*lr;
	}
	with (ins_hip) {
		phy_speed_x += g_movespd*lr;
	};
} else g_walking = false;

//Jump
var wu = keyboard_check_pressed(ord("W")) + keyboard_check_pressed(vk_up);
if wu != 0 && g_onGround {
	alarm[1] = 10;
	g_ragStatus = ragSt.jumping;
	with (o_ragParent) {
		if parent == other phy_speed_y -= 6;
	}
};
//Shoot
if mouse_check_button_pressed(mb_left) {
	with (instance_create_depth(mouse_x,mouse_y,0,o_bullet)) {
		var tar = choose(other.ins_chest, other.ins_head);
		var direc = point_direction(mouse_x,mouse_y,tar.phy_position_x,tar.phy_position_y);
		var spd = 50;
	    phy_speed_x = lengthdir_x(spd,direc);
	    phy_speed_y = lengthdir_y(spd,direc);
	};
};

//Change the facing direction (This only affects joint angle restriction)
if keyboard_check_pressed(ord("R")) {
	g_facing = 0 + -g_facing;
};
#endregion

#region Check & try to stabilize the ragdoll
if g_ragStatus != ragSt.dead && g_ragStatus != ragSt.downed && g_ragStatus != ragSt.falling {
	//Initialize some variables.
	var g_bal_mainforce = 5; //Vertical counterbalancing force between upper&lower body.
	var g_bal_gravity = 0;	 //Gravity.
	
	if foot_st[segTag.footF] = footSt.air && foot_st[segTag.footB] = footSt.air && !dragging {
		//Adjust values in this line ↓ to tweak ragdoll gravity during falling
		g_gravity_acc += (35-g_gravity_acc)*.1;
		g_bal_gravity = g_gravity_acc;
	} else {
		g_gravity_acc = 0;
	};
	
	//The number of total body segments.
	var segNum = 13;
	
	//Divide the total mass by segment count,
	//To calculate the force that'll be added to upper&lower body, in order to balance the whole ragdoll.
	var upperMass = -(ins_head.phy_mass + ins_chest.phy_mass + ins_armF_a.phy_mass*4)/segNum;
	var lowerMass = (ins_legF_a.phy_mass*4 + ins_footF.phy_mass*2+ ins_hip.phy_mass)/segNum;
	
	//Multiply the force depended on upper body's angle.
	var g_chPerc = abs((ins_hip.phy_position_y - ins_chest.phy_position_y)/g_chest_hip_d - .8);
	g_bal_mainforce *= g_chPerc;
	
	//Begin to balance.
	if alarm[1] == -1 {
		with (ins_chest) {
			phy_speed_y = g_bal_mainforce * upperMass; 
		};
		with (ins_hip) {
			phy_speed_y = g_bal_mainforce * lowerMass + g_bal_gravity;
		};
	};
	with (ins_head) {
		var rdf = parent.ins_chest.phy_rotation - phy_rotation;
		phy_angular_velocity = (-phy_rotation + rdf)*2;
	};
	
	//Make sure the upper body is up straight.
	var bPow = (g_ragStatus=ragSt.idle?4:0)
	with (ins_chest) {
		phy_angular_velocity += -phy_rotation*bPow;
	};
};

#endregion

#region Update ragdoll status
#region g_ragStatus
if g_ragStatus != ragSt.dead && g_ragStatus != ragSt.downed  {
	var timeout = 20;
	//If at least one foot is touching the ground & the balance vector isn't too intense
	if g_legs_maxSLength < g_maxLength_com2feet && abs(g_bal) < 120 {
		//g_onGround = true;
		//If the balance vector & the acceleration lowers, set g_ragStatus to 'idle'
		if abs(g_bal) < 14 && abs(phy_xspd) < 2 {
			if g_ragStatus = ragSt.falling { 
				ins_legF_a.tarY = ins_footF.phy_position_y; ins_legB_a.tarY = ins_footB.phy_position_y; ins_armF_a.tarY = ins_footB.phy_position_y; ins_armB_a.tarY = ins_footB.phy_position_y;
			};
			alarm[3] = -1; alarm[4] = -1; alarm[5] = -1; alarm[6] = -1; alarm[7] = -1;
			if alarm[2]=-1 alarm[2] = timeout/2;
		//Else if the upper body is bend too much, set g_ragStatus to 'downed'
		} else {
			if abs(ins_chest.phy_rotation + ins_hip.phy_rotation) > 160 {
				alarm[2] = -1; alarm[3] = -1; alarm[4] = -1; alarm[5] = -1; alarm[7] = -1;
				if alarm[6]=-1 alarm[6] = timeout*.5;
			//At last, if no strange things' going on, set g_ragStatus to 'balancing'
			} else {
				if g_ragStatus = ragSt.falling { 
					ins_legF_a.tarY = ins_footF.phy_position_y; ins_legB_a.tarY = ins_footB.phy_position_y; ins_armF_a.tarY = ins_footB.phy_position_y; ins_armB_a.tarY = ins_footB.phy_position_y;
				};
				alarm[2] = -1; alarm[3] = -1; alarm[5] = -1; alarm[6] = -1; alarm[7] = -1;
				if alarm[4]=-1 alarm[4] = 1;
			};
		};
	//Else: if the ragdoll is in mid-air and is moving downward, set g_ragStatus to 'falling'
	} else {
		//g_onGround = false;
		if phy_yspd > 0 {
			alarm[2] = -1; alarm[4] = -1; alarm[5] = -1; alarm[6] = -1; alarm[7] = -1;
			if alarm[3]=-1 alarm[3] = timeout/2;
		};
	};
//If the ragdoll is downed, then tell it to get up after a random delay
} else {
	if g_ragStatus = ragSt.downed {
		alarm[2] = -1;
		alarm[3] = -1;
		alarm[4] = -1;
		alarm[5] = -1;
		alarm[6] = -1;
		if alarm[7] = -1 alarm[7] = irandom_range(30,60);
	};
};
#endregion
#region Other status
//Check if at least one foot is on the ground
if foot_st[segTag.footF] == footSt.ground || foot_st[segTag.footB] == footSt.ground {
	g_onGround = true;
} else g_onGround = false;
#endregion
#endregion

#region Get the current ragdoll speed
phy_xspd = ins_hip.phy_position_x - ins_hip.phy_position_xprevious;
phy_yspd = ins_hip.phy_position_y - ins_hip.phy_position_yprevious;

//Check if the ragdoll is moving forward
if g_facing = 1 {
	if g_bal > 0 g_movingForward = 1 else g_movingForward = 0;
} else {
	if g_bal < 0 g_movingForward = 1 else g_movingForward = 0;
};
#endregion

#region Nothing here
if keyboard_check(ord("S")) {
	ins_head.sprite_index = s_sillyface;
} else ins_head.sprite_index = noone;
#endregion
