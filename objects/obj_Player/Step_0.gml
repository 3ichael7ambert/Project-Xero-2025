
depth = -y;

var left, right, up, down, leftright, updown;

left    = keyboard_check(ord("A"));
right   = keyboard_check(ord("D"));
up      = keyboard_check(ord("W"));
down    = keyboard_check(ord("S"));

leftright   = left || right;
updown      = up || down;

if leftright || updown{
    add++;
}

if (left){
    side = -1;
    x -= 4;
}else if (right){
    side = 1;
    x += 4;
}else{
    side = 0;
}

if (up){
    sprite_index = spr_player_back;
    y -= 4;
    up_side = -1;
}else if (down){
    sprite_index = spr_player_front;
    y += 4;
    up_side = 1;
}else{
    up_side = 0;
}



