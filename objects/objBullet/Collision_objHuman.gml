// objBullet: Collision with objHuman (other)
/*if (!instance_exists(other)) exit;
if (!instance_exists(owner)) { instance_destroy(); exit; }

if (!variable_instance_exists(other,"threat_map") || is_undefined(other.threat_map) || !ds_exists(other.threat_map, ds_type_map)) {
    other.threat_map = ds_map_create();
}
var k = owner.id;
other.threat_map[? k] = (ds_map_exists(other.threat_map, k) ? other.threat_map[? k] : 0) + 10;

other.poi    = owner;
other.target = owner;

if (variable_instance_exists(other,"state")) other.state = "combat";
if (variable_instance_exists(other,"aggression")) other.aggression = clamp((is_undefined(other.aggression)?0:other.aggression)+10, 0, 100);

instance_destroy();
