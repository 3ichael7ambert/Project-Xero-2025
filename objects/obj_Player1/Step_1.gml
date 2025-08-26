if (global.health<=0 && player==1) {
	instance_destroy();
}

if (global.p2_health<=0 && player==2) {
	instance_destroy();
}

if (global.p3_health<=0 && player==3) {
	instance_destroy();
}

if (global.p4_health<=0 && player==4) {
	instance_destroy();
}

//nearest human accept mission
if (instance_exists(objHuman)) {
	nearest_human = instance_nearest(x,y,objHuman);
} else {
	nearest_human = noone;
}

mission_talk();