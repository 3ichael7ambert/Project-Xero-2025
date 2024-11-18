/// @description  DRAW THE BOTTOM AND THE SIDES IN THE DRAW EVENT
//  SO THAT THEY WILL NOT COVER THE TOP OF OTHER CUBES

draw_self();

// LEFT
draw_sprite_pos(sprCaveSide,0,x,y,x-hdepth,y-vdepth,x-hdepth,y+32-vdepth,x,y+32,1);

// RIGHT
draw_sprite_pos(sprCaveSide,0,x+32,y,x+32-hdepth,y-vdepth,x+32-hdepth,y+32-vdepth,x+32,y+32,1);

// TOP
draw_sprite_pos(sprCaveSide,0,x-hdepth,y-vdepth,x+32-hdepth,y-vdepth,x+32,y,x,y,1);

// BOTTOM
draw_sprite_pos(sprCaveSide,0,x-hdepth,y+32-vdepth,x+32-hdepth,y+32-vdepth,x+32,y+32,x,y+32,1);

