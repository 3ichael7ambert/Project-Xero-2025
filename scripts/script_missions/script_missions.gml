// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function scrMission(){

}



/////////////////////
function createMission(_id, _name, _description, _type, _objectives, _limits, _rewards) {
    return {
        id: _id,
        name: _name,
        description: _description,
        type: _type, // "collect", "battle", "chase", "duel"
        objectives: _objectives, // array of { type: "kill", target: objEnemyRobot, amount: 10 }
        limits: _limits,         // { weapons: [2,3], jetpacks: [2], time_limit: 30 }
        rewards: _rewards,       // ["10 gold", "1 sword"]
        status: "Not Started"    // "Not Started", "Active", "Complete"
    };
}


/////////////////////

function saveMissions() {
    var save_data = json_stringify(global.missions);
    ini_open("savefile.ini");
    ini_write_string("Game", "Missions", save_data);
    ini_close();
}

/////////////////////
function loadMissions() {
    ini_open("savefile.ini");
    var save_data = ini_read_string("Game", "Missions", "");
    ini_close();
    if (save_data != "") {
        global.missions = json_parse(save_data);
    }
}


/////////////////////
//kill enemy mission
function report_kill(target_obj) {
    for (var i = 0; i < array_length(global.missions); i++) {
        var mission = global.missions[i];
        if (mission.status == "Active") {
            for (var j = 0; j < array_length(mission.objectives); j++) {
                var objective = mission.objectives[j];
                if (objective.type == "kill" && objective.target == target_obj) {
                    if (!variable_instance_exists(objective, "current")) objective.current = 0;
                    objective.current += 1;
                }
            }
        }
    }
}
/*
function report_kill(mission_id, objective_id) {
    var mission = global.missions[mission_id];
    var objective = mission.objectives[objective_id];
    
    if (!variable_instance_exists(objective, "current")) objective.current = 0;
    objective.current += 1;
}
*/




/////////////////////


function activate_mission(mission_id) {
    var mission = global.missions[mission_id];
    
    mission.status = "Active";
    
    for (var i = 0; i < array_length(mission.objectives); i++) {
        var objective = mission.objectives[i];
        
        switch (objective.type) {
            case "kill":
                for (var j = 0; j < objective.amount; j++) {
                    var enemy = instance_create_layer(random(room_width), random(room_height), "Enemies", objMissionEnemy);
                    enemy.mission_id = mission_id;
                    enemy.objective_id = i; // Know which objective it belongs to
                    enemy.enemy_type = objective.target; // Ex: objEnemyRobot
                }
                break;
                
            case "collect":
                for (var j = 0; j < objective.amount; j++) {
                    var item = instance_create_layer(random(room_width), random(room_height), "Items", objMissionItem);
                    item.mission_id = mission_id;
                    item.objective_id = i;
                    item.item_type = objective.target; // Ex: objApple
                }
                break;
                
            case "catch":
                var runner = instance_create_layer(random(room_width), random(room_height), "Enemies", objMissionEnemy);
                runner.mission_id = mission_id;
                runner.objective_id = i;
                runner.enemy_type = objective.target; // Ex: objDrone
                runner.is_runner = true;
                break;
        }
    }
}
/////////////////////////
function report_collect(mission_id, objective_id) {
    var mission = global.missions[mission_id];
    var objective = mission.objectives[objective_id];
    
    if (!variable_instance_exists(objective, "current")) objective.current = 0;
    objective.current += 1;
}


//global.missions = json_parse(response_text);
