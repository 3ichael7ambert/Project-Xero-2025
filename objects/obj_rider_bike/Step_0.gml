/// @description Insert description here
// You can write your code in this editor
//image_angle=obj_NeonBike_bike.phy_rotation;

//image_xscale=scale;
//image_yscale=scale;

phy_rotation=obj_NeonBike_bike.phy_rotation;

xx = phy_position_x;
yy = phy_position_y;

scale=.7;



if mouse_x>xx {facing_right=true;}
if mouse_x<xx {facing_right=false;}

if facing_right==true {
	if mouse_aim==false {
		armF_dir=0;
	}
}
if facing_right==false {
	if mouse_aim==false {
		armF_dir=180;
	}
}

if mouse_aim=true {
	armF_dir = point_direction(xx,yy,mouse_x,mouse_y);
}

if (keyboard_check_pressed(ord("Q"))) {
	if mouse_aim==true {mouse_aim=false;}
	else
	if mouse_aim==false {mouse_aim=true;}
}




// Keyboard/button shoot
if (mouse_check_button(mb_left)) {	
    var sx = armF_x + lengthdir_x(120 * scale, armF_dir);
    var sy = armF_y + lengthdir_y(120 * scale, armF_dir);

    // Create bullet on correct layer
    var a = instance_create(sx, sy, obj_bike_bullet);

    // Rotate bullet sprite/fixture
    a.phy_rotation = -armF_dir;
    a.parent = self;

    // How strong the shot is
    var force_strength = 1000;       // higher = faster
    var theta = armF_dir;            // fire in the arm's direction

    // Apply force in bullet's scope
    with (a) {
        var xvec = lengthdir_x(force_strength, theta);
        var yvec = lengthdir_y(force_strength, theta);
        physics_apply_force(x, y, xvec, yvec);
    }
}








