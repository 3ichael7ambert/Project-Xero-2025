function create_missions() {
    global.MISSIONS = [
       {
         "id": "SQ_001_Rubble",
         "name": "Clear the Rubble",
         "description": "The path is blocked by ancient, fragile walls. Clear them out.",
         "on_complete_callback": "mission_sq001_complete_callback", // **NEW** Define the callback name
         "objectives": [
           { "type": "kill", "target": "objMissionTarget", "amount": "dynamic_count" }
         ],
         "rewards": [
           { "type": "xp", "amount": 100 }
         ],
         "prerequisites": [],
         "time_limit": -1
       }
    ];
}