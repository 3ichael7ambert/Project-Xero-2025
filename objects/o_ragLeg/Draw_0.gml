// Inherit the parent event
event_inherited();
if !global.debugMode exit;
///Draw debug information///

//Draw feet angle
if tag = segTag.footF || tag = segTag.footB {
	var _l = parent.len_foot_w;
	var _fAng = -fAng;
	draw_line(j_x-lengthdir_x(-_l,_fAng),j_y-lengthdir_y(-_l,_fAng), 
	j_x-lengthdir_x(_l,_fAng),j_y-lengthdir_y(_l,_fAng));
};

//if parent.g_ragStatus = ragSt.dead || parent.g_ragStatus = ragSt.falling exit;
if tag != segTag.legF_a && tag != segTag.legB_a exit;
var _c = draw_get_color();

//Change the drawing color individually for the front/back arms.
if tag = segTag.legF_a {
	draw_set_color(c_red)
} else {
	draw_set_color(c_blue);
};
//arm_draw();
draw_line(seg_x[0],seg_y[0], acx, acy);
draw_line(seg_x[2],seg_y[2], acx, acy);

//draw_line(seg_x[2],seg_y[2],seg_x[0],seg_y[0])
//draw_line(parent.ins_hip.phy_position_x,parent.ins_hip.phy_position_y,parent.ins_hip.phy_position_x,parent.ins_hip.phy_position_y+parent.g_legs_maxSLength)

var th = tarY+liftH;

//Draw some debug info around foot and its destination
if id = parent.foot_turn {
	draw_circle(tarX, th, 5, 0);
	draw_text(tarX, th, "tar"+(id=parent.ins_legF_a?"F":"B"));
	draw_text(tarX, th+10, (tarReached?"R":""));
	draw_line_width_color(tarX,th,foot.phy_position_x,foot.phy_position_y,2,c_olive,c_olive);
	draw_line_color(phy_position_x, phy_position_y, tarX, th, c_lime, c_lime); 
};

draw_set_color(_c);

//draw_line(seg_x[0], seg_y[0],seg_x[0]+lengthdir_x(seg_len[0], acAng), seg_y[0]+lengthdir_y(seg_len[0], acAng))

if fSticking {
	with (foot) {
	    draw_set_color(c_red);
		physics_draw_debug();
		draw_set_color(c_white);
	};
};