/// @description Insert description here

// Initialize grid size variables
var gridWidth = 0;
var gridHeight = 0;

// Check to the left to determine grid width
while (!place_free(x - gridWidth * 64, y)) {
    gridWidth++;
}

// Check above to determine grid height
while (!place_free(x, y - gridHeight * 64)) {
    gridHeight++;
}

// Set the sprite index for all instances in the grid
for (var i = 0; i < gridWidth; i++) {
    for (var j = 0; j < gridHeight; j++) {
        var inst = instance_place(x - i * 64, y - j * 64, objBuilding);
        
		//inst.building=building;
		//inst.subimg=subimg;
    }
}
















