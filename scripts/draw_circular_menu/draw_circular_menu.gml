/// @function draw_circular_menu(menu, x, y)
/// @description Draws menu options in a rotating circle.
/// @param {Struct.Menu} menu The menu instance to draw.
/// @param {Real} x The center x-coordinate.
/// @param {Real} y The center y-coordinate.
function draw_circular_menu(_menu, _x, _y) {
    var _option_count = array_length(_menu.options);
    if (_option_count == 0) return;

if (_menu.title != "") {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);
		//TITLE
		var col1 = c_white;
		var col2 = c_black;
        draw_text_outlined(room_width/2, room_height/2 /*_y - _menu.radius - 40*/, _menu.title,col1,col2); // Draw title above the menu
    }
	

    // --- Smoothly rotate the menu ---
    // We use angle_difference to handle wrapping from 360 to 0 degrees smoothly
    var _angle_diff = angle_difference(_menu.target_angle, _menu.current_angle);
    _menu.current_angle += _angle_diff * _menu.rotation_speed;

    // --- Draw the decorative circle (using your function) ---
    // You can make these values dynamic based on the menu's properties
   // draw_shelled_circle(_x, _y, _menu.radius - 90, _menu.radius + 90, 64, c_blue, c_aqua, 1, 0.25, 2);

    // --- Draw the menu options ---
    draw_set_font(fnt_menu);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    var _angle_step = 360 / _option_count;

    for (var i = 0; i < _option_count; i++) {
        var _option = _menu.options[i];
        
        // Calculate the angle for this specific option
        // We use -90 to make angle 0 at the top of the circle
        var _item_angle = 90 + _menu.current_angle + (i * _angle_step);
       // var _item_angle = 0;
        // Get the position on the circle
        var _item_x = _x + lengthdir_x(_menu.radius, _item_angle);
        var _item_y = _y + lengthdir_y(_menu.radius, _item_angle);

        var _color = c_white;
        var _scale = 1;
        
        // Highlight the selected option
        if (i == _menu.selection_index) {
            _color = c_yellow;
            _scale = 1.5; // Make selected text bigger
        }
        
        // The text's own angle should be aligned to the circle's normal
        //var _text_angle = _item_angle;
		var _text_angle = 0;
       draw_text_transformed_outlined(_item_x,_item_y,_option.name,_color,c_black,_scale,_scale,0);
		//draw_text_transformed_color(_item_x, _item_y, _option.name, _scale, _scale, _text_angle, _color, _color, _color, _color, 1);
	
	}
	
	for (var i = 0; i < _option_count; i++) {
        var _option = _menu.options[i];
        
        // Calculate the angle for this specific option
        // We use -90 to make angle 0 at the top of the circle
        var _item_angle = -90 + _menu.current_angle + (i * _angle_step);
       // var _item_angle = 0;
        // Get the position on the circle
        var _item_x = _x + lengthdir_x(_menu.radius, _item_angle);
        var _item_y = _y + lengthdir_y(_menu.radius, _item_angle);

        var _color = c_white;
        var _scale = 1;
		 
		// Initialize _alpha if not present
		if (!variable_struct_exists(_menu, "_alpha")) {
		    _menu._alpha = 1; // Start from invisible for smoother fade-in
		}

		// Smoothly fade alpha toward 1 if selected, or toward 0 otherwise
		if (i == _menu.selection_index) {
		    _alpha = lerp(_alpha, 1, 0.1); // Fade in
		    _color = c_yellow;
		    _scale = 1.5;
		} else {
		    _alpha = lerp(_alpha, 0, 0.1); // Fade out
		    _scale = 1;
		}

		// Use the updated alpha value

        
		
        // The text's own angle should be aligned to the circle's normal
        //var _text_angle = _item_angle;
		var _text_angle = 0;
       // draw_text_transformed_outlined(_item_x,_item_y,_option.name,_color,c_black,_scale,_scale,0);
		//draw_text_transformed_color(_item_x, _item_y, _option.name, _scale, _scale, _text_angle, _color, _color, _color, _color, 1);
		
		var _item_angle_img = -90 + _menu.current_angle + (i * _angle_step);
		var _item_x_img = _x + lengthdir_x(_menu.radius, _item_angle_img);
        var _item_y_img = -480 + lengthdir_y(_menu.radius, _item_angle_img);
		
		show_debug_message("DEBUG" + string(_menu));

	if (_option.name=="Cityscape") {
		draw_menu_robot_char(sprHead,c_white,_item_x_img,_item_y_img,0,0,600,1,_item_angle+90,_item_angle_img,_item_angle_img,_alpha);
	}
	if (_option.name=="Asteroid Belt") {
		draw_menu_robot_char(sprHead,c_white,_item_x_img,_item_y_img,0,0,600,1,_item_angle+90,_item_angle_img,_item_angle_img,_alpha);
	}
	if (_option.name=="Survival") {
		draw_menu_robot_char(sprHead,c_white,_item_x_img,_item_y_img,0,0,600,1,_item_angle+90,_item_angle_img,_item_angle_img,_alpha);
	}
	if (_option.name=="Invasion") {
		draw_menu_robot_char(sprHead,c_white,_item_x_img,_item_y_img,0,0,600,1,_item_angle+90,_item_angle_img,_item_angle_img,_alpha);
	}
	if (_option.name=="Zero Gravity") {
		draw_menu_robot_char(sprHead,c_white,_item_x_img,_item_y_img,0,0,600,1,_item_angle+90,_item_angle_img,_item_angle_img,_alpha);
	}
	if (_option.name=="Streetbike Fury") {
		draw_menu_robot_char(sprHead,c_white,_item_x_img,_item_y_img,0,0,600,1,_item_angle+90,_item_angle_img,_item_angle_img,_alpha);
	}
	if (_option.name=="Boss") {
		draw_menu_robot_char(sprHead,c_white,_item_x_img,_item_y_img,0,0,600,1,_item_angle+90,_item_angle_img,_item_angle_img,_alpha);
	}
	if (_option.name=="Lava Run") {
		draw_menu_robot_char(sprHead,c_white,_item_x_img,_item_y_img,0,0,600,1,_item_angle+90,_item_angle_img,_item_angle_img,_alpha);
	}
	if (_option.name=="Options") {
		draw_menu_robot_char(sprHead,c_white,_item_x_img,_item_y_img,0,0,600,1,_item_angle+90,_item_angle_img,_item_angle_img,_alpha);
	}
	if (_option.name=="Exit") {
		draw_menu_robot_char(sprHead,c_white,_item_x_img,_item_y_img,0,0,600,1,_item_angle+90,_item_angle_img,_item_angle_img,_alpha);
	}
	
	}
	
	
};


/*


function draw_circular_img_menu(_menu, _x, _y) {
    var _option_count = array_length(_menu.options);
    if (_option_count == 0) return;

    // --- Smoothly rotate the menu ---
    // We use angle_difference to handle wrapping from 360 to 0 degrees smoothly
    var _angle_diff = angle_difference(_menu.target_angle, _menu.current_angle);
    _menu.current_angle += _angle_diff * _menu.rotation_speed;

    // --- Draw the decorative circle (using your function) ---
    // You can make these values dynamic based on the menu's properties
   // draw_shelled_circle(_x, _y, _menu.radius - 90, _menu.radius + 90, 64, c_blue, c_aqua, 1, 0.25, 2);

    // --- Draw the menu options ---
    draw_set_font(fnt_menu);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    var _angle_step = 360 / _option_count;

    for (var i = 0; i < _option_count; i++) {
        var _option = _menu.options[i];
        
        // Calculate the angle for this specific option
        // We use -90 to make angle 0 at the top of the circle
        var _item_angle = -90 + _menu.current_angle + (i * _angle_step);
       // var _item_angle = 0;
        // Get the position on the circle
        var _item_x = _x + lengthdir_x(_menu.radius, _item_angle);
        var _item_y = _y + lengthdir_y(_menu.radius, _item_angle);

        var _color = c_white;
        var _scale = 1;
        
        // Highlight the selected option
        if (i == _menu.selection_index) {
            _color = c_yellow;
            _scale = 1.5; // Make selected text bigger
        }
        
        // The text's own angle should be aligned to the circle's normal
        //var _text_angle = _item_angle;
		var _text_angle = 0;
        draw_text_transformed_outlined(_item_x,_item_y,_option.name,_color,c_black,_scale,_scale,0);
		//draw_text_transformed_color(_item_x, _item_y, _option.name, _scale, _scale, _text_angle, _color, _color, _color, _color, 1);
	
	}
};
*/

function draw_menu_robot_char(s_head,_col,_x,_y,rot_x,rot_y,menu_height,_scale,body_angle,armB_dir,armF_dir,_alpha) {
			
			menu2_x = _x;
			menu2_y = _y;
			rotated_x = rot_x;
			rotated_y = rot_y;
			scale = _scale;
			//armB_dir = arm_dir;
			
			
			var body_x = menu2_x + rotated_x;
			var body_y = menu2_y+(menu_height/2) + rotated_y;
			
			var armB_x = body_x + lengthdir_x(50*scale,50+body_angle);
			var armB_y = body_y + lengthdir_y(50*scale,50+body_angle);
			var handB_x = armB_x + lengthdir_x(80*scale,-5+armB_dir);
			var handB_y = armB_y + lengthdir_y(80*scale,-5+armB_dir);
			
			var legB_x = body_x + lengthdir_x(60*scale,-85+body_angle);
			var legB_y = body_y + lengthdir_y(60*scale,-85+body_angle);
			
			var jetpack_x = body_x + lengthdir_x(50*scale,175+body_angle);
			var jetpack_y = body_y + lengthdir_y(50*scale,175+body_angle);
			
			var head_x = body_x + lengthdir_x(58*scale,82+body_angle);
			var head_y = body_y + lengthdir_y(58*scale,82+body_angle);
			var eyes_x = head_x + lengthdir_x(60*scale,55);
			var eyes_y = head_y + lengthdir_y(60*scale,55);
			
			var armF_x = body_x + lengthdir_x(48*scale,132+body_angle);
			var armF_y = body_y + lengthdir_y(48*scale,132+body_angle);
			var handF_x = armF_x + lengthdir_x(75*scale,-3+armF_dir);
			var handF_y = armF_y + lengthdir_y(75*scale,-3+armF_dir);
			
			var legF_x = body_x + lengthdir_x(62*scale,-110+body_angle);
			var legF_y = body_y + lengthdir_y(63*scale,-110+body_angle);

			
			draw_sprite_ext(sprArmArms, 0, armB_x, armB_y, scale, scale, armB_dir, c_white, _alpha );
			draw_sprite_ext(sprFist, 0, handB_x, handB_y, scale, scale, armB_dir, c_white, _alpha );
			draw_sprite_ext(sprLeg3, 0, legB_x, legB_y, scale, scale, 0, c_white, _alpha);
			draw_sprite_ext(sprJetBack, 0, jetpack_x ,jetpack_y,scale, scale, -15+body_angle, c_white, _alpha );
			draw_sprite_ext(sprBody, 0, body_x, body_y, scale, scale, body_angle, c_white, _alpha);
			draw_sprite_ext(sprHead_old, 0, head_x, head_y, scale, scale, 0, c_white, _alpha );
			draw_sprite_ext(sprEyes, 0, eyes_x, eyes_y, scale, scale, 0, c_white, _alpha );
			draw_sprite_ext(sprLeg3, 0, legF_x ,legF_y, scale, scale, 0, c_white, _alpha );
			draw_sprite_ext(sprArmArms, 0, armF_x ,armF_y, scale, scale, armF_dir, c_white, _alpha);
			draw_sprite_ext(sprFist, 0, handF_x, handF_y, scale, scale, armF_dir, c_white, _alpha);
}