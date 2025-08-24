/// @description Initialize the Mission Manager and start a quest

// Run the setup function from the MissionSystem script to establish the singleton
mission_manager_setup();

// For demonstration, let's automatically activate our first mission.
// In a real game, you might do this when a player talks to an NPC.
/*
if (get_mission_status("SQ_001_Rubble") == MISSION_STATUS.NotStarted)
{
    activate_mission("SQ_001_Rubble");
}
*/