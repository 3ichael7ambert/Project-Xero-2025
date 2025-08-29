function create_missions() {
    global.MISSIONS = [
       {
         "id": "SQ_001_Kill_Ten_Birds",
         "name": "M1: Hunt Ten Birds",
         "description": "The Pidgeons",
         "on_complete_callback": "mission_sq001_complete_callback", // **NEW** Define the callback name
         "objectives": [
           { "type": "kill", "target": "objMissionTarget", "amount": "dynamic_count" }
         ],
         "rewards": [
           { "type": "xp", "amount": 100 }
         ],
         "prerequisites": [],
         "time_limit": -1
       },
	   
	    /// --- ///
		
		 /// --- ///
	   
	   {
         "id": "SQ_002_99_Red_Balloons",
         "name": "M2: Clear the Rubble",
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
       },
	   
	    /// --- ///
		
		 /// --- ///
	    {
         "id": "SQ_003_Tag",
         "name": "M3: Clear the Rubble",
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
       },
	   
	    /// --- ///
		
		 /// --- ///
	   {
         "id": "SQ_004_Stop_Light",
         "name": "M4: Cross the city ",
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
       },
	   
	   {
         "id": "SQ_005_Clone_PvP",
         "name": "M5: Cross the city ",
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
       },
	   /// --- ///
	   
	    /// --- ///
	   
	   {
         "id": "SQ_006_Run_Tag",
         "name": "M6: Cross the city ",
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
       },
	   
	    /// --- ///
		
		 /// --- ///
	   
	    {
         "id": "SQ_007_Music_Challenge_1",
         "name": "M7:Cross the city ",
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
       },
	   
	    /// --- ///
		
		 /// --- ///
		 
		  {
         "id": "SQ_009_Boss_Tribal",
         "name": "M8: Cross the city ",
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
       },
	   
	    {
         "id": "SQ_009_Gravity_Shot",
         "name": "M9:Cross the city ",
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
       },
	   
	   
	    /// --- ///
		
		 /// --- ///
		 
	    {
         "id": "SQ_010_Kaiju_Trex",
         "name": "M10: Cross the city ",
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
       },
	   
	   
	   
	   
    ];
}