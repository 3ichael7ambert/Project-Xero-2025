// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createMission(_id, _name, _description, _objectives, _rewards) {
    return {
        id: _id,
        name: _name,
        description: _description,
        status: "not_started",
        objectives: _objectives, // e.g., [{goal: "Collect 5 apples", completed: false}]
        rewards: _rewards
    };
}


function saveMissions() {
    var save_data = json_stringify(global.missions);
    ini_open("savefile.ini");
    ini_write_string("Game", "Missions", save_data);
    ini_close();
}

function loadMissions() {
    ini_open("savefile.ini");
    var save_data = ini_read_string("Game", "Missions", "");
    ini_close();
    if (save_data != "") {
        global.missions = json_parse(save_data);
    }
}
