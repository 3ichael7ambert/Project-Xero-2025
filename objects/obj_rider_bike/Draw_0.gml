switch (obj_Controller_bike.DebugState)
{
    // Normal play
    case false:
    {
        break;
    }
    
    // Debug
    case true:
    {
        break;
    }
}
draw_set_color(c_black);

draw_circle(mouse_x,mouse_y,10,1);


body_x = xx;
body_y = yy;
body_angle=-25+phy_speed_x/10;

	mx = mouse_x;
	my = mouse_y;

if (facing_right==true) {
	head_x = body_x + lengthdir_x(60*scale,body_angle+70);
	head_y = body_y + lengthdir_y(60*scale,body_angle+70);

	eyes_x = head_x + lengthdir_x(60*scale,70);
	eyes_y = head_y + lengthdir_y(60*scale,70);

	armF_x = body_x + lengthdir_x(40*scale,body_angle+160);
	armF_y = body_y + lengthdir_y(40*scale,body_angle+160);
	



	armF_dir=point_direction(armF_x,armF_y,mx,my);

	
	handF_x = armF_x + lengthdir_x(80*scale,armF_dir-5);
	handF_y = armF_y + lengthdir_y(80*scale,armF_dir-5);
}
if (facing_right==false) {
	head_x = body_x + lengthdir_x(60*scale,body_angle+70);
	head_y = body_y + lengthdir_y(60*scale,body_angle+70);

	eyes_x = head_x + lengthdir_x(60*scale,130);
	eyes_y = head_y + lengthdir_y(60*scale,130);

	armF_x = body_x + lengthdir_x(40*scale,body_angle+150);
	armF_y = body_y + lengthdir_y(40*scale,body_angle+150);
	
	armF_dir=point_direction(armF_x,armF_y,mx,my);
	
	handF_x = armF_x + lengthdir_x(80*scale,armF_dir+5);
	handF_y = armF_y + lengthdir_y(80*scale,armF_dir+5);
}



	armB_x = body_x+lengthdir_x(20*scale,body_angle+140);
	armB_y = body_y+lengthdir_y(20*scale,body_angle+140);


legB_x = body_x+lengthdir_x(20*scale,body_angle-40+phy_rotation);
legB_y = body_y+lengthdir_y(20*scale,body_angle-40+phy_rotation);

legF_x = body_x+lengthdir_x(67*scale,body_angle-112);
legF_y = body_y+lengthdir_y(67*scale,body_angle-112);


//BACK LEG
draw_sprite_ext(sprArmArms,0,armB_x,armB_y,scale,scale,-phy_rotation-35,c_white,1);
//BODY
draw_sprite_ext(sprBody,0,body_x,body_y,scale,scale,body_angle,c_white,1);
//FRONT LEG
draw_sprite_ext(sprLeg2,0,legF_x,legF_y,scale,scale,-phy_rotation-35,c_white,1);

if (facing_right==true) {

//HEAD
draw_sprite_ext(sprHead_old,0,head_x,head_y,scale,scale,-phy_rotation,c_white,1);
draw_sprite_ext(sprEyes,0,eyes_x,eyes_y,scale,scale,-phy_rotation,c_white,1);

//FRONT ARM
draw_sprite_ext(sprArmArms,0,armF_x,armF_y,scale,scale,armF_dir,c_white,1);
draw_sprite_ext(sprGun2,0,handF_x,handF_y,scale,scale,armF_dir,c_white,1);

}

if (facing_right==false) {

//HEAD
draw_sprite_ext(sprHead_old,0,head_x,head_y,-scale,scale,-phy_rotation,c_white,1);
draw_sprite_ext(sprEyes,0,eyes_x,eyes_y,-scale,scale,-phy_rotation,c_white,1);

//FRONT ARM
draw_sprite_ext(sprArmArms,0,armF_x,armF_y, scale,-scale,armF_dir,c_white,1);
draw_sprite_ext(sprGun2,0,handF_x,handF_y,scale,-scale,armF_dir,c_white,1);

}

