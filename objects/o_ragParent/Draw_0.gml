//Draw debug outline for each ragdoll segment.
if !inited exit;


if global.debugMode {
	#region Draw basic shapes
	var ft = parent.foot_turn;
	if ft>0 && (id = ft || id = ft.lLeg || id = ft.foot) draw_set_color(c_yellow);
	physics_draw_debug();
	//var _f = phy_debug_render_coms | phy_debug_render_joints;
	//physics_world_draw_debug(_f);
	#endregion
} else {
	surface_set_target(global.surf_outline);
	if sprite_index != noone {
		var ax = lengthdir_x(sprite_xoffset-sprite_width/2, -phy_rotation);
		var ay = lengthdir_y(sprite_yoffset-sprite_height/2, -phy_rotation);
		draw_sprite_ext(sprite_index, image_index, phy_position_x - ax, phy_position_y - ay, image_xscale, image_yscale, -phy_rotation, image_blend, image_alpha);
	} else {
		#region draw colored shapes
		var _w=0, _h=0;
		switch (tag) {
		    case segTag.head:
		        draw_circle_color(phy_position_x,phy_position_y,parent.len_head,col,col,0);
		    break;
		    case segTag.chest:
				_w = parent.len_chest_w;
				_h = parent.len_chest_h;
		    break;
		    case segTag.hip:
				_w = parent.len_hip_w;
				_h = parent.len_hip_h;
		    break;
		    case segTag.legF_a:
		    case segTag.legF_b:
		    case segTag.legB_a:
		    case segTag.legB_b:
				_w = parent.len_leg_w;
				_h = parent.len_leg_h;
		    break;
		    case segTag.armF_a:
		    case segTag.armF_b:
		    case segTag.armB_a:
		    case segTag.armB_b:
				_w = parent.len_arm_w;
				_h = parent.len_arm_h;
		    break;
		    case segTag.footF:
		    case segTag.footB:
				_w = parent.len_foot_w;
				_h = parent.len_foot_h;
		    break;

		};

		draw_primitive_begin(pr_trianglestrip);
		var ulA = point_direction(-_w, _h,0,0);
		var xl = sqrt(sqr(_w*2) + sqr(_h*2))/2;
		var pr = -phy_rotation,ax,ay;
		ax = lengthdir_x(xl, pr+ulA);
		ay = lengthdir_y(xl, pr+ulA);
		draw_vertex_color(phy_position_x+ax, phy_position_y+ay,col,1);
		ax = lengthdir_x(xl, pr-ulA);
		ay = lengthdir_y(xl, pr-ulA);
		draw_vertex_color(phy_position_x+ax, phy_position_y+ay,col,1);
		ax = lengthdir_x(xl, pr-ulA+180);
		ay = lengthdir_y(xl, pr-ulA+180);
		draw_vertex_color(phy_position_x+ax, phy_position_y+ay,col,1);
		ax = lengthdir_x(xl, pr+ulA+180);
		ay = lengthdir_y(xl, pr+ulA+180);
		draw_vertex_color(phy_position_x+ax, phy_position_y+ay,col,1);
		draw_primitive_end();
		#endregion
	};
	
	surface_reset_target();
};

draw_set_color(c_white);
