/// @description  DRAW THE BOTTOM AND THE SIDES IN THE DRAW EVENT
//  SO THAT THEY WILL NOT COVER THE TOP OF OTHER CUBES

draw_self();

// LEFT
draw_sprite_pos(sprHouseSides,0,x,y,x-hdepth,y-vdepth,x-hdepth,y+128-vdepth,x,y+128,1);

// RIGHT
draw_sprite_pos(sprHouseSides,0,x+128,y,x+128-hdepth,y-vdepth,x+128-hdepth,y+128-vdepth,x+128,y+128,1);

// TOP
draw_sprite_pos(sprHouseSides,0,x-hdepth,y-vdepth,x+128-hdepth,y-vdepth,x+128,y,x,y,1);

// BOTTOM
draw_sprite_pos(sprHouseFront,0,x-hdepth,y+128-vdepth,x+128-hdepth,y+128-vdepth,x+128,y+128,x,y+128,1);

