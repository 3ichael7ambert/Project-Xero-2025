/// @description Insert description here
// You can write your code in this editor
global.missions = [];

global.missions[0] = createMission(
    1,
    "Flamethrower Cleanup",
    "Kill 10 robot enemies using only the flamethrower.",
    "battle",
    [{type: "kill", target: objEnemyRobot, amount: 10}],
    {weapons: [flamethrower_id], jetpacks: [], time_limit: -1},
    ["50 gold", "New Armor"]
);

global.missions[1] = createMission(
    2,
    "Chase the Drone",
    "Catch the runaway drone in 30 seconds.",
    "chase",
    [{type: "catch", target: objDrone}],
    {weapons: [], jetpacks: [2], time_limit: 30},
    ["75 gold", "Speed Booster"]
);

global.missions[2] = createMission(
    3,
    "1v1 Duel",
    "Defeat the rival swordsman in a fair duel.",
    "duel",
    [{type: "kill", target: objEnemySwordsman, amount: 1}],
    {weapons: [sword_id], jetpacks: [], time_limit: -1},
    ["Legendary Sword"]
);
