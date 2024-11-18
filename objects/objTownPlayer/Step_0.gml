/// @description  MOVEMENT

// IF LEFT KEY PRESSED
if (keyboard_check( vk_left )) {

    // IF VERTICALLY ALIGNED
    if (y mod 32 == 0) {

        // IF TARGET SQUARE IS EMPTY
        if (place_free( x-4 , y )) {
        
            vspeed = 0;
            hspeed = -4;
        
        }

    }

}

// IF RIGHT KEY PRESSED
if (keyboard_check( vk_right )) {

    // IF VERTICALLY ALIGNED
    if (y mod 32 == 0) {

        // IF TARGET SQUARE IS EMPTY
        if (place_free( x+4 , y )) {
        
            vspeed = 0;
            hspeed = 4;
        
        }

    }

}

// IF UP KEY PRESSED
if (keyboard_check( vk_up )) {

    // IF HORIZONTALLY ALIGNED
    if (x mod 32 == 0) {

        // IF TARGET SQUARE IS EMPTY
        if (place_free( x , y-4 )) {
        
            hspeed = 0;
            vspeed = -4;
        
        }

    }

}

// IF DOWN KEY PRESSED
if (keyboard_check( vk_down )) {

    // IF HORIZONTALLY ALIGNED
    if (x mod 32 == 0) {

        // IF TARGET SQUARE IS EMPTY
        if (place_free( x , y+4 )) {
        
            hspeed = 0;
            vspeed = 4;
        
        }

    }

}

/// SET DEPTH

depth = -y;

