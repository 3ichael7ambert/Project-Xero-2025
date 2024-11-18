arm_angle=(body.image_angle-20)/90;
hspeed=body.hspeed;
image_angle=270-(hspeed);
x=body.x-20*cos(arm_angle);
y=body.y-40*sin(arm_angle);
