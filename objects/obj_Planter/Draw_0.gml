/// @description Insert description here
// You can write your code in this editor

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);



///front
draw_sprite_3d_part(sprSidewalk,0,x,y,64,0,0,0,32,0,64,32,1,1,c_white,1);
draw_sprite_3d_part(sprSidewalk,0,x,y,72,0,0,0,32,0,64,32,1,1,c_white,1); //back
draw_sprite_3d_part(sprSidewalk,0,x,y,72,90,0,0,32,0,64,8,1,1,c_white,1); //top

//right
draw_sprite_3d_pos(sprSidewalk,0,x+64,y,64,0,45,0,0,0,0,32,90.5,32,90.5,0);
draw_sprite_3d_pos(sprSidewalk,0,x+64,y,72,0,45,0,0,0,0,32,84,32,84,0);//back
draw_sprite_3d_pos(sprSidewalk,0,x+64,y,64,-90,0,0,0,0,0,8,56,64,64,64); //top
draw_sprite_3d_part(sprSidewalk,0,x+120,y,128,-90,0,0,0,0,8,64,1,1,c_white,1);//side top
draw_sprite_3d_part(sprSidewalk,0,x+128,y,128,0,90,0,32,0,64,32,1,1,c_white,1); //otuside side
draw_sprite_3d_part(sprSidewalk,0,x+120,y,128,0,90,0,32,0,64,32,1,1,c_white,1); //inside side
draw_sprite_3d_part(sprSidewalk,0,x+120,y,192,-90,0,0,0,0,8,64,1,1,c_white,1);//side top
draw_sprite_3d_part(sprSidewalk,0,x+128,y,192,0,90,0,32,0,64,32,1,1,c_white,1); //otuside side
draw_sprite_3d_part(sprSidewalk,0,x+120,y,192,0,90,0,32,0,64,32,1,1,c_white,1); //inside side
//draw_sprite_3d_part(sprSidewalk,0,x+120,y,128,90,0,0,32,0,64,32,1,1,c_white,1);//side INNER
//draw_sprite_3d_pos(sprSidewalk,0,x+120,y,64,-90,90,0,0,0,0,8,56,64,64,64); //side top
draw_sprite_3d_pos(sprSidewalk,0,x+128,y,256,0,135,0,0,0,0,32,90.5,32,90.5,0);
draw_sprite_3d_pos(sprSidewalk,0,x+120,y,256,0,135,0,0,0,0,32,84,32,84,0);//back
draw_sprite_3d_pos(sprSidewalk,0,x+64,y,256,-90,0,0,0,64,64,0,56,0,0,56); //top

//left
draw_sprite_3d_pos(sprSidewalk,0,x,y,64,0,135,0,0,0,0,32,90.5,32,90.5,0);
//draw_sprite_3d_part(sprSidewalk,0,x,y,72,0,135,0,32,0,64,32,1,1,c_white,1); //back
draw_sprite_3d_pos(sprSidewalk,0,x,y,72,0,135,0,0,0,0,32,84,32,84,0);//back
draw_sprite_3d_pos(sprSidewalk,0,x-64,y,64,-90,0,0,0,64,8,64,64,0,64,8);//top
draw_sprite_3d_part(sprSidewalk,0,x-64,y,128,-90,0,0,0,0,8,64,1,1,c_white,1);//side top
draw_sprite_3d_part(sprSidewalk,0,x-64,y,128,0,90,0,32,0,64,32,1,1,c_white,1); //otuside side
draw_sprite_3d_part(sprSidewalk,0,x-56,y,128,0,90,0,32,0,64,32,1,1,c_white,1); //inside side

draw_sprite_3d_part(sprSidewalk,0,x-64,y,192,-90,0,0,0,0,8,64,1,1,c_white,1);//side top
draw_sprite_3d_part(sprSidewalk,0,x-64,y,192,0,90,0,32,0,64,32,1,1,c_white,1); //otuside side
draw_sprite_3d_part(sprSidewalk,0,x-56,y,192,0,90,0,32,0,64,32,1,1,c_white,1); //inside side

draw_sprite_3d_pos(sprSidewalk,0,x-64,y,256,0,45,0,0,0,0,32,90.5,32,90.5,0);
draw_sprite_3d_pos(sprSidewalk,0,x-56,y,256,0,45,0,0,0,0,32,84,32,84,0);//back
draw_sprite_3d_pos(sprSidewalk,0,x-64,y,256,-90,0,0,0,0,8,0,64,56,64,64,8);//top

///back
draw_sprite_3d_part(sprSidewalk,0,x,y,320,0,0,0,32,0,64,32,1,1,c_white,1);
draw_sprite_3d_part(sprSidewalk,0,x,y,312,0,0,0,32,0,64,32,1,1,c_white,1); //back
draw_sprite_3d_part(sprSidewalk,0,x,y,320,90,0,0,32,0,64,8,1,1,c_white,1); //top



//dirt
//draw_sprite_3d_pos(sprDirtLow,0,0,16,72,90,0,0,0,0,56,56,120,56,64,0);
//tree
draw_sprite_3d(sprCityTree,0,32,8,136,0,0,0,0);
draw_sprite_3d(sprCityTree,1,32,8,132,0,0,0,0);
draw_sprite_3d(sprCityTree,2,32,8,128,0,0,0,0); //Trunk
draw_sprite_3d(sprCityTree,3,32,8,124,0,0,0,0);
draw_sprite_3d(sprCityTree,4,32,8,120,0,0,0,0);


gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);
