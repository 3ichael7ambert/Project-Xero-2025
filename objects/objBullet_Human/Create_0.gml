owner=undefined;
target=undefined;
parent=undefined;
homing=false;
life_limit=false;
life_countdown=0;
decay=room_speed*2;
grav = 0;           // Initial vertical speed
grav_accel = 0;   // Acceleration due to gravity
grav_max = 0;      // Maximum falling speed
bounce_factor = 0; // How much energy is retained after bouncing (-1 = perfect bounce, less than -1 = energy loss)
bounce=false;
h_speed = 0;         // Horizontal speed
h_friction = 0;   // Friction applied to horizontal movement
scale=1;
punch_side="front";
following_player = false;
xx=x;
yy=y;

attack=1;
bullet_speed=10;
species="";

weapon=0;

if (weapon==3) {
wpn_charge=2;
} else {
wpn_charge=0;
}

wpn_charge_max=10;
charging=false;

floor_obj=undefined;



hitbox=false;



if (homing==true) {
	
}



