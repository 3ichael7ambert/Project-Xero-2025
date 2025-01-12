_speed = point_distance(x,y,target.x,target.y+viewy)/20
move_towards_point(target.x,target.y+viewy,_speed)

if keyboard_check(vk_up)
&& keyboard_check(vk_down) {
    //nothing
}
else if keyboard_check(vk_up) {
    if viewy > -viewy_max {
        viewy -= 5
    }
}
else if keyboard_check(vk_down) {
    if viewy < viewy_max {
        viewy += 5
    }
}
else {
    //reset view
    viewy = 0
    /*if viewy != 0 {
        viewy /= 5
        
    }*/
}

/* */
/*  */
if (dirr > -target.image_angle) {dirr--;} else 
if (dirr > -target.image_angle) {dirr++;}
camera_set_view_angle(view_camera[0], dirr);