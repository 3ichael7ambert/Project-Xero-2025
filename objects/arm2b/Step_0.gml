arm_angle=(arm2.image_angle-20)/90;
hspeed=arm2.hspeed;
image_angle=point_direction(x,y,mouse_x,mouse_y);
//x=arm2.x+40*cos(arm_angle);
//y=arm2.y+40*sin(arm_angle);
x=arm2.x+lengthdir_x(40,arm2.image_angle);//arm1.x+40*cos(arm_angle);
y=arm2.y+lengthdir_y(40,arm2.image_angle);//arm1.y+40*sin(arm_angle);
