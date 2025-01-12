/// @description Insert description here
// You can write your code in this editor
global.missions = [];

global.missions[| 0] = createMission(
    1, 
    "Collect Apples", 
    "Find and collect 5 apples for the baker.", 
    [{goal: "Collect 5 apples", completed: false}], 
    ["10 gold", "1 loaf of bread"]
);

global.missions[| 1] = createMission(
    2, 
    "Defeat Enemies", 
    "Defeat 10 goblins outside the city.", 
    [{goal: "Defeat 10 goblins", completed: false}], 
    ["20 gold", "1 sword upgrade"]
);
