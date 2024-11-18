/// @description  MOVE WITH THE MOUSE

x = mouse_x;
y= mouse_y;

// SET DEPTH BASED ON MOUSE POSITION

depth=-y;



/// CHECK FOR FPS HIT

if (hasdropped == 0) {

    if (fps < room_speed*0.9) {
    
        hasdropped = 1;
        mydrop = instance_number(objCube2);
    
    }

}

