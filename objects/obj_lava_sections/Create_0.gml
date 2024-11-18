/// @description Insert description here
// You can write your code in this editor
target = obj_Player1;

init_section_type_lava(3);




for (var j = 0; j < 10; j++) {
	
currentSection = variable_instance_get(id,"sec"+string(j+1));
	
    for (var i = 0; i < array_length_1d(currentSection); i++) {
        var cell =  currentSection[i];

        if (cell == "e") {
            instance_create_layer(x + 64 * i, y - 64 * j, "InstancesWall", obj_block_lava_outer);
        } else if (cell == "x") {
            instance_create_layer(x + 64 * i, y - 64 * j, "InstancesWall", obj_block_lava_inner);
        }
    }
}














