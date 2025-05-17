/// @description Insert description here
// You can write your code in this editor

report_kill(mission_id, objective_id);
if (global.mission_active) {
    global.mission_kill_count += 1;
}
instance_destroy();
