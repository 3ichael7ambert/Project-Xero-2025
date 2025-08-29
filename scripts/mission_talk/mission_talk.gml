function mission_talk() {

    if (talk_button) && (distance_to_object(nearest_human) < (100 * scale)) {

        with (nearest_human) if (has_mission) {

            mission_active = true;

            with (oMissionManager) {

                // Ensure mission defs exist and preserve original array order
                if (!variable_global_exists("MISSIONS")) create_missions();

                var WINDOW = 5;
                var len    = array_length(global.MISSIONS);
                var mission_selected = undefined;

                // Scan 0..4, then 5..9, 10..14, ... until we find a pool
                for (var start = 0; start < len && is_undefined(mission_selected); start += WINDOW) {

                    var end  = min(start + WINDOW - 1, len - 1);
                    var pool = [];

                    for (var i = start; i <= end; i++) {
                        var _id = global.MISSIONS[i].id;
                        if (get_mission_status(_id) == MISSION_STATUS.NotStarted) {
                            array_push(pool, _id);
                        }
                    }

                    if (array_length(pool) > 0) {
                        mission_selected = pool[ irandom(array_length(pool) - 1) ];
                    }
                }

                if (!is_undefined(mission_selected)) {

                    // Pre-spawn for birds so dynamic_count can read them
                    if (mission_selected == "SQ_001_Kill_Ten_Birds") {
                        for (var j = 0; j < 10; j++) {
                            instance_create(
                                random(room_width),
                                random(room_height - 500),
                                objMissionTarget
                            );
                        }
                    }

                    activate_mission(mission_selected);

                    // Optional: stop this NPC from offering again
                    other.has_mission = false;

                } else {
                    show_debug_message("No eligible NotStarted missions remain.");
                }
            }
        }
    }
}
