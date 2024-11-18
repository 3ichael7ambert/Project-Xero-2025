/*
	[1] Object Role
	 |
	 |	This object is only for user input handling within this demo.
	 |	It is not necessary to the ragdoll (Except for the "global.floorObjs" variable).
	 | 
	[-]
*/

//Register some objests that meant to be floor.
//Notice that you have to create a collision event within 'o_ragSpawner'-
//for each floor object you want the ragdoll to collide with.
global.floorObjs = [o_floor, o_floor2];

global.surf_outline = surface_create(room_width,room_height);
surf_final = surface_create(room_width,room_height);
global.pause = 0;
global.debugMode = 0;

draw_set_font(fnt_sbRagdoll);

room_speed = 60;
physics_world_update_iterations(10);
physics_world_update_speed(60);

showTips = true;
tipsStr = @"E - Spawn a ragdoll
Q - Spawn a crate
R - Change facing direction
A/D - Walk
W/Up - Jump
Left/Right - Push

RMB - Drag
LMB - Shoot
Enter - Change room
Space - Pause / Unpause
Alt - Toggle debug view
F5 - Restart

F1 - Toggle tips
"

