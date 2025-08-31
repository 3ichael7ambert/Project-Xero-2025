

if species=="bird" {
	draw_self();
}

if (species=="balloon") {
	var bx = x;
	var by = y_anchor + sin(t * bob_freq) * bob_amp;  // visual-only bob

	// Base size
	var baseW = sprite_get_width(spr_balloon)  * scale;
	var baseH = sprite_get_height(spr_balloon) * scale;

	// Segment split (top bulge + tapered bottom)
	var h_top    = baseH * 0.62;
	var h_bottom = baseH - h_top;

	// Widths: top slightly wide, bottom tapered
	var w_top    = baseW * 0.95;
	var w_mid    = baseW * 1.08;   // bulge
	var w_bottom = baseW * 0.35;   // pointy end

	// (0) Colors
	draw_set_colour(tint_col);
	draw_set_alpha(alpha_col);

	// (1) TOP QUAD (trapezoid: narrower at top, widest at mid)
	{
	    var x1 = bx - w_top*0.5,    y1 = by - baseH*0.5-h_top;        // top-left
	    var x2 = bx + w_top*0.5,    y2 = by - baseH*0.5-h_top;        // top-right
	    var x3 = bx + w_mid*0.5,    y3 = by - baseH*0.5 + h_top;// mid-right
	    var x4 = bx - w_mid*0.5,    y4 = by - baseH*0.5 + h_top;// mid-left

	    draw_sprite_pos(spr_balloon, 0, x1,y1, x2,y2, x3,y3, x4,y4,alpha_col);
	}

	// (2) BOTTOM QUAD (trapezoid: widest at mid, tapered to bottom)
	{
	    var x1 = bx - w_mid*0.5,     y1 = by - baseH*0.5 - h_top/4;   // mid-left
	    var x2 = bx + w_mid*0.5,     y2 = by - baseH*0.5 - h_top/4;   // mid-right
	    var x3 = bx + w_bottom*0.5,  y3 = by + baseH*0.5;           // bottom-right
	    var x4 = bx - w_bottom*0.5,  y4 = by + baseH*0.5;           // bottom-left

	    draw_sprite_pos(spr_balloon, 0, x1,y1, x2,y2, x3,y3, x4,y4,alpha_col);
	}

	// (3) Little “knot” so the bottom reads as down
	{
	    var kW = baseW * 0.10;
	    var kH = baseH * 0.06;
	    var kx = bx;
	    var ky = by + baseH*0.5;

	    draw_triangle_color(kx,ky+kH, kx-kW*0.5,ky, kx+kW*0.5,ky, tint_col,tint_col,tint_col, false);
	}

	// Optional soft highlight
	 draw_ellipse_color(bx - baseW*0.18, by - baseH*0.28, bx - baseW*0.02, by - baseH*0.12, c_white, c_white, false);

}


/// --- DEBUG --- ///

draw_text_outlined(x,y,"GUID: " + string(mission_guid),c_yellow,c_red);