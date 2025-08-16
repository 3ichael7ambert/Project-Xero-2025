/// @description  SET UP VARIABLES
randomize();
event_inherited();

//building=irandom_range(0,1);
building=0;
sprite=sprSidewalk;
//subimg=irandom_range(0,16);
subimg=0;

alarm[1]=10;
/*
// Set the sprite index for all instances in the grid
for (var i = 0; i < gridWidth; i++) {
    for (var j = 0; j < gridHeight; j++) {
        var inst = instance_place(x - i * 64, y + j * 64, objBuilding);
        
		building=inst.building;
		subimg=inst.subimg;
    }
}*/


					// Building matrices
roofMatrix = build_drawing_matrix(x, y, 128, 90, 0, 0);
roofMatrix2 = build_drawing_matrix(x, y, 192,90,0,0);
roofMatrix3 = build_drawing_matrix(x, y, 256,90,0,0);

frontMatrix = build_drawing_matrix(x, y, 64, 0, 0, 0);

rightMatrix1 = build_drawing_matrix(x, y, 64, 0, 45, 0);
rightMatrix2 = build_drawing_matrix(x + 64, y, 128, 0, 90, 0);
rightMatrix3 = build_drawing_matrix(x, y, 256, 0, -45, 0);

rightMatrix1b = build_drawing_matrix(x+64,y,64,0,90,0);
rightMatrix2b = build_drawing_matrix(x+64,y,128,0,90,0);
rightMatrix3b = build_drawing_matrix(x+64,y,192,0,90,0);


leftMatrix1 = build_drawing_matrix(x, y, 128, 0, -45, 0);
leftMatrix2 = build_drawing_matrix(x, y, 128, 0, 90, 0);
leftMatrix3 = build_drawing_matrix(x, y, 192, 0, 45, 0);

leftMatrix1b = build_drawing_matrix(x,y,64,0,90,0);
leftMatrix2b = build_drawing_matrix(x,y,128,0,90,0);
leftMatrix3b = build_drawing_matrix(x,y,192,0,90,0);