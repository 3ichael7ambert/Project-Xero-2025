/// @description Insert description here
// You can write your code in this editor
// objCityController - Draw Event
for (var i = 0; i < array_length(global.missions); i++) {
    var mission = global.missions[ i];
    draw_text(10, 10 + i * 20, mission.name + ": " + mission.status);
}

if (global.mission_active) {
    draw_text(32, 32, "Mission: " + global.current_mission.mission_id);
    draw_text(32, 48, "Kills: " + string(global.mission_kill_count) + " / " + string(global.mission_target_kills));
}
