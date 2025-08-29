/// @description Enum for the status of a mission
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
function MissionObjective(_type, _target_id, _amount) constructor {
    type = _type;
    target_id = _target_id;
    amount = _amount;
    current = 0;
    is_completed = false;
    is_optional = false;

    static check_progress = function(_event_type, _event_data) {
        return false;
    }

    static get_display_string = function() {
        return $"Objective: {self.type} ({self.current}/{self.amount})";
    }
}

/// @function ObjectiveKill(_target_obj_index, _amount)
/// @description Objective to kill a certain number of a specific enemy type.
function ObjectiveKill(_target_obj_index, _amount) : MissionObjective("kill", _target_obj_index, _amount) constructor {
    static check_progress = function(_event_type, _event_data) {
        if (_event_type == MISSION_EVENT.ENEMY_KILLED && _event_data.enemy_object_index == self.target_id) {
            if (!self.is_completed) {
                self.current = min(self.current + 1, self.amount);
                if (self.current >= self.amount) {
                    self.is_completed = true;
                }
                show_debug_message($"Kill Objective Progress: {self.get_display_string()}");
                return true;
            }
        }
        return false;
    }

    static get_display_string = function() {
        var _target_name = object_get_name(self.target_id);
        return $"Kill {_target_name}s: {self.current}/{self.amount}";
    }
}

/// @function ObjectiveCollect(_target_item_id_string, _amount)
/// @description Objective to collect a certain number of a specific item.
function ObjectiveCollect(_target_item_id_string, _amount) : MissionObjective("collect", _target_item_id_string, _amount) constructor {
    static check_progress = function(_event_type, _event_data) {
        if (_event_type == MISSION_EVENT.ITEM_COLLECTED && _event_data.item_id == self.target_id) {
            if (!self.is_completed) {
                self.current = min(self.current + 1, self.amount);
                if (self.current >= self.amount) {
                    self.is_completed = true;
                }
                show_debug_message($"Collect Objective Progress: {self.get_display_string()}");
                return true;
            }
        }
        return false;
    }

    static get_display_string = function() {
        var _item_name = self.target_id; 
        return $"Collect {_item_name}: {self.current}/{self.amount}";
    }
}

/// @function ObjectiveLocation(_location_id_string)
/// @description Objective to reach a specific location.
function ObjectiveLocation(_location_id_string) : MissionObjective("location", _location_id_string, 1) constructor {
    static check_progress = function(_event_type, _event_data) {
        if (_event_type == MISSION_EVENT.ENTER_AREA && _event_data.area_id == self.target_id) {
            if (!self.is_completed) {
                self.current = 1;
                self.is_completed = true;
                show_debug_message($"Location Objective Progress: {self.get_display_string()}");
                return true;
            }
        }
        return false;
    }

    static get_display_string = function() {
        var _location_name = self.target_id;
        return self.is_completed ? $"Reached {_location_name}" : $"Go to {_location_name}";
    }
}

/// @function ObjectiveTalkToNPC(_npc_id_string)
/// @description Objective to talk to a specific NPC.
function ObjectiveTalkToNPC(_npc_id_string) : MissionObjective("talk", _npc_id_string, 1) constructor {
    static check_progress = function(_event_type, _event_data) {
        if (_event_type == MISSION_EVENT.DIALOGUE_FINISHED && _event_data.npc_id == self.target_id) {
            if (!self.is_completed) {
                self.current = 1;
                self.is_completed = true;
                show_debug_message($"Talk Objective Progress: {self.get_display_string()}");
                return true;
            }
        }
        return false;
    }

    static get_display_string = function() {
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
    time_limit = -1;
    current_time_elapsed = 0;
    on_mission_complete_script = undefined;
    on_mission_fail_script = undefined;

    static check_completion = function() {
        for (var i = 0; i < array_length(self.objectives); i++) {
            var _obj = self.objectives[i];
            if (!_obj.is_optional && !_obj.is_completed) {
                return false;
            }
        }
        return true;
    }

    static set_status = function(_new_status) {
        if (self.status == _new_status) return;
        show_debug_message($"Mission '{self.name}' status changed to: {string(_new_status)}");
        self.status = _new_status;

        var _manager = global.mission_manager;
        if (!instance_exists(_manager)) return;

        switch (_new_status) {
            case MISSION_STATUS.Active:
                self.current_time_elapsed = 0;
                break;
            case MISSION_STATUS.Completed:
                _manager.grant_rewards(self);
                if (is_callable(self.on_mission_complete_script)) {
                    self.on_mission_complete_script(self); // Pass mission data to callback
                }
                _manager.complete_active_mission(self.id);
                break;
            case MISSION_STATUS.Failed:
                if (is_callable(self.on_mission_fail_script)) {
                    self.on_mission_fail_script(self); // Pass mission data to callback
                }
                _manager.fail_active_mission(self.id);
                break;
        }
    }
}

/// @function global.event_bus_post(_event_type, _event_data)
/// @description Broadcasts a game event to all listening systems.
function event_bus_post(_event_type, _event_data) {
    if (variable_global_exists("mission_manager") && instance_exists(global.mission_manager)) {
        global.mission_manager.on_game_event(_event_type, _event_data);
    }
    show_debug_message($"Event Posted: {string(_event_type)} with data: {string(_event_data)}");
}

/// @description Initialize the Mission Manager Singleton and all its methods.
function mission_manager_setup() {
    if (variable_global_exists("mission_manager") && instance_exists(global.mission_manager) && global.mission_manager != self) {
        instance_destroy();
        exit;
    }
    global.mission_manager = self;

    available_missions = {};
	available_ids = [];  
    active_missions = [];
    completed_missions = [];
    failed_missions = [];

    self.init_missions = function() {
        self.available_missions = {};
        if (!variable_global_exists("MISSIONS")) {
            create_missions();
        }

        var _mission_data_array = global.MISSIONS;
        for (var i = 0; i < array_length(_mission_data_array); i++) {
            var _data = _mission_data_array[i];
            
            var _objectives = [];
            if (is_array(_data.objectives)) {
                for (var j = 0; j < array_length(_data.objectives); j++) {
                    var _obj_data = _data.objectives[j];
                    var _target = variable_struct_get(_obj_data, "target");
                    var _amount = variable_struct_get(_obj_data, "amount");

                    switch (_obj_data.type) {
                        case "kill":
                            var _obj_index = asset_get_index(_target);
                            if (_obj_index > -1) array_push(_objectives, new ObjectiveKill(_obj_index, _amount));
                            else show_debug_message($"WARNING: Unknown object '{_target}' for kill objective in mission '{_data.id}'");
                            break;
                        case "collect": array_push(_objectives, new ObjectiveCollect(_target, _amount)); break;
                        case "location": array_push(_objectives, new ObjectiveLocation(_target)); break;
                        case "talk": array_push(_objectives, new ObjectiveTalkToNPC(_target)); break;
                        default: show_debug_message($"WARNING: Unknown objective type '{_obj_data.type}' in mission '{_data.id}'"); break;
                    }
                }
            }
            
            var _mission = new Mission(
                _data.id, _data.name, _data.description, _objectives,
                variable_struct_get(_data, "rewards"),
                variable_struct_get(_data, "prerequisites")
            );

            if (variable_struct_exists(_data, "time_limit")) _mission.time_limit = _data.time_limit;
            
            // **NEW**: Check for and assign the completion callback
            if (variable_struct_exists(_data, "on_complete_callback")) {
                var _callback_name = _data.on_complete_callback;
                if (script_exists(asset_get_index(_callback_name))) {
                    _mission.on_mission_complete_script = method(undefined, asset_get_index(_callback_name));
                } else {
                     show_debug_message($"WARNING: Mission '{_data.id}' defines unknown callback function: '{_callback_name}'");
                }
            }

            self.available_missions[$ _mission.id] = _mission;
        }
        show_debug_message($"Successfully loaded {struct_names_count(self.available_missions)} missions from global array.");
    }

    self.get_mission_status = function(_mission_id) {
        if (array_contains(self.completed_missions, _mission_id)) return MISSION_STATUS.Completed;
        if (array_contains(self.failed_missions, _mission_id)) return MISSION_STATUS.Failed;
        for (var i = 0; i < array_length(self.active_missions); i++) {
            if (self.active_missions[i].id == _mission_id) return MISSION_STATUS.Active;
        }
        return MISSION_STATUS.NotStarted;
    }

    self.activate_mission = function(_mission_id) {
        if (!variable_struct_exists(self.available_missions, _mission_id)) {
            show_debug_message($"Attempted to activate non-existent mission: {_mission_id}");
            return false;
        }
        if (self.get_mission_status(_mission_id) != MISSION_STATUS.NotStarted) {
            show_debug_message($"Attempted to activate mission '{_mission_id}' which is not in 'NotStarted' state.");
            return false;
        }

        var _mission_def = self.available_missions[$ _mission_id];

        for (var i = 0; i < array_length(_mission_def.prerequisites); i++) {
            var _prereq_id = _mission_def.prerequisites[i];
            if (array_find_index(self.completed_missions, _prereq_id) == -1) {
                show_debug_message($"Cannot activate mission '{_mission_id}'. Prerequisite '{_prereq_id}' not met.");
                return false;
            }
        }

        var _new_objectives_array = [];
        for (var i = 0; i < array_length(_mission_def.objectives); i++) {
            var _obj_def = _mission_def.objectives[i];
            var _final_amount = _obj_def.amount;
            var _new_obj = undefined;
            
            if (_obj_def.amount == "dynamic_count" && _obj_def.type == "kill") {
                _final_amount = instance_number(_obj_def.target_id);
            }

            switch (_obj_def.type) {
                case "kill": _new_obj = new ObjectiveKill(_obj_def.target_id, _final_amount); break;
                case "collect": _new_obj = new ObjectiveCollect(_obj_def.target_id, _final_amount); break;
                case "location": _new_obj = new ObjectiveLocation(_obj_def.target_id); break;
                case "talk": _new_obj = new ObjectiveTalkToNPC(_obj_def.target_id); break;
            }
            
            if (_new_obj != undefined) {
                _new_obj.is_optional = _obj_def.is_optional;
                array_push(_new_objectives_array, _new_obj);
            }
        }
        
        var _new_active_mission = new Mission(
            _mission_def.id, _mission_def.name, _mission_def.description, 
            _new_objectives_array, _mission_def.rewards, _mission_def.prerequisites
        );
        _new_active_mission.time_limit = _mission_def.time_limit;
        _new_active_mission.on_mission_complete_script = _mission_def.on_mission_complete_script; // **NEW** Copy the callback

        _new_active_mission.set_status(MISSION_STATUS.Active);
        array_push(self.active_missions, _new_active_mission);
        show_debug_message($"Mission '{_mission_id}' activated!");
        return true;
    }

    self.on_game_event = function(_event_type, _event_data) {
        for (var i = array_length(self.active_missions) - 1; i >= 0; i--) {
            var _mission = self.active_missions[i];
            var _progress_made = false;
            for (var j = 0; j < array_length(_mission.objectives); j++) {
                if (_mission.objectives[j].check_progress(_event_type, _event_data)) {
                    _progress_made = true;
                }
            }
            if (_progress_made && _mission.check_completion()) {
                _mission.set_status(MISSION_STATUS.Completed);
            }
        }
    }

    self.grant_rewards = function(_mission) {
        show_debug_message($"Granting rewards for mission '{_mission.name}'");
        for (var i = 0; i < array_length(_mission.rewards); i++) {
            show_debug_message($"  - Reward: {string(_mission.rewards[i])}");
        }
    }

    self.complete_active_mission = function(_mission_id) {
        for (var i = array_length(self.active_missions) - 1; i >= 0; i--) {
            if (self.active_missions[i].id == _mission_id) {
                array_delete(self.active_missions, i, 1);
                break;
            }
        }
        array_push(self.completed_missions, _mission_id);
    }

    self.fail_active_mission = function(_mission_id) {
        for (var i = array_length(self.active_missions) - 1; i >= 0; i--) {
            if (self.active_missions[i].id == _mission_id) {
                array_delete(self.active_missions, i, 1);
                break;
            }
        }
        array_push(self.failed_missions, _mission_id);
    }

    self.save_game_missions = function() {
        var _save_data = {
            completed_mission_ids: self.completed_missions,
            failed_mission_ids: self.failed_missions,
            active_missions_save_data: []
        };
        for (var i = 0; i < array_length(self.active_missions); i++) {
            var _mission = self.active_missions[i];
            var _mission_save = {
                id: _mission.id, time_elapsed: _mission.current_time_elapsed,
                objectives_progress: array_map(_mission.objectives, function(obj) { return obj.current; })
            };
            array_push(_save_data.active_missions_save_data, _mission_save);
        }
        var _json = json_stringify(_save_data);
        ini_open("save_game.ini");
        ini_write_string("Progress", "Missions", _json);
        ini_close();
        show_debug_message("Mission progress saved.");
    }

    self.load_game_missions = function() {
        self.init_missions();
        ini_open("save_game.ini");
        var _json = ini_read_string("Progress", "Missions", "");
        ini_close();
        if (_json == "") {
            show_debug_message("No mission save data found to load.");
            return;
        }
        try {
            var _save_data = json_parse(_json);
            self.completed_missions = _save_data.completed_mission_ids;
            self.failed_missions = _save_data.failed_mission_ids;
            self.active_missions = [];
            
            for (var i = 0; i < array_length(_save_data.active_missions_save_data); i++) {
                 self.activate_mission(_save_data.active_missions_save_data[i].id);
                 // Additional logic to restore progress would go here
            }
        } catch(e) {
            show_debug_message("ERROR: Failed to parse mission save data.");
        }
    }
    
    self.mission_manager_update = function() {
        var _delta = delta_time / 1000000;
        for (var i = array_length(self.active_missions) - 1; i >= 0; i--) {
            var _mission = self.active_missions[i];
            if (_mission.time_limit > 0) {
                _mission.current_time_elapsed += _delta;
                if (_mission.current_time_elapsed >= _mission.time_limit) {
                    _mission.set_status(MISSION_STATUS.Failed);
                }
            }
        }
    }
    
    self.load_game_missions();
}


