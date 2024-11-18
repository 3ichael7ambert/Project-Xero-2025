///@desc: Spawn & initialize the ragdoll

#region Register enums
//These variables are handled by the script ragdoll_spawn() now.
//Or you can edit them manually if you're not gonna use ragdoll_spawn() to spawn ragdoll.
if !variable_instance_exists(id,"__spawnedbyscript") {
	scaler = 1.2;
	len_head = 20			*scaler;
	len_chest_w = 12		*scaler;
	len_chest_h = 22		*scaler;
	len_hip_w = 12			*scaler;
	len_hip_h = 12			*scaler;
	len_leg_w = 8			*scaler;
	len_leg_h = 22			*scaler;
	len_arm_w = 7			*scaler;
	len_arm_h = 20			*scaler;
	len_foot_w = 14			*scaler;
	len_foot_h = 4			*scaler;
};

enum footSt {
	ground = 0,
	air = 1,
};

enum ragSt {
	idle = 0,
	balancing = 1,
	falling = 2,
	downed = 3,
	gettingup = 4,
	dead = 5,
	jumping = 6,
};

enum segTag {
	head = 0,
	chest = 1,
	hip = 2,
	legF_a = 3,
	legF_b = 4,
	footF = 5,
	legB_a = 6,
	legB_b = 7,
	footB = 8,
	armF_a = 9,
	armF_b = 10,
	armB_a = 11,
	armB_b = 12
};
#endregion

#region Create body parts & bind fixtures to them

var col_arms = make_color_hsv(irandom(255),irandom_range(160,230),irandom_range(100,200));
var col_legs = make_color_hsv(irandom(255),irandom_range(160,230),irandom_range(100,200));
var col_shoes = make_color_hsv(irandom(255),irandom_range(160,230),irandom_range(100,200));
var hFix = -40, vFix = -60;
#region ArmF
with (instance_create_depth(x,y,0,o_ragArm)) {
	parent = other.id;
    scr_fix_arm();
	scr_fix_init();
	parent.ins_armF_a = id;
	tag = segTag.armF_a;
	phy_position_x += 0;
	phy_position_y += parent.len_head + parent.len_arm_h;
	arm_initialize(parent.len_arm_h*4, 2, noone);
	phy_fixed_rotation = 1;
	col = col_arms;
	sprite_index = parent.spr_fArmA;
};
with (instance_create_depth(x,y,0,o_ragArm)) {
	parent = other.id;
    scr_fix_arm();
	scr_fix_init();
	parent.ins_armF_b = id;
	tag = segTag.armF_b;
	phy_position_x += 0;
	phy_position_y += parent.len_head + parent.len_arm_h*3;
	phy_fixed_rotation = 1;
	col = parent.ins_armF_a.col;
	sprite_index = parent.spr_fArmB;
};

 #endregion
#region LegF
with (instance_create_depth(x,y,0,o_ragLeg)) {
	parent = other.id;
    scr_fix_leg();
	scr_fix_init();
	parent.ins_legF_a = id;
	tag = segTag.legF_a;
	phy_position_x += 0;
	phy_position_y += parent.len_head + parent.len_chest_h*2 + parent.len_hip_h*2 + parent.len_leg_h;
	arm_initialize(parent.len_leg_h*4, 2, noone);
	phy_fixed_rotation = 1;
	col = col_legs;
	sprite_index = parent.spr_fLegA;
};
with (instance_create_depth(x,y,0,o_ragLeg)) {
	parent = other.id;
    scr_fix_leg();
	scr_fix_init();
	parent.ins_legF_b = id;
	tag = segTag.legF_b;
	phy_position_x += 0;
	phy_position_y += parent.len_head + parent.len_chest_h*2 + parent.len_hip_h*2 + parent.len_leg_h*3;
	phy_fixed_rotation = 1;
	col = parent.ins_legF_a.col;
	sprite_index = parent.spr_fLegB;
};
with (instance_create_depth(x,y,0,o_ragLeg)) {
	parent = other.id;
    scr_fix_foot();
	scr_fix_init();
	parent.ins_footF = id;
	tag = segTag.footF;
	phy_position_x += 0;
	phy_position_y += parent.len_head + parent.len_chest_h*2 + parent.len_hip_h*2 + parent.len_leg_h*4 + parent.len_foot_h;
	//phy_fixed_rotation = 1;
	col = col_shoes;
	sprite_index = parent.spr_fFoot;
};
 #endregion
#region head
with (instance_create_depth(x,y,0,o_ragHead)) {
	parent = other.id;
    scr_fix_head();
	scr_fix_init();
	parent.ins_head = id;
	tag = segTag.head;
	phy_position_x += 0;
	phy_position_y += 0;
	col = choose($AFE1F0, $1A1F46, $C6DBFC, $4D6388, $5B6A58);
	sprite_index = parent.spr_head;
};
#endregion
#region body
with (instance_create_depth(x,y,0,o_ragBody)) {
	parent = other.id;
    scr_fix_chest();
	scr_fix_init();
	parent.ins_chest = id;
	tag = segTag.chest;
	phy_position_x += 0;
	phy_position_y += parent.len_head + parent.len_chest_h;
	col = make_color_hsv(irandom(255),irandom_range(160,230),irandom_range(100,200))
	sprite_index = parent.spr_chest;
};
with (instance_create_depth(x,y,0,o_ragBody)) {
	parent = other.id;
    scr_fix_hip();
	scr_fix_init();
	parent.ins_hip = id;
	tag = segTag.hip;
	phy_position_x += 0;
	phy_position_y += parent.len_head + parent.len_chest_h*2 + parent.len_hip_h;
	col = parent.ins_chest.col;
	sprite_index = parent.spr_hip;
};
#endregion
#region ArmB
with (instance_create_depth(x,y,0,o_ragArm)) {
	parent = other.id;
    scr_fix_arm();
	scr_fix_init();
	parent.ins_armB_a = id;
	tag = segTag.armB_a;
	pair = parent.ins_armF_a;
	parent.ins_armF_a.pair = id;
	phy_position_x += 0;
	phy_position_y += parent.len_head + parent.len_arm_h;
	arm_initialize(parent.len_arm_h*4, 2, noone);
	phy_fixed_rotation = 1;
	col = make_color_hsv(color_get_hue(col_arms),color_get_saturation(col_arms)+hFix,color_get_value(col_arms)+vFix);
	sprite_index = parent.spr_bArmA;
};
with (instance_create_depth(x,y,0,o_ragArm)) {
	parent = other.id;
    scr_fix_arm();
	scr_fix_init();
	parent.ins_armB_b = id;
	parent.ins_armB_a.lArm = id;
	parent.ins_armF_a.lArm = parent.ins_armF_b;
	tag = segTag.armB_b;
	phy_position_x += 0;
	phy_position_y += parent.len_head + parent.len_arm_h*3;
	phy_fixed_rotation = 1;
	col = parent.ins_armB_a.col;
	sprite_index = parent.spr_bArmB;
};

#endregion
#region LegB
with (instance_create_depth(x,y,0,o_ragLeg)) {
	parent = other.id;
    scr_fix_leg();
	scr_fix_init();
	parent.ins_legB_a = id;
	tag = segTag.legB_a;
	
	pair = parent.ins_legF_a;
	parent.ins_legF_a.pair = id;
	phy_position_x += 0;
	phy_position_y += parent.len_head + parent.len_chest_h*2 + parent.len_hip_h*2 + parent.len_leg_h;
	arm_initialize(parent.len_leg_h*4, 2, noone);
	phy_fixed_rotation = 1;
	col = make_color_hsv(color_get_hue(col_legs),color_get_saturation(col_legs)+hFix,color_get_value(col_legs)+vFix);
	sprite_index = parent.spr_bLegA;
};
with (instance_create_depth(x,y,0,o_ragLeg)) {
	parent = other.id;
    scr_fix_leg();
	scr_fix_init();
	parent.ins_legB_b = id;
	tag = segTag.legB_b;
	
	parent.ins_legB_a.lLeg = id;
	parent.ins_legF_a.lLeg = parent.ins_legF_b;

	phy_position_x += 0;
	phy_position_y += parent.len_head + parent.len_chest_h*2 + parent.len_hip_h*2 + parent.len_leg_h*3;
	phy_fixed_rotation = 1;
	col = parent.ins_legB_a.col;
	sprite_index = parent.spr_bLegB;
};
with (instance_create_depth(x,y,0,o_ragLeg)) {
	parent = other.id;
    scr_fix_foot();
	scr_fix_init();
	parent.ins_footB = id;
	tag = segTag.footB;
	
	parent.ins_legF_a.foot = parent.ins_footF;
	parent.ins_legB_a.foot = id;
	
	phy_position_x += 0;
	phy_position_y += parent.len_head + parent.len_chest_h*2 + parent.len_hip_h*2 + parent.len_leg_h*4 + parent.len_foot_h;
	//phy_fixed_rotation = 1;
	col = make_color_hsv(color_get_hue(col_shoes),color_get_saturation(col_shoes)-10,color_get_value(col_shoes)-20);
	
	parent.ins_legF_a.tarX = parent.ins_footF.phy_position_x;
	parent.ins_legF_a.tarY = parent.ins_footF.phy_position_y;
	parent.ins_legB_a.tarX = phy_position_x;
	parent.ins_legB_a.tarY = phy_position_y;
	sprite_index = parent.spr_bFoot;
};
#endregion
#endregion

#region Create physics joints between body parts to link them together
var limit;
var enableLimit = 1;
limit = 60;
j_head = physics_joint_revolute_create(ins_head, ins_chest,
	ins_head.phy_position_x,  ins_head.phy_position_y+len_head,				-limit,limit,enableLimit,0,0,0,0);
limit =  0;
j_body = physics_joint_revolute_create(ins_chest, ins_hip,
	ins_chest.phy_position_x,  ins_chest.phy_position_y+len_chest_h,		-limit,limit,enableLimit,0,0,0,0);

j_legF_a = physics_joint_revolute_create(ins_legF_a, ins_hip,
	ins_legF_a.phy_position_x,  ins_legF_a.phy_position_y-len_leg_h,		0,0,0,0,0,0,0);
j_legB_a = physics_joint_revolute_create(ins_legB_a, ins_hip,
	ins_legB_a.phy_position_x,  ins_legB_a.phy_position_y-len_leg_h,		0,0,0,0,0,0,0);

j_legF_b = physics_joint_revolute_create(ins_legF_b, ins_legF_a,
	ins_legF_b.phy_position_x,  ins_legF_b.phy_position_y-len_leg_h,		0,0,0,0,0,0,0);
j_legB_b = physics_joint_revolute_create(ins_legB_b, ins_legB_a,
	ins_legB_b.phy_position_x,  ins_legB_b.phy_position_y-len_leg_h,		0,0,0,0,0,0,0);

limit =  10;
j_footF = physics_joint_revolute_create(ins_footF, ins_legF_b,
	ins_footF.phy_position_x,  ins_footF.phy_position_y,		-limit,limit,1,0,0,0,0);
j_footF_sensor = physics_joint_distance_create(ins_legF_b, ins_legF_b,
	ins_footF.phy_position_x+len_foot_w,  ins_footF.phy_position_y,
	ins_footF.phy_position_x-len_foot_w,  ins_footF.phy_position_y,
	0);


j_footB = physics_joint_revolute_create(ins_footB, ins_legB_b,
	ins_footB.phy_position_x,  ins_footB.phy_position_y,		-limit,limit,1,0,0,0,0);
j_footB_sensor = physics_joint_distance_create(ins_legB_b, ins_legB_b,
	ins_footB.phy_position_x+len_foot_w,  ins_footB.phy_position_y,
	ins_footB.phy_position_x-len_foot_w,  ins_footB.phy_position_y,
	0);
	

limit =  0;
//arms
j_armF_a = physics_joint_revolute_create(ins_armF_a, ins_chest,
	ins_armF_a.phy_position_x,  ins_armF_a.phy_position_y-len_arm_h,		0,0,0,0,0,0,0);
j_armB_a = physics_joint_revolute_create(ins_armB_a, ins_chest,
	ins_armB_a.phy_position_x,  ins_armB_a.phy_position_y-len_arm_h,		0,0,0,0,0,0,0);
j_armF_b = physics_joint_revolute_create(ins_armF_b, ins_armF_a,
	ins_armF_b.phy_position_x,  ins_armF_b.phy_position_y-len_arm_h,		0,0,0,0,0,0,0);
j_armB_b = physics_joint_revolute_create(ins_armB_b, ins_armB_a,
	ins_armB_b.phy_position_x,  ins_armB_b.phy_position_y-len_arm_h,		0,0,0,0,0,0,0);
#endregion

#region Initialize some rest variables
dragging = 0;								//Used for mouse drag checking.
foot_st[segTag.footF] = footSt.ground;		//Foot status (on the ground / mid-air). Uses 'footSt.*' enum.
foot_st[segTag.footB] = footSt.ground;		//Foot status (on the ground / mid-air). Uses 'footSt.*' enum.
foot_turn = ins_legF_a;						//Current primary foot (the one that steps forward).
foot_idle = ins_legB_a;						//Current inactive foot (the one that stays on the floor).
phy_xspd = 0; phy_yspd = 0;					//Current ragdoll speed.

g_com[0] = 0; g_com[1] = 0;					//Coordinate of ragdoll's COM (Center Of Mass).
g_bal = 0;									//Current horizontal balance (>0 Tilting to the right; <0 Tilting to the left).
g_floorHeight = 0;							//Current floor height.
g_floorHeightPrev = 0;						//Floor height in previous frame.
g_legs_maxSLength = len_leg_h*4;			//The length from hip to floor.
g_maxLength_com2feet = len_leg_h*4 + len_chest_h*2 + len_hip_h*2;	//The length from body to feet. Used to calculate if the ragdoll is standing on the floor.
g_onGround = false;								//Used to check if at least one foot is touching the floor

g_ragStatus = ragSt.idle;					//Ragdoll status.
g_walking = false;							//Used to alter arm animation, depending on whether the walking key is being pressed

g_facing = 1;								//Current facing direction of ragdoll. (-1, 1)
g_chest_hip_d = ins_hip.phy_position_y - ins_chest.phy_position_y;		//The length from chest to hip. Used to calculate ragdoll balancing.

g_legStep_sPos = [0,0];						//Storage foot destination coordinate (of the currently active one).
g_legIdle_sPos = [0,0];						//Storage foot destination coordinate (of the currently inactive one).

g_gravity_acc = 0;							//Gravity acceleration of the ragdoll.
g_totalSpdX_prev = 0;
g_impulse = 0;

//Unfreeze each body part
with (o_ragParent) {
    event_user(5);
	inited = 1;
};

//Delay the draw event
_inited = 0;
alarm[0] = 5;

#endregion

camera_set_view_target(view_camera[0] ,ins_head);
