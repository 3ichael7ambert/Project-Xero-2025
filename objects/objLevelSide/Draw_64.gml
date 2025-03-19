//GMLive
if (live_call()) return live_result;

//initiate HUD
display_set_gui_size(1920,1080);

heightGUI=display_get_gui_height();
widthGUI=display_get_gui_width();
spriteWidthHP=sprite_get_width(sprHealthBar);
spriteHeightHP=sprite_get_height(sprHealthBar);
if instance_exists(target){
healthPercent=(target.hp/target.maxhp);
fuelPercent = target.fuel/100;
cooldownPercent = target.shoot_cooldown / 10;
rocketPercent = target.rocket_cooldown / 50;
}
spriteWidthmeter=sprite_get_width(sprMeter);
spriteHeightmeter=sprite_get_height(sprMeter);


//HEALTH Bar
if instance_exists(target) {draw_sprite_part_ext(sprHealthBar,4,0,0,spriteWidthHP*healthPercent,spriteHeightHP,gui_pad,gui_pad,1,1,c_red,1);}
draw_sprite(sprHealthBar,0,gui_pad,gui_pad);
//METER
//fuel hud
if instance_exists(target){draw_sprite_part_ext(sprMeter,1,0,fuelPercent*heightGUI,spriteWidthmeter,0,(spriteWidthmeter/2)/*+gui_pad*/,heightGUI/2-spriteHeightmeter/2,1,1,c_blue,1);}
if instance_exists(target){draw_sprite_part_ext(sprMeter,7,0,heightGUI,fuelPercent*spriteWidthmeter,spriteHeightmeter,widthGUI-spriteWidthmeter/*-gui_pad*/,heightGUI/2-spriteHeightmeter/2,1,1,c_blue,1);}
//cooldown hud
if instance_exists(target){draw_sprite_part_ext(sprMeter,2,0,0,cooldownPercent*spriteHeightmeter,spriteHeightmeter,(spriteWidthmeter/2)+gui_pad,heightGUI/2-spriteHeightmeter/2,1,1,c_yellow,1);}
//rockets hud
if instance_exists(target){draw_sprite_part_ext(sprMeter,8,0,0,rocketPercent*spriteWidthmeter,spriteHeightmeter,widthGUI-spriteWidthmeter-gui_pad,heightGUI/2-spriteHeightmeter/2,1,1,c_yellow,1);}
//meter
draw_sprite(sprMeter,6,widthGUI-spriteWidthmeter+gui_pad*2,heightGUI/2);
draw_sprite(sprMeter,0,(spriteWidthmeter/2)+gui_pad,heightGUI/2);

//Draw Minimap

//Drawlives
if ship=0 
{
	spriteWidthLives=sprite_get_width(sprShip);
	spriteHeightLives=sprite_get_height(sprShip);
}
if ship=1
{
	spriteWidthLives=sprite_get_width(sprUFO2);
	spriteHeightLives=sprite_get_height(sprUFO2);
}
if ship=2 
{
	spriteWidthLives=sprite_get_width(sprRocketMetal);
	spriteHeightLives=sprite_get_height(sprRocketMetal);
}
if ship=3 
{
	spriteWidthLives=sprite_get_width(sprCan);
	spriteHeightLives=sprite_get_height(sprCan);
}

for (var i = 0; i < p1lives; i+=1;)
{
	if ship=0{
		draw_sprite_ext(sprShip,0,room_width-((spriteWidthLives*playerScale)*i)-gui_pad,spriteHeightLives*playerScale/2+gui_pad,playerScale,playerScale,90,c_white,1);
	draw_sprite_ext(sprShip_body,0,room_width-((spriteWidthLives*playerScale)*i)-gui_pad,spriteHeightLives*playerScale/2+gui_pad,playerScale,playerScale,90,color1,1);
	draw_sprite_ext(sprShip_wings,0,room_width-((spriteWidthLives*playerScale)*i)-gui_pad,spriteHeightLives*playerScale/2+gui_pad,playerScale,playerScale,90,color2,1);
	}
	
	if ship=1{
		draw_sprite_ext(sprUFO2,3,room_width-((spriteWidthLives*playerScale)*i)-gui_pad,spriteHeightLives*playerScale/2+gui_pad,playerScale,playerScale,0,c_white,1);
	draw_sprite_ext(spr_UFO_body,3,room_width-((spriteWidthLives*playerScale)*i)-gui_pad,spriteHeightLives*playerScale/2+gui_pad,playerScale,playerScale,0,color1,1);
	draw_sprite_ext(spr_UFO_lights,3,room_width-((spriteWidthLives*playerScale)*i)-gui_pad,spriteHeightLives*playerScale/2+gui_pad,playerScale,playerScale,0,color2,1);
	}
	
	if ship=2{
		draw_sprite_ext(sprRocketMetal,0,room_width-((spriteWidthLives*playerScale)*i)-gui_pad,spriteHeightLives*playerScale/2+gui_pad,playerScale,playerScale,90,c_white,1);
	draw_sprite_ext(sprRocketMetal,0,room_width-((spriteWidthLives*playerScale)*i)-gui_pad,spriteHeightLives*playerScale/2+gui_pad,playerScale,playerScale,90,color1,1);
	draw_sprite_ext(sprScrew,0,room_width-((spriteWidthLives*playerScale)*i)-gui_pad,spriteHeightLives*playerScale/2+gui_pad,playerScale,playerScale,90,color2,1);
	}
	
	if ship=3{
		draw_sprite_ext(sprCan,0,room_width-((spriteWidthLives*playerScale)*i)-gui_pad,spriteHeightLives*playerScale/2+gui_pad,playerScale,playerScale,0,c_white,1);
	draw_sprite_ext(sprCan,0,room_width-((spriteWidthLives*playerScale)*i)-gui_pad,spriteHeightLives*playerScale/2+gui_pad,playerScale,playerScale,0,color1,1);
	draw_sprite_ext(sprCan,0,room_width-((spriteWidthLives*playerScale)*i)-gui_pad,spriteHeightLives*playerScale/2+gui_pad,playerScale,playerScale,0,color2,1);
	}
	
}

//Score Kills
//draw_text_outlined(gui_pad,widthGUI/2,c_black,c_white,"Kills: " + string(kills));
draw_set_font(fnt_monogram5);
draw_text_outlined(/*widthGUI/2*/gui_pad + spriteWidthHP + gui_pad, gui_pad,/*"Kills: " +*/ kills,c_white,c_black);
