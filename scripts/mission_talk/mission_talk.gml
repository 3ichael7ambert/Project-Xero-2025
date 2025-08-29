function mission_talk() {

    if (talk_button) && (distance_to_object(nearest_human) < (100 * scale)) {

        with (nearest_human) if (has_mission) {

            mission_active = true;

            with (oMissionManager) {

                if (!variable_global_exists("MISSIONS")) create_missions();

                var WINDOW = 5;
                var len = array_length(global.MISSIONS);
                var mission_selected = undefined;

                // expand by 5s until we find something NotStarted
                for (var start = 0; start < len && is_undefined(mission_selected); start += WINDOW) {
                    var end  = min(start + WINDOW - 1, len - 1);
                    var pool = [];
                    for (var i = start; i <= end; i++) {
                        var _id = global.MISSIONS[i].id;
                        if (get_mission_status(_id) == MISSION_STATUS.NotStarted) array_push(pool, _id);
                    }
                    if (array_length(pool) > 0) mission_selected = pool[ irandom(array_length(pool) - 1) ];
                }

                if (is_undefined(mission_selected)) {
                    show_debug_message("No eligible NotStarted missions remain.");
                    exit;
                }

                // --- Make a mission GUID (simple monotonic counter) ---
                if (!variable_global_exists("_mission_guid_seed")) global._mission_guid_seed = 0;
                global._mission_guid_seed += 1;
                var _guid = global._mission_guid_seed;

                // --- Pre-spawn for missions that need it and tag with GUID ---
                if (mission_selected == "SQ_001_Kill_Ten_Birds") {
                    for (var j = 0; j < 10; j++) {
                        var inst = instance_create(
                            random(room_width),
                            random(room_height - 500),
                            objMissionTarget
                        );
						inst.species="bird";
                        inst.mission_guid = _guid;   // <-- pass it to the spawned target
                    }
                }
				
				if (mission_selected == "SQ_002_99_Red_Balloons") {
                    for (var j = 0; j < 99; j++) {
                        var inst = instance_create(
                            random(room_width),
                            random(room_height - 500),
                            objMissionTarget
                        );
						inst.species="balloon";
                        inst.mission_guid = _guid;   // <-- pass it to the spawned target
                    }
                }

                // --- Activate and pass the same GUID so ObjectiveKill(scope=Mine) can match ---
                // Update your activate_mission to accept optional _pre_guid (see below)
                activate_mission(mission_selected, _guid);

                other.has_mission = false; // optional
            }
        }
    }
}
