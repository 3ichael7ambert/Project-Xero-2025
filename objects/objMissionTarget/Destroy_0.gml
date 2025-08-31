// objMissionTarget - on death/destroy
event_bus_post(MISSION_EVENT.ENEMY_KILLED, {
    enemy_object_index: object_index,
    enemy_instance_id: id,
    mission_guid: mission_guid,
    species: species
});