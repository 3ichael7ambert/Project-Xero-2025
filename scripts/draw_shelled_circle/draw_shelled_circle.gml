function draw_shelled_circle(_x, _y, _radInner, _radOuter, _segments, _colLine, _colFill, _alphaLine=1, _alphaFill=1, _lineWidth=1){
	var _ds = 360 / _segments;
	for(var i = 0; i < _segments; i++){
		var _angle1 = _ds * i;
		var _angle2 = _ds * (i+1);
		///
		var _x1 = _x + lengthdir_x(_radInner, _angle2);
		var _y1 = _y + lengthdir_y(_radInner, _angle2);
		///
		var _x2 = _x + lengthdir_x(_radOuter, _angle2);
		var _y2 = _y + lengthdir_y(_radOuter, _angle2);
		///
		var _x3 = _x + lengthdir_x(_radOuter, _angle1);
		var _y3 = _y + lengthdir_y(_radOuter, _angle1);
		///
		var _x4 = _x + lengthdir_x(_radInner, _angle1);
		var _y4 = _y + lengthdir_y(_radInner, _angle1);
		
		/// DRAW INSIDE
		draw_set_alpha(_alphaFill);
		draw_triangle_color(_x1,_y1,_x2,_y2,_x3,_y3,_colFill,_colFill,_colFill,false);
		draw_triangle_color(_x1,_y1,_x3,_y3,_x4,_y4,_colFill,_colFill,_colFill,false);
		
		/// DRAW OUTLINE
		draw_set_alpha(_alphaLine);
		draw_line_width_color(_x1,_y1,_x4,_y4,_lineWidth,_colLine,_colLine);
		draw_line_width_color(_x2,_y2,_x3,_y3,_lineWidth,_colLine,_colLine);
		draw_set_alpha(1);
	}
}