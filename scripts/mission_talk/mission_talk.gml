function mission_talk() {

    if (talk_button) && (distance_to_object(nearest_human) < (100 * scale)) {

        with (nearest_human) if (has_mission) {

            mission_active = true;

            with (oMissionManager) {

                if (!variable_global_exists("MISSIONS")) create_missions();

                var WINDOW = 5;
                var len = array_length(global.MISSIONS);
                var mission_selected = undefined;

                // find a NotStarted mission (expanding windows of 5)
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

                // --- Make a mission GUID ---
                if (!variable_global_exists("_mission_guid_seed")) global._mission_guid_seed = 0;
                global._mission_guid_seed += 1;
                var _guid = global._mission_guid_seed;

                // --- IMPORTANT: define species local to this block ---
                var _species = ""; // default when a mission has no species tag

                // --- Pre-spawn & tag with GUID + species ---
                if (mission_selected == "SQ_001_Kill_Ten_Birds") {
                    _species = "bird";
                    for (var j = 0; j < 10; j++) {
                        var inst = instance_create(
                            random(room_width),
                            random(room_height - 500),
                            objMissionTarget
                        );
                        inst.species = _species;
                        inst.mission_guid = _guid;
                    }
                }
                else if (mission_selected == "SQ_002_99_Red_Balloons") {
                    _species = "balloon";
                    for (var k = 0; k < 99; k++) {
                        var inst2 = instance_create(
                            random(room_width),
                            random(room_height - 500),
                            objMissionTarget
                        );
                        inst2.species = _species;
                        inst2.mission_guid = _guid;
                    }
                }
                // else: leave _species = "" for missions that don't spawn/track a species

                // --- Activate with GUID + species so dynamic_count & kill filters work ---
                activate_mission(mission_selected, _guid, _species);

                // Optional: prevent re-offer from this NPC
                other.has_mission = false;
            }
        }
    }
}
