/// @description Insert description here
// You can write your code in this editor
// objMissionNPC - Collision/Interaction Event
var mission = global.missions[|other.mission_num]; // Example: Pick a mission to check

if (mission.status == "not_started") {
    // Accept the mission
    mission.status = "in_progress";
    show_message("Mission started: " + mission.name);
} else if (mission.status == "in_progress") {
    show_message("Mission in progress: " + mission.description);
} else if (mission.status == "completed") {
    show_message("Mission already completed!");
}
