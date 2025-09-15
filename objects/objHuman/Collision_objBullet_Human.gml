//attacking=true;
//poi="human";
// objHuman: Collision with objBullet
if (other.owner==id) exit;
if (other.species=species) exit;

attacking = true;
if (variable_instance_exists(self,"hp")) hp -= 1;

var shooter = noone;
if (instance_exists(other) && variable_instance_exists(other,"owner") && instance_exists(other.owner)) {
    shooter = other.owner;
}
if (shooter != noone) {
    if (!variable_instance_exists(self,"threat_map") || is_undefined(threat_map) || !ds_exists(threat_map, ds_type_map)) {
        threat_map = ds_map_create();
    }
    var k = shooter.id;
    threat_map[? k] = (ds_map_exists(threat_map, k) ? threat_map[? k] : 0) + 10;

    poi      = shooter;
    target   = shooter;
    provoked = true;                 // <-- key line
    alert_timer = room_speed * 5;    // stay hot for ~5s

    if (variable_instance_exists(self,"state")) state = "combat";
    if (variable_instance_exists(self,"aggression")) aggression = clamp((is_undefined(aggression)?0:aggression)+10, 0, 100);
    if (variable_instance_exists(self,"last_attacked_time")) last_attacked_time = current_time;
}
with (other) instance_destroy();
