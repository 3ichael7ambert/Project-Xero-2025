// Initialize surface during game initialization







draw_set_font(fnt_menu);
//TEXT
for (var i = 0; i < array_number; i++) {
    var item_rot = 360 * i / array_number;
    var rotated_x = lengthdir_x(menu_width/2, rot - item_rot + 90);
    var rotated_y = lengthdir_y(menu_height/2, rot - item_rot + 90);

    draw_text_outlined(menu_x + rotated_x, menu_y+(menu_height/2) + rotated_y, menu_items[i],c_white,c_gray);
	//draw_text(menu_x, menu_y-200, string_width(menu_items[selected_item]));
}

//IMAGES
for (var i = 0; i < array_number; i++) {
    var item_rot = 360 * i / array_number;
    var rotated_x = lengthdir_x(menu2_width/2, rot - item_rot - 90);
    var rotated_y = lengthdir_y(menu2_height/2, rot - item_rot - 90);

	if i=0 { //CITY
		var body=(true);
		var bg=(true);
		var scale=1;
		if body==true {
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

			
			draw_sprite_ext(sprArmArms, 0, armB_x, armB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprFist, 0, handB_x, handB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legB_x, legB_y, scale, scale, 0, c_white, 1);
			draw_sprite_ext(sprJetBack, 0, jetpack_x ,jetpack_y,scale, scale, -15+body_angle, c_white, 1 );
			draw_sprite_ext(sprBody, 0, body_x, body_y, scale, scale, body_angle, c_white, 1);
			draw_sprite_ext(sprHead_old, 0, head_x, head_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprEyes, 0, eyes_x, eyes_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legF_x ,legF_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprArmArms, 0, armF_x ,armF_y, scale, scale, armF_dir, c_white, 1);
			draw_sprite_ext(sprFist, 0, handF_x, handF_y, scale, scale, armF_dir, c_white, 1);
		}
	}
	if i=1 { //ASTEROID Belt
var body=(true);
		var bg=(true);
		var scale=1;
		if body==true {
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

			
			draw_sprite_ext(sprArmArms, 0, armB_x, armB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprFist, 0, handB_x, handB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legB_x, legB_y, scale, scale, 0, c_white, 1);
			draw_sprite_ext(sprJetBack, 0, jetpack_x ,jetpack_y,scale, scale, -15+body_angle, c_white, 1 );
			draw_sprite_ext(sprBody, 0, body_x, body_y, scale, scale, body_angle, c_white, 1);
			draw_sprite_ext(sprHead_old, 0, head_x, head_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprEyes, 0, eyes_x, eyes_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legF_x ,legF_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprArmArms, 0, armF_x ,armF_y, scale, scale, armF_dir, c_white, 1);
			draw_sprite_ext(sprFist, 0, handF_x, handF_y, scale, scale, armF_dir, c_white, 1);
		}		
	}
	if i=2 { //SURVIVAL
		var body=(true);
		var bg=(true);
		var scale=1;
		if body==true {
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

			
			draw_sprite_ext(sprArmArms, 0, armB_x, armB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprFist, 0, handB_x, handB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legB_x, legB_y, scale, scale, 0, c_white, 1);
			draw_sprite_ext(sprJetBack, 0, jetpack_x ,jetpack_y,scale, scale, -15+body_angle, c_white, 1 );
			draw_sprite_ext(sprBody, 0, body_x, body_y, scale, scale, body_angle, c_white, 1);
			draw_sprite_ext(sprHead_old, 0, head_x, head_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprEyes, 0, eyes_x, eyes_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legF_x ,legF_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprArmArms, 0, armF_x ,armF_y, scale, scale, armF_dir, c_white, 1);
			draw_sprite_ext(sprFist, 0, handF_x, handF_y, scale, scale, armF_dir, c_white, 1);
		}
	}
	if i=3 { //INVASTION
		var body=(true);
		var bg=(true);
		var scale=1;
		if body==true {
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

			
			draw_sprite_ext(sprArmArms, 0, armB_x, armB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprFist, 0, handB_x, handB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legB_x, legB_y, scale, scale, 0, c_white, 1);
			draw_sprite_ext(sprJetBack, 0, jetpack_x ,jetpack_y,scale, scale, -15+body_angle, c_white, 1 );
			draw_sprite_ext(sprBody, 0, body_x, body_y, scale, scale, body_angle, c_white, 1);
			draw_sprite_ext(sprHead_old, 0, head_x, head_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprEyes, 0, eyes_x, eyes_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legF_x ,legF_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprArmArms, 0, armF_x ,armF_y, scale, scale, armF_dir, c_white, 1);
			draw_sprite_ext(sprFist, 0, handF_x, handF_y, scale, scale, armF_dir, c_white, 1);
		}
	}
	if i=4 { //ZERO GRAVITY
		var body=(true);
		var bg=(true);
		var scale=1;
		if body==true {
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

			
			draw_sprite_ext(sprArmArms, 0, armB_x, armB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprFist, 0, handB_x, handB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legB_x, legB_y, scale, scale, 0, c_white, 1);
			draw_sprite_ext(sprJetBack, 0, jetpack_x ,jetpack_y,scale, scale, -15+body_angle, c_white, 1 );
			draw_sprite_ext(sprBody, 0, body_x, body_y, scale, scale, body_angle, c_white, 1);
			draw_sprite_ext(sprHead_old, 0, head_x, head_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprEyes, 0, eyes_x, eyes_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legF_x ,legF_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprArmArms, 0, armF_x ,armF_y, scale, scale, armF_dir, c_white, 1);
			draw_sprite_ext(sprFist, 0, handF_x, handF_y, scale, scale, armF_dir, c_white, 1);
		}
	}
	if i=5 { //STREETBIKE
		var body=(true);
		var bg=(true);
		var scale=1;
		if body==true {
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

			
			draw_sprite_ext(sprArmArms, 0, armB_x, armB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprFist, 0, handB_x, handB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legB_x, legB_y, scale, scale, 0, c_white, 1);
			draw_sprite_ext(sprJetBack, 0, jetpack_x ,jetpack_y,scale, scale, -15+body_angle, c_white, 1 );
			draw_sprite_ext(sprBody, 0, body_x, body_y, scale, scale, body_angle, c_white, 1);
			draw_sprite_ext(sprHead_old, 0, head_x, head_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprEyes, 0, eyes_x, eyes_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legF_x ,legF_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprArmArms, 0, armF_x ,armF_y, scale, scale, armF_dir, c_white, 1);
			draw_sprite_ext(sprFist, 0, handF_x, handF_y, scale, scale, armF_dir, c_white, 1);
		}
	}
	if i=6 { //BEACH
		var body=(true);
		var bg=(true);
		var scale=1;
		if body==true {
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

			
			draw_sprite_ext(sprArmArms, 0, armB_x, armB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprFist, 0, handB_x, handB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legB_x, legB_y, scale, scale, 0, c_white, 1);
			draw_sprite_ext(sprJetBack, 0, jetpack_x ,jetpack_y,scale, scale, -15+body_angle, c_white, 1 );
			draw_sprite_ext(sprBody, 0, body_x, body_y, scale, scale, body_angle, c_white, 1);
			draw_sprite_ext(sprHead_old, 0, head_x, head_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprEyes, 0, eyes_x, eyes_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legF_x ,legF_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprArmArms, 0, armF_x ,armF_y, scale, scale, armF_dir, c_white, 1);
			draw_sprite_ext(sprFist, 0, handF_x, handF_y, scale, scale, armF_dir, c_white, 1);
		}
	}
	if i=7 { //FOREST
		var body=(true);
		var bg=(true);
		var scale=1;
		if body==true {
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

			
			draw_sprite_ext(sprArmArms, 0, armB_x, armB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprFist, 0, handB_x, handB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legB_x, legB_y, scale, scale, 0, c_white, 1);
			draw_sprite_ext(sprJetBack, 0, jetpack_x ,jetpack_y,scale, scale, -15+body_angle, c_white, 1 );
			draw_sprite_ext(sprBody, 0, body_x, body_y, scale, scale, body_angle, c_white, 1);
			draw_sprite_ext(sprHead_old, 0, head_x, head_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprEyes, 0, eyes_x, eyes_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legF_x ,legF_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprArmArms, 0, armF_x ,armF_y, scale, scale, armF_dir, c_white, 1);
			draw_sprite_ext(sprFist, 0, handF_x, handF_y, scale, scale, armF_dir, c_white, 1);
		}
	}
	if i=8 { //BOSS
		var body=(true);
		var bg=(true);
		var scale=1;
		if body==true {
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

			
			draw_sprite_ext(sprArmArms, 0, armB_x, armB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprFist, 0, handB_x, handB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legB_x, legB_y, scale, scale, 0, c_white, 1);
			draw_sprite_ext(sprJetBack, 0, jetpack_x ,jetpack_y,scale, scale, -15+body_angle, c_white, 1 );
			draw_sprite_ext(sprBody, 0, body_x, body_y, scale, scale, body_angle, c_white, 1);
			draw_sprite_ext(sprHead_old, 0, head_x, head_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprEyes, 0, eyes_x, eyes_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legF_x ,legF_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprArmArms, 0, armF_x ,armF_y, scale, scale, armF_dir, c_white, 1);
			draw_sprite_ext(sprFist, 0, handF_x, handF_y, scale, scale, armF_dir, c_white, 1);
		}
	}
	if i=9 { //OPTIONS
		var body=(true);
		var bg=(true);
		var scale=1;
		if body==true {
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

			
			draw_sprite_ext(sprArmArms, 0, armB_x, armB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprFist, 0, handB_x, handB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legB_x, legB_y, scale, scale, 0, c_white, 1);
			draw_sprite_ext(sprJetBack, 0, jetpack_x ,jetpack_y,scale, scale, -15+body_angle, c_white, 1 );
			draw_sprite_ext(sprBody, 0, body_x, body_y, scale, scale, body_angle, c_white, 1);
			draw_sprite_ext(sprHead_old, 0, head_x, head_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprEyes, 0, eyes_x, eyes_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legF_x ,legF_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprArmArms, 0, armF_x ,armF_y, scale, scale, armF_dir, c_white, 1);
			draw_sprite_ext(sprFist, 0, handF_x, handF_y, scale, scale, armF_dir, c_white, 1);
		}
	}
	if i=10 { //EXIT
		var body=(true);
		var bg=(true);
		var scale=1;
		if body==true {
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

			
			draw_sprite_ext(sprArmArms, 0, armB_x, armB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprFist, 0, handB_x, handB_y, scale, scale, armB_dir, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legB_x, legB_y, scale, scale, 0, c_white, 1);
			draw_sprite_ext(sprJetBack, 0, jetpack_x ,jetpack_y,scale, scale, -15+body_angle, c_white, 1 );
			draw_sprite_ext(sprBody, 0, body_x, body_y, scale, scale, body_angle, c_white, 1);
			draw_sprite_ext(sprHead_old, 0, head_x, head_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprEyes, 0, eyes_x, eyes_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprLeg3, 0, legF_x ,legF_y, scale, scale, 0, c_white, 1 );
			draw_sprite_ext(sprArmArms, 0, armF_x ,armF_y, scale, scale, armF_dir, c_white, 1);
			draw_sprite_ext(sprFist, 0, handF_x, handF_y, scale, scale, armF_dir, c_white, 1);
		}
	}
	
	
	
}


if !surface_exists(surf_menu_bg) {
    //surf_menu_bg = surface_create(display_get_width(), display_get_height());
	surf_menu_bg = surface_create(room_width,room_height);
}

// Set target to surf_menu_bg
surface_set_target(surf_menu_bg);
//draw_sprite(sprMenuScreen, 3, x, y);

// Clear the surface to a specific color
draw_clear_alpha(c_black, 1);

// Draw your background elements
draw_set_color(make_color_rgb(150, 242, 252));
draw_rectangle(0, 0, room_width, room_height, 0);
draw_set_color(c_white);
draw_background_tiled_ext(sprXeroBG, 0, x, y, 0.25, 0.25, c_white, 1);
//draw_sprite(sprMenuScreen, 2, x, y);

// Reset target
//surface_reset_target();




/// clear hole for planet / moon
gpu_set_blendmode(bm_subtract);
draw_sprite(sprMenuScreen, 3, x, y);
gpu_set_blendmode(bm_normal);
surface_reset_target();


// Draw the surface
draw_surface(surf_menu_bg, 0,0 );

// Reset blend mode
gpu_set_blendmode(bm_normal);

// Draw additional elements
//draw_sprite(sprMenuScreen, 0, x, y);


//draw_sprite(sprMenuScreen, 2, x, y);
draw_sprite_ext(sprMenuScreen, 1, x, y,1,1,0,1,.25);
