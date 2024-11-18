hspeed=body.hspeed;
image_angle=point_direction(x,y,mouse_x,mouse_y);
//if image_angle>(body.image_angle-90) then image_angle=-90;
//if image_angle<(body.image_angle+90) then image_angle=90;

x=body.x-0+sin(90+2*body.hspeed);
y=body.y-30;//*cos(90+2*body.hspeed);//*cos(body.image_angle);
/* */
/*  */
