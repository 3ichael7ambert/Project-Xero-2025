/// @description  SET UP VARIABLES

event_inherited();

fenceMatrix = build_drawing_matrix(x,y-64,300,0,0,0);

swMatrix1 = build_drawing_matrix(x,y,300,90,0,0);
swMatrix2 = build_drawing_matrix(x,y,236,90,0,0);
swMatrix3 = build_drawing_matrix(x,y,172,90,0,0);
swMatrix4 = build_drawing_matrix(x,y,128,90,0,0);
swMatrix5 = build_drawing_matrix(x,y,64,90,0,0);
swMatrix6 = build_drawing_matrix(x,y,0,90,0,0);
swMatrix7 = build_drawing_matrix(x,y,-64,90,0,0);

swMatrixCurb = build_drawing_matrix(x,y,-128,0,0,0);
swMatrixStreet = build_drawing_matrix(x,y+8,-128,90,0,0);