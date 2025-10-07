// step begin
if !variable_global_exists("health") {global.health=100;}
if !variable_global_exists("p2_health") {global.p2_health=100;}
if !variable_global_exists("p3_health") {global.p3_health=100;}
if !variable_global_exists("p4_health") {global.p4_health=100;}

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