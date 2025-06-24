function draw_menu(this, _x, _y){
   
   draw_set_font(fnt_menu); // Make sure you have a font named 'fnt_menu'
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
        
    var _line_height = string_height("M");
        
    for (var i = 0; i < array_length(this.options); i++) {
        var _option = this.options[i];
        var _color = c_white;
        var _prefix = "  ";
            
        // Highlight the selected option
        if (i == this.selection_index) {
            _color = c_yellow;
            _prefix = "> ";
        }
            
        var _text = _prefix + _option.name;
        var _draw_y = _y + (i * (_line_height + 8));
            
		//draw_text_transformed_color(_x, _y, _text, xscale, yscale, angle,_color,_color,_color,_color,1);
		draw_text_outlined(_x,_y,_text,_color,c_black);
   }
};