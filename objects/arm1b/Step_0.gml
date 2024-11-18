arm_angle=(arm1.image_angle)/90;
hspeed=body.hspeed;
image_angle=point_direction(x,y,mouse_x,mouse_y);
x=arm1.x+lengthdir_x(40,arm1.image_angle);//arm1.x+40*cos(arm_angle);
y=arm1.y+lengthdir_y(40,arm1.image_angle);//arm1.y+40*sin(arm_angle);
