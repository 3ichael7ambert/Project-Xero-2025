/// @description Insert description here
// You can write your code in this editor

switch (player) {
	case 1:
		global.health-=other.attack;
		break;
	case 2:
		global.p2_health-=other.attack;
		break;
	case 3:
		global.p3_health-=other.attack;
		break;
	case 4:
		global.p4_health-=other.attack;
		break;
}
	
with (other) {instance_destroy();}

if (room == rmCity) {
	cam_shake(10,10);
}
