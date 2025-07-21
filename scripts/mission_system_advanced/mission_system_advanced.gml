/// @description Enum for the status of a mission
/*
enum MISSION_STATUS {
    NotStarted,
    Active,
    Completed,
    Failed
}

/// @description Enum for game events the mission system listens to
enum MISSION_EVENT {
    ENEMY_KILLED,
    ITEM_COLLECTED,
    ENTER_AREA,
    TALK_TO_NPC,
    DIALOGUE_FINISHED,
    INTERACT_WITH_OBJECT,
    PLAYER_LEVEL_UP
    // Add any other game events you might need here
}

/// @function MissionObjective(_type, _target_id, _amount)
/// @description Base constructor for a mission objective.
/// @param {string|enum} _type         The type of objective (e.g., "kill", "collect").
/// @param {any}         _target_id    The target (e.g., obj_Enemy, "itm_Key").
/// @param {int}         _amount       The required quantity for completion.
function MissionObjective(_type, _target_id, _amount) constructor {
    type = _type;
    target_id = _target_id;
    amount = _amount;
    
    current = 0;
    is_completed = false;
    is_optional = false;
    
    /// @description Checks if the incoming event makes progress on this objective.
    /// @param {MISSION_EVENT} _event_type The type of event that occurred.
    /// @param {struct}        _event_data Data associated with the event.
    /// @returns {bool} true if progress was made, false otherwise.
    static check_progress = function(_event_type, _event_data) {
        // This base method does nothing and should be overridden by derived types.
        return false;
    }
    
    /// @description Gets the string for UI display (e.g., "Kill 3/5 Goblins").
    /// @returns {string} The formatted display string for this objective.
    static get_display_string = function() {
        // This base method is a fallback and should be overridden.
        return $"Objective: {self.type} ({self.current}/{self.amount})";
    }
}

/// @function ObjectiveKill(_target_obj_index, _amount)
/// @description Objective to kill a certain number of a specific enemy type.
/// @param {Asset.GMObject} _target_obj_index The object index of the enemy to kill.
/// @param {int}            _amount           The number of enemies to kill.
function ObjectiveKill(_target_obj_index, _amount) : MissionObjective("kill", _target_obj_index, _amount) constructor {

    static check_progress = function(_event_type, _event_data) {
        // We only care about ENEMY_KILLED events where the enemy type matches our target.
        if (_event_type == MISSION_EVENT.ENEMY_KILLED && _event_data.enemy_object_index == self.target_id) {
            if (!self.is_completed) {
                self.current = min(self.current + 1, self.amount); // Safely increment
                
                if (self.current >= self.amount) {
                    self.is_completed = true;
                }
                show_debug_message($"Kill Objective Progress: {self.get_display_string()}");
                return true; // Progress was made
            }
        }
        return false; // No progress
    }
    
    static get_display_string = function() {
        // Get the "friendly" name of the object to display in the UI.
        var _target_name = object_get_name(self.target_id);
        return $"Kill {_target_name}s: {self.current}/{self.amount}";
    }
}

/// @function ObjectiveCollect(_target_item_id_string, _amount)
/// @description Objective to collect a certain number of a specific item.
/// @param {string} _target_item_id_string The unique ID string of the item to collect.
/// @param {int}    _amount                The number of items to collect.
function ObjectiveCollect(_target_item_id_string, _amount) : MissionObjective("collect", _target_item_id_string, _amount) constructor {
    
    static check_progress = function(_event_type, _event_data) {
        // We only care about ITEM_COLLECTED events where the item ID matches our target.
        if (_event_type == MISSION_EVENT.ITEM_COLLECTED && _event_data.item_id == self.target_id) {
            if (!self.is_completed) {
                self.current = min(self.current + 1, self.amount); // Safely increment
                
                if (self.current >= self.amount) {
                    self.is_completed = true;
                }
                show_debug_message($"Collect Objective Progress: {self.get_display_string()}");
                return true; // Progress was made
            }
        }
        return false; // No progress
    }
    
    static get_display_string = function() {
        // You might have a global map or function to get a friendly name from an item ID.
        // For now, we'll just use the ID itself.
        var _item_name = self.target_id; 
        return $"Collect {_item_name}: {self.current}/{self.amount}";
    }
}

/// @function ObjectiveLocation(_location_id_string)
/// @description Objective to reach a specific location.
/// @param {string} _location_id_string The unique ID string of the location trigger.
function ObjectiveLocation(_location_id_string) : MissionObjective("location", _location_id_string, 1) constructor {

    static check_progress = function(_event_type, _event_data) {
        // We only care about ENTER_AREA events where the area ID matches our target.
        if (_event_type == MISSION_EVENT.ENTER_AREA && _event_data.area_id == self.target_id) {
            if (!self.is_completed) {
                self.current = 1;
                self.is_completed = true;
                show_debug_message($"Location Objective Progress: {self.get_display_string()}");
                return true; // Progress was made
            }
        }
        return false;
    }
    
    static get_display_string = function() {
        // You might map location IDs to friendly names like "The Goblin Cave".
        var _location_name = self.target_id;
        return self.is_completed ? $"Reached {_location_name}" : $"Go to {_location_name}";
    }
}

/// @function ObjectiveTalkToNPC(_npc_id_string)
/// @description Objective to talk to a specific NPC.
/// @param {string} _npc_id_string The unique ID string of the NPC.
function ObjectiveTalkToNPC(_npc_id_string) : MissionObjective("talk", _npc_id_string, 1) constructor {

    static check_progress = function(_event_type, _event_data) {
        // This can be simple or complex. Here, we assume finishing any dialogue with the NPC counts.
        // You could extend _event_data to include dialogue tree IDs for more specific objectives.
        if (_event_type == MISSION_EVENT.DIALOGUE_FINISHED && _event_data.npc_id == self.target_id) {
            if (!self.is_completed) {
                self.current = 1;
                self.is_completed = true;
                show_debug_message($"Talk Objective Progress: {self.get_display_string()}");
                return true; // Progress was made
            }
        }
        return false;
    }
    
    static get_display_string = function() {
        // You might map NPC IDs to their actual names.
        var _npc_name = self.target_id;
        return self.is_completed ? $"Spoke with {_npc_name}" : $"Talk to {_npc_name}";
    }
}

/// @function Mission(_id, _name, _description, _objectives_array, _rewards_array, _prerequisites_array = [])
/// @description Constructor for a single Mission instance.
function Mission(_id, _name, _description, _objectives_array, _rewards_array, _prerequisites_array = []) constructor {
    id = _id;
    name = _name;
    description = _description;
    objectives = _objectives_array;
    rewards = _rewards_array;
    prerequisites = _prerequisites_array;
    
    status = MISSION_STATUS.NotStarted;
    time_limit = -1; // -1 means no time limit
    current_time_elapsed = 0;
    
    // Optional script callbacks
    on_mission_complete_script = undefined;
    on_mission_fail_script = undefined;

    /// @description Checks if all non-optional objectives are met.
    /// @returns {bool} true if mission is complete, false otherwise.
    static check_completion = function() {
        for (var i = 0; i < array_length(self.objectives); i++) {
            var _obj = self.objectives[i];
            // If we find any objective that is not optional and not completed, the mission isn't done yet.
            if (!_obj.is_optional && !_obj.is_completed) {
                return false;
            }
        }
        // If we get through the whole loop, all required objectives are done.
        return true;
    }

    /// @description Sets the mission's status and handles associated logic.
    /// @param {MISSION_STATUS} _new_status The new status for the mission.
    static set_status = function(_new_status) {
        if (self.status == _new_status) return; // No change

        show_debug_message($"Mission '{self.name}' status changed to: {string(_new_status)}");
        self.status = _new_status;

        // Use the global manager to handle state changes
        var _manager = global.mission_manager;
        if (!instance_exists(_manager)) return;

        switch (_new_status) {
            case MISSION_STATUS.ACTIVE:
                // Logic for when mission starts (e.g., start timer)
                self.current_time_elapsed = 0;
                break;
            
            case MISSION_STATUS.COMPLETED:
                _manager.grant_rewards(self);
                if (is_callable(self.on_mission_complete_script)) {
                    self.on_mission_complete_script();
                }
                _manager.complete_active_mission(self.id);
                break;
            
            case MISSION_STATUS.FAILED:
                if (is_callable(self.on_mission_fail_script)) {
                    self.on_mission_fail_script();
                }
                _manager.fail_active_mission(self.id);
                break;
        }
    }
}

/// @function global.event_bus_post(_event_type, _event_data)
/// @description Broadcasts a game event to all listening systems.
/// @param {MISSION_EVENT} _event_type The type of event that occurred.
/// @param {struct}        _event_data A struct containing relevant data about the event.
function event_bus_post(_event_type, _event_data) {
    // Notify the Mission Manager
    if (instance_exists(global.mission_manager)) {
        global.mission_manager.on_game_event(_event_type, _event_data);
    }
    
    // You could easily extend this to notify other systems, like an Achievement Manager.
    // if (instance_exists(global.achievement_manager)) {
    //     global.achievement_manager.on_game_event(_event_type, _event_data);
    // }
    
    show_debug_message($"Event Posted: {string(_event_type)} with data: {string(_event_data)}");
}

/// @description All methods for the o_MissionManager instance.

/// @function init_missions()
/// @description Loads all mission definitions from an external file.
static init_missions = function() {
    self.available_missions = {};
    var _file_name = "missions.json"; // Should be in the "Included Files"
    
    if (!file_exists(_file_name)) {
        show_debug_message($"ERROR: Mission definition file not found: {_file_name}");
        return;
    }
    
    var _buffer = buffer_load(_file_name);
    var _json_string = buffer_read(_buffer, buffer_text);
    buffer_delete(_buffer);
    
    var _mission_data_array;
    try {
        _mission_data_array = json_parse(_json_string);
    } catch (_err) {
        show_debug_message($"ERROR: Failed to parse {_file_name}. Check for syntax errors.");
        show_debug_message(_err.longMessage);
        return;
    }
    
    if (!is_array(_mission_data_array)) {
        show_debug_message($"ERROR: Root of {_file_name} is not a JSON array.");
        return;
    }
    
    for (var i = 0; i < array_length(_mission_data_array); i++) {
        var _data = _mission_data_array[i];
        
        // --- Build Objectives ---
        var _objectives = [];
        if (is_array(_data.objectives)) {
            for (var j = 0; j < array_length(_data.objectives); j++) {
                var _obj_data = _data.objectives[j];
                var _target = variable_struct_get(_obj_data, "target");
                var _amount = variable_struct_get(_obj_data, "amount");
                
                switch (_obj_data.type) {
                    case "kill":
                        // asset_get_index converts the string name from JSON to a real object index
                        var _obj_index = asset_get_index(_target);
                        if (_obj_index > -1) {
                            array_push(_objectives, new ObjectiveKill(_obj_index, _amount));
                        } else {
                            show_debug_message($"WARNING: Unknown object '{_target}' for kill objective in mission '{_data.id}'");
                        }
                        break;
                    case "collect":
                        array_push(_objectives, new ObjectiveCollect(_target, _amount));
                        break;
                    case "location":
                         array_push(_objectives, new ObjectiveLocation(_target));
                        break;
                    case "talk":
                         array_push(_objectives, new ObjectiveTalkToNPC(_target));
                        break;
                    default:
                        show_debug_message($"WARNING: Unknown objective type '{_obj_data.type}' in mission '{_data.id}'");
                        break;
                }
            }
        }
        
        // --- Build Mission ---
        var _mission = new Mission(
            _data.id,
            _data.name,
            _data.description,
            _objectives,
            variable_struct_get(_data, "rewards"),
            variable_struct_get(_data, "prerequisites")
        );
        
        // Set optional properties
        if (variable_struct_exists(_data, "time_limit")) {
            _mission.time_limit = _data.time_limit;
        }

        self.available_missions[$ _mission.id] = _mission;
    }
    show_debug_message($"Successfully loaded {struct_names_count(self.available_missions)} missions.");
}

/// @function activate_mission(_mission_id)
/// @description Attempts to start a mission.
static activate_mission = function(_mission_id) {
    // 1. Check if mission exists
    if (!variable_struct_exists(self.available_missions, _mission_id)) {
        show_debug_message($"Attempted to activate non-existent mission: {_mission_id}");
        return false;
    }
    
    // 2. Check if mission is already active, completed, or failed
    if (self.get_mission_status(_mission_id) != MISSION_STATUS.NotStarted) {
        show_debug_message($"Attempted to activate mission '{_mission_id}' which is not in 'NotStarted' state.");
        return false;
    }
    
    var _mission_def = self.available_missions[$ _mission_id];
    
    // 3. Check prerequisites
    for (var i = 0; i < array_length(_mission_def.prerequisites); i++) {
        var _prereq_id = _mission_def.prerequisites[i];
        if (array_find_index(self.completed_missions, _prereq_id) == -1) {
            show_debug_message($"Cannot activate mission '{_mission_id}'. Prerequisite '{_prereq_id}' not met.");
            return false;
        }
    }
    
    // 4. All checks passed. Create a new instance and activate it.
    // We create a new Mission instance to ensure the one in `available_missions` remains a pristine template.
    var _new_active_mission = new Mission(
        _mission_def.id, 
        _mission_def.name, 
        _mission_def.description, 
        _mission_def.objectives, // The objectives array can be shared as their state is managed internally
        _mission_def.rewards, 
        _mission_def.prerequisites
    );
    _new_active_mission.time_limit = _mission_def.time_limit; // Copy over time limit
    
    _new_active_mission.set_status(MISSION_STATUS.ACTIVE);
    array_push(self.active_missions, _new_active_mission);
    
    show_debug_message($"Mission '{_mission_id}' activated!");
    return true;
}

/// @function on_game_event(_event_type, _event_data)
/// @description The central event listener that processes game events.
static on_game_event = function(_event_type, _event_data) {
    // Loop backwards because a mission might be completed and removed from the array during iteration.
    for (var i = array_length(self.active_missions) - 1; i >= 0; i--) {
        var _mission = self.active_missions[i];
        var _progress_made = false;
        
        for (var j = 0; j < array_length(_mission.objectives); j++) {
            var _obj = _mission.objectives[j];
            if (_obj.check_progress(_event_type, _event_data)) {
                _progress_made = true;
            }
        }
        
        // If any objective progressed, check if the whole mission is now complete.
        if (_progress_made) {
            if (_mission.check_completion()) {
                _mission.set_status(MISSION_STATUS.COMPLETED);
            }
        }
    }
}

/// @function get_mission_status(_mission_id)
/// @description Returns the status of a specific mission.
static get_mission_status = function(_mission_id) {
    if (array_find_index(self.completed_missions, _mission_id) > -1) {
        return MISSION_STATUS.Completed;
    }
    if (array_find_index(self.failed_missions, _mission_id) > -1) {
        return MISSION_STATUS.Failed;
    }
    for (var i = 0; i < array_length(self.active_missions); i++) {
        if (self.active_missions[i].id == _mission_id) {
            return MISSION_STATUS.Active;
        }
    }
    return MISSION_STATUS.NotStarted;
}

/// @function grant_rewards(_mission)
/// @description Distributes rewards for a completed mission.
static grant_rewards = function(_mission) {
    show_debug_message($"Granting rewards for mission '{_mission.name}'");
    for (var i = 0; i < array_length(_mission.rewards); i++) {
        var _reward = _mission.rewards[i];
        show_debug_message($"  - Reward: {string(_reward)}");
        // Here, you would call your actual player/inventory management systems.
        // For example:
        // switch (_reward.type) {
        //     case "gold": global.player.add_gold(_reward.amount); break;
        //     case "xp": global.player.add_xp(_reward.amount); break;
        //     case "item": global.inventory.add_item(_reward.item_id, _reward.quantity); break;
        // }
    }
}

// These are internal helpers called by Mission.set_status
static complete_active_mission = function(_mission_id) {
    for (var i = array_length(self.active_missions) - 1; i >= 0; i--) {
        if (self.active_missions[i].id == _mission_id) {
            array_delete(self.active_missions, i, 1);
            break;
        }
    }
    array_push(self.completed_missions, _mission_id);
}

static fail_active_mission = function(_mission_id) {
    for (var i = array_length(self.active_missions) - 1; i >= 0; i--) {
        if (self.active_missions[i].id == _mission_id) {
            array_delete(self.active_missions, i, 1);
            break;
        }
    }
    array_push(self.failed_missions, _mission_id);
}

// --- SAVE/LOAD FUNCTIONS ---

/// @function save_game_missions()
/// @description Serializes mission progress to a JSON string.
static save_game_missions = function() {
    var _save_data = {
        completed_mission_ids: self.completed_missions,
        failed_mission_ids: self.failed_missions,
        active_missions_save_data: []
    };
    
    // Serialize active missions
    for (var i = 0; i < array_length(self.active_missions); i++) {
        var _mission = self.active_missions[i];
        var _mission_save = {
            id: _mission.id,
            time_elapsed: _mission.current_time_elapsed,
            objectives_progress: []
        };
        for (var j = 0; j < array_length(_mission.objectives); j++) {
            var _obj = _mission.objectives[j];
            // Only need to save current progress. is_completed can be derived.
            array_push(_mission_save.objectives_progress, _obj.current);
        }
        array_push(_save_data.active_missions_save_data, _mission_save);
    }
    
    var _json_string = json_stringify(_save_data);
    
    // Save the string (e.g., to an INI file)
    ini_open("save_game.ini");
    ini_write_string("Progress", "Missions", _json_string);
    ini_close();
    
    show_debug_message("Mission progress saved.");
    return _json_string;
}


/// @function load_game_missions()
/// @description Loads and restores mission progress from a saved state.
static load_game_missions = function() {
    // First, ensure we have fresh mission definitions loaded
    self.init_missions();
    
    ini_open("save_game.ini");
    var _json_string = ini_read_string("Progress", "Missions", "");
    ini_close();
    
    if (_json_string == "") {
        show_debug_message("No mission save data found to load.");
        return;
    }
    
    var _save_data;
    try {
        _save_data = json_parse(_json_string);
    } catch (_err) {
        show_debug_message("ERROR: Failed to parse mission save data.");
        return;
    }

    // Clear current dynamic state
    self.active_missions = [];
    self.completed_missions = [];
    self.failed_missions = [];

    // Restore completed and failed lists
    self.completed_missions = _save_data.completed_mission_ids;
    self.failed_missions = _save_data.failed_mission_ids;
    
    // Re-hydrate active missions
    var _active_missions_data = _save_data.active_missions_save_data;
    for (var i = 0; i < array_length(_active_missions_data); i++) {
        var _mission_save = _active_missions_data[i];
        var _id = _mission_save.id;
        
        // Find the definition for this mission
        if (variable_struct_exists(self.available_missions, _id)) {
            var _mission_def = self.available_missions[$ _id];
            
            // Create a new instance from the definition
             var _loaded_mission = new Mission(
                _mission_def.id, 
                _mission_def.name, 
                _mission_def.description, 
                _mission_def.objectives,
                _mission_def.rewards, 
                _mission_def.prerequisites
            );
            
            // Restore its state
            _loaded_mission.time_limit = _mission_def.time_limit;
            _loaded_mission.current_time_elapsed = _mission_save.time_elapsed;
            _loaded_mission.status = MISSION_STATUS.Active;
            
            // Restore objective progress
            for (var j = 0; j < array_length(_loaded_mission.objectives); j++) {
                var _obj = _loaded_mission.objectives[j];
                _obj.current = _mission_save.objectives_progress[j];
                if (_obj.current >= _obj.amount) {
                    _obj.is_completed = true;
                }
            }
            
            array_push(self.active_missions, _loaded_mission);
        }
    }
    show_debug_message("Mission progress loaded.");
}

///////////////////////////////////////
////
////		oMissionManager
////
///////////////////////////////////////

//==================== CREATE EVENT oMissionManager
/// @description Initialize the Mission Manager Singleton

// Singleton Pattern: Ensure only one mission manager exists.
// The first instance created registers itself as the global manager.
// Any subsequent instances destroy themselves.
if (variable_global_exists("mission_manager") && instance_exists(global.mission_manager) && global.mission_manager != self) {
    instance_destroy();
    exit; // Stop running the rest of the Create event
}
global.mission_manager = self;

// --- Method Binding ---
// We bind the static methods from the script to this specific instance.
// This makes calling them cleaner (e.g., self.init_missions() instead of a script_execute).
init_missions = init_missions;
activate_mission = activate_mission;
on_game_event = on_game_event;
get_mission_status = get_mission_status;
grant_rewards = grant_rewards;
save_game_missions = save_game_missions;
load_game_missions = load_game_missions;
complete_active_mission = complete_active_mission; // Internal helper
fail_active_mission = fail_active_mission;       // Internal helper

// --- Member Variables ---

// This holds the master definitions of all possible missions, loaded from JSON.
// Key: mission_id (string), Value: Mission struct (template)
available_missions = {}; 

// This holds the actual Mission struct instances the player is currently working on.
active_missions = [];

// These hold the IDs (strings) of missions for tracking history.
completed_missions = [];
failed_missions = [];

// --- Initialization ---

// Load all mission definitions from the JSON file into available_missions.
// We call load_game_missions instead, because it calls init_missions internally
// and then applies any saved progress on top. This is ideal for game startup.
// If you don't want to load on start, just call self.init_missions();
self.load_game_missions();

//==================== STEP EVENT oMissionManager
/// @description Handle time-limited missions

var _delta_seconds = delta_time / 1000000;

// Loop backwards in case a mission fails and is removed from the array
for (var i = array_length(self.active_missions) - 1; i >= 0; i--) {
    var _mission = self.active_missions[i];
    
    // If the mission has a time limit (and isn't already completed/failed)
    if (_mission.time_limit > 0) {
        _mission.current_time_elapsed += _delta_seconds;
        
        if (_mission.current_time_elapsed >= _mission.time_limit) {
            show_debug_message($"Mission '{_mission.name}' failed due to time limit.");
            _mission.set_status(MISSION_STATUS.FAILED);
        }
    }
}

//==================== SAVING oMissionManager
/// @description Save mission progress on game end.

self.save_game_missions();

//======================== EXAMPLES

///////////////////////////////////////
////
////		INCLUDED FILES missions.json
////
///////////////////////////////////////
[
  {
    "id": "MQ_001_FindSword",
    "name": "The Missing Blade",
    "description": "The blacksmith needs help retrieving his ancestral sword from the Goblin Cave.",
    "objectives": [
      {
        "type": "kill",
        "target": "obj_Goblin",
        "amount": 10
      },
      {
        "type": "location",
        "target": "loc_GoblinCaveDepths"
      },
      {
        "type": "collect",
        "target": "itm_AncestralSword",
        "amount": 1
      },
      {
        "type": "talk",
        "target": "o_NPC_Blacksmith"
      }
    ],
    "rewards": [
      { "type": "gold", "amount": 250 },
      { "type": "xp", "amount": 500 },
      { "type": "item", "item_id": "itm_HealingPotion", "quantity": 3 }
    ],
    "prerequisites": [],
    "time_limit": -1
  },
  {
    "id": "SQ_001_RatProblem",
    "name": "Rat Problem",
    "description": "Clear the cellar of pesky rats for the farmer.",
    "objectives": [
      {
        "type": "kill",
        "target": "obj_GiantRat",
        "amount": 5
      }
    ],
    "rewards": [
      { "type": "gold", "amount": 50 }
    ],
    "prerequisites": [],
    "time_limit": 120
  }
]

///////////////////////////////////////
////
////		oNPC_Blacksmith
////
///////////////////////////////////////

//==================== LEFT PRESSED oNPC_Blacksmith
// Check if the mission can be started
if (global.mission_manager.get_mission_status("MQ_001_FindSword") == MISSION_STATUS.NotStarted) {
    // Show some dialogue...
    // On player accepting...
    global.mission_manager.activate_mission("MQ_001_FindSword");
} else {
    // The mission is active or completed, show different dialogue.
    // ...
    // After finishing dialogue to complete the mission:
    event_bus_post(MISSION_EVENT.DIALOGUE_FINISHED, {
        npc_id: "o_NPC_Blacksmith" // Make sure this matches the target in the JSON
    });
}

///////////////////////////////////////
////
////		oEnemy
////
///////////////////////////////////////

//==================== ON DESTROY oEnemy
/// @description Announce that this enemy has been killed.

event_bus_post(MISSION_EVENT.ENEMY_KILLED, {
    enemy_instance_id: id,          // The specific instance that was destroyed
    enemy_object_index: object_index  // The type of object (e.g., obj_Goblin)
});

///////////////////////////////////////
////
////		oCollectible
////
///////////////////////////////////////

//==================== ON COLLISION oCollectible
/// @description Announce item collection and destroy self

// This ID should match the target in your JSON file.
var item_type_id = "itm_AncestralSword";

event_bus_post(MISSION_EVENT.ITEM_COLLECTED, {
    item_id: item_type_id,
    item_instance_id: id
});

instance_destroy();

///////////////////////////////////////
////
////		oLocation
////
///////////////////////////////////////

//==================== ON COLLISION oLocation
/// @description Announce entering an area.

// Set this ID in the object's Creation Code or in the Room Editor.
// This must match the target in your JSON file.
var area_unique_id = "loc_GoblinCaveDepths"; 

event_bus_post(MISSION_EVENT.ENTER_AREA, {
    area_id: area_unique_id
});

// Optional: destroy this trigger so it only fires once.
// instance_destroy();
*/