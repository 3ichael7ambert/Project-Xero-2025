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

if (talk_button) && (distance_to_object(nearest_human)<(100*scale)) {
	with (nearest_human) {
		if (has_mission) {
			
			mission_active=true;
			
			with (oMissionManager) {
				if (get_mission_status("SQ_001_Rubble") == MISSION_STATUS.NotStarted)
				{
				    activate_mission("SQ_001_Rubble");
				}
			}
		}
	}
	
}