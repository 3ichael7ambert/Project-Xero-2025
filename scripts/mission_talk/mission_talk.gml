function mission_talk(){

if (talk_button) && (distance_to_object(nearest_human)<(100*scale)) {
	with (nearest_human) {
		if (has_mission) {
			
			mission_active=true;
			
			with (oMissionManager) {
				if (get_mission_status("SQ_001_Kill_Ten_Birds") == MISSION_STATUS.NotStarted)
				{
					for (i=0;i<10;i++) {
						instance_create(random(room_width),random(room_height-500),objMissionTarget);
					}
					
				    activate_mission("SQ_001_Kill_Ten_Birds");
					
					
				}
			}
		}
	}
	
}

}