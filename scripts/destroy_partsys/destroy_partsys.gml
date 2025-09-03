/// @description destroy_partsys();
function destroy_partsys() {
	/*
	Created by: Rayu Johnson
	This function removes the particle system from memory
	*/

	for (var i=0; i<array_length_1d(_partArray); i+=1)
	{
	    part_type_destroy(_partArray[i]);
	};

	part_system_destroy(_SYS_TOP);
	part_system_destroy(_SYS_BOT);



}
