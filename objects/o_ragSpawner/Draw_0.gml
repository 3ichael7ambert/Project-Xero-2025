if !_inited exit;

surface_set_target(global.surf_outline);
//if g_ragStatus = ragSt.dead || g_ragStatus = ragSt.falling exit;

//var cA = c_red, cB = c_blue;
//if foot_turn = ins_legF_a { cA = c_red; cB = c_blue } else { cB = c_red; cA = c_blue };
//draw_circle_color(g_legStep_sPos[0], g_legStep_sPos[1],5,cA,cA,0);
//draw_circle_color(g_legIdle_sPos[0], g_legIdle_sPos[1],5,cB,cB,0);

if global.debugMode {
	#region Draw status
	var str = "";
	switch (g_ragStatus) {
	    case ragSt.idle: str = "idle"; break;
	    case ragSt.falling: str = "falling"; break;
	    case ragSt.balancing: str = "balancing"; break;
	    case ragSt.downed: str = "downed"; break;
	    case ragSt.gettingup: str = "getting up"; break;
	    case ragSt.dead: str = "dead"; break; 
	    case ragSt.jumping: str = "jumping"; break; 
	};
	draw_set_halign(fa_center);
	draw_text(ins_head.phy_position_x,ins_head.phy_position_y-50,str);
	draw_set_halign(fa_left);
	#endregion
	//draw_circle(g_com[0],g_com[1],5,0);
	var _c = c_lime;
	draw_line_color(j_x_legb_a, j_y_legb_a, j_x_legb_a-g_bal, j_y_legb_a, _c, _c);
	draw_set_alpha(0.75);
	draw_line_color(g_com[0],g_com[1],g_com[0],g_com[1] + g_legs_maxSLength,c_black,c_black)
	draw_set_alpha(1);
	//Feet status ( Mid-air / Standing )
	draw_text(j_x_legf_b,j_y_legf_b,string(foot_st[segTag.footF]));
	draw_text(j_x_legb_b,j_y_legb_b,string(foot_st[segTag.footB]));
	//Facing direction
	draw_arrow(ins_head.phy_position_x, ins_head.phy_position_y, ins_head.phy_position_x+30*g_facing, ins_head.phy_position_y, 12)
};


surface_reset_target();

