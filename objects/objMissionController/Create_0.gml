/// @description Insert description here
// You can write your code in this editor
global.missions = [];
global.mission_active = false;
global.current_mission = noone;
global.mission_target_kills = 0;
global.mission_kill_count = -1;


global.missions[0] = createMission(
    1,
    "Flamethrower Cleanup",
    "Kill 10 robot enemies using only the flamethrower.",
    "battle",
    [{type: "kill", target: obj_Enemy_Robot, amount: 10}],
    {weapons: 10, jetpacks: [], time_limit: -1},
    ["50 gold", "New Armor"]
);

global.missions[1] = createMission(
    2,
    "Chase the Drone",
    "Catch the runaway drone in 30 seconds.",
    "chase",
    [{type: "catch", target: objMissionEnemy, amount:1}],
    {weapons: [], jetpacks: [2], time_limit: 30},
    ["75 gold", "Speed Booster"]
);

global.missions[2] = createMission(
    3,
    "1v1 Duel",
    "Defeat the rival swordsman in a fair duel.",
    "duel",
    [{type: "kill", target: obj_Enemy_Robot, amount: 1}],
    {weapons: 2, jetpacks: [], time_limit: -1},
    ["Legendary Sword"]
);
