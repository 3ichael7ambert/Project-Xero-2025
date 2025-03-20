/// @description Set up
if level=0 {image = backCloudLayer1;}
if level=1 {image = backStarsLayer1;}
x_follow = 0.9;
y_follow = 0.9;
x_speed = -0.2;
y_speed = 0;
colour = c_white;
alpha = 1;
sub_image=0;
x_repeat=true;
y_repeat=false;

//level=1;

previous_xview = __view_get( e__VW.XView, 0 );
previous_yview = __view_get( e__VW.YView, 0 );


bgColor1=make_colour_rgb(random(255), random(255), random(255));
bgColor2=make_colour_rgb(random(255), random(255), random(255));
bgColor3=make_colour_rgb(random(255), random(255), random(255));
bgColor4=make_colour_rgb(random(255), random(255), random(255));
bgColor5=make_colour_rgb(random(255), random(255), random(255));

if level=16 {
	var panel1 = instance_create(0,0,objPanel2);
	var panel2 = instance_create(0,0,objPanel3);
	//panel3 = instance_create(0,0,objPanel247);
	//panel4 = instance_create(0,0,objPanel247);
	//panel5 = instance_create(0,0,objPanel247);*/
}