/// @description Insert description here
// You can write your code in this editor
// objCityController - Draw Event
for (var i = 0; i < array_length(global.missions); i++) {
    var mission = global.missions[| i];
    draw_text(10, 10 + i * 20, mission.name + ": " + mission.status);
}
