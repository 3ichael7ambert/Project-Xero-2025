/// @description Insert description here
// You can write your code in this editor
for (var i = 0; i < array_length(global.missions); i++) {
    var mission = global.missions[i];
    if (mission.status == "Active") {
        var all_complete = true;
        for (var j = 0; j < array_length(mission.objectives); j++) {
            var objective = mission.objectives[j];
            if (objective.type == "kill" || objective.type == "collect") {
                if (objective.current < objective.amount) {
                    all_complete = false;
                }
            }
            if (objective.type == "catch") {
                if (!objective.completed) {
                    all_complete = false;
                }
            }
        }
        if (all_complete) {
            mission.status = "Complete";
            // Give rewards!
        }
    }
}
