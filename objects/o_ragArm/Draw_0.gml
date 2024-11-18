// Inherit the parent event
event_inherited();
//Instance type restriction
if parent.g_ragStatus = ragSt.dead || !global.debugMode exit;
var _c = draw_get_color();

//Change the drawing color individually for the front/back arms.
if tag != segTag.armF_a && tag != segTag.armB_a exit;
if tag = segTag.armF_a {
	draw_set_color(c_red)
} else {
	draw_set_color(c_blue);
};

//Draw arm & arm destination
if global.debugMode {
	arm_draw();
	draw_circle(tarX, tarY, 2, 0);
	draw_text(tarX, tarY, "aTar"+(id=parent.ins_armF_a?"F":"B"));
	draw_text(tarX, tarY+10, (tarReached?"R":""));
};

draw_set_color(_c)

