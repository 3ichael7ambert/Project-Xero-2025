//draw
draw_sprite_ext(sprite_index,image_index,x,y,width/sprite_width,height/sprite_height,0,c_white,1);
var _new_w = 0;
for (var i=0; i<op_length; i++;)
{
	var _op_w = string_width(option[menu_level,i]);
	_new_w = max(_new_w, _op_w);
	
}

width=_new_w + op_border*2;
height = op_border*2 + sprite_get_height(spr_main_font) + (op_length-1)*op_space;
//center menu
x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2 - width/2;
y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])/2 - width/2;

//draw the options
//draw_set_font
draw_set_valign(fa_top);
draw_set_halign(fa_left);
for (var i=0; i<op_length; i++;)
{
	var _c = c_white;
	if pos == i { _c =c_yellow;}
	//draw_text(x+op_border,y+op_border+op_space*i, option[i]);
	draw_text_color(x+op_border,y+op_border+op_space*i, option[menu_level, i],_c,_c,_c,_c,1);
	
	
}

// Set default font
draw_set_font(fnt_monogram);

// Loop through the array containing each menu element
for(i = 0; i < array_length_1d(menu); i++)
{
	// If you're looking at the currently selected element, 
	// then draw it with a certain color, if not, then with
	// another color
	if(selected == i)
	{
		draw_set_color(selectedCol);
	}
	else
	{
		draw_set_color(notSelectedCol);
	}
	
	// Draw the text
	draw_text(x,y+i*spacing, menu[i]);	
}
// Getting width of cursor to separate it a bit from the menu
var cursWidth = sprite_get_width(s_cursor);

// Draw cursor at where it should be, but half its width 
// to the left of the menu
draw_sprite(s_cursor, -1, x + cursorLevitate - cursWidth/2, y + selectLerp*spacing);

// Draw game title (at 10% of screen width and height, hence 0.1)
draw_set_color(titleCol);
draw_text_transformed(room_width*0.1, room_height*0.1 , gameTitle, titleSize, titleSize,0);






//GPT
// Draw main menu
if (!showOptions) {
    draw_set_font(fnt_monogram);
    
    // Draw menu options
    for (var i = 0; i < menuOptions.length; i++) {
        var color = c_white;
        if (i == selectedOption) {
            color = c_yellow;
        }
        draw_text(x, y + i * 32, menuOptions[i]);
    }
}
// Draw options menu
else {
    draw_set_font(fnt_monogram);
    
    // Draw control options
    for (var i = 0; i < controlOptions.length; i++) {
        var color = c_white;
        if (i == selectedControlOption) {
            color = c_yellow;
        }
        draw_text(x, y + i * 32, controlOptions[i]);
    }
    
    // Draw back button
    draw_text(x, y + controlOptions.length * 32, "Back");
}
