///@desc: Constraint joint angle
var sAng1 = seg_get_angle(0);
var drctAng = point_direction(seg_x[0],seg_y[0],seg_x[2],seg_y[2]);
var adif1 = abs(angle_difference(drctAng, sAng1));
var fAng = drctAng + adif1*parent.g_facing;
acx = seg_x[0] + lengthdir_x(parent.len_leg_h*2, fAng);
acy = seg_y[0] + lengthdir_y(parent.len_leg_h*2, fAng);
