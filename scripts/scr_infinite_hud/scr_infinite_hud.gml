function scr_infinite_hud_init(){
	global.wave = 1;
	global.kill_count = 0;
	global.difficulty = 1;
	global.high_score = 0;

	global.aggression = 0;           // 0 to 100, or scale you choose
	///
	global.health = 100;             // 0 to 100
	global.burnout = 0;              // 0 to 100
	global.lives = 3;

	// HUD Settings
	global.max_health = 100;
	global.max_burnout = 100;
	gui_pad=32;
	spr_head=sprHead_old;
	
	//CITY
          // 0 to 100, or scale you choose
	global.coins = 0;
	global.credits = 0;
	///


	wave_timer = 90;
	enemies_remaining = 0; // this is key
	enemy_object=obj_Enemy_Robot;

	 enemy_spawned = true;
}

function scr_infinite_hud_draw(){
/// @description Kingdom Hearts-style circular health bar with spr_head in center (no ternary)


///
	var hp=50;
	var maxhp=100;
	if instance_exists(target) {
		spr_head=target.sprite_head;
		color1=target.color1;
	}
	///

	var scale_gui=.2;
	var cx = display_get_gui_width() * 0.5;
	var cy = display_get_gui_height() - 100;

	var radius = 64; // Radius of health arc
	var hp_ratio = clamp(hp / maxhp, 0, 1);


	var segments = 100;       // Smoothness of arc
	var angle_range = 270;    // Arc coverage
	var start_angle = -135;   // Arc begins left side, wraps clockwise







	// Decide color based on HP ratio
	var col;
	if (hp_ratio > 0.5) {
	    col = c_lime;
	} else if (hp_ratio > 0.25) {
	    col = c_yellow;
	} else {
	    col = c_red;
	}
	draw_set_color(col);

	// End angle based on hp
	var end_angle = start_angle + angle_range * hp_ratio;

	// Draw the health arc
	for (var i = 0; i < segments; i++) {
	    var a0 = start_angle + (angle_range / segments) * i;
	    var a1 = start_angle + (angle_range / segments) * (i + 1);

	    if (a1 > end_angle) {
	        break;
	    }

	    var x0 = cx + lengthdir_x(radius, a0);
	    var y0 = cy + lengthdir_y(radius, a0);
	    var x1 = cx + lengthdir_x(radius, a1);
	    var y1 = cy + lengthdir_y(radius, a1);

	    draw_triangle(cx, cy, x0, y0, x1, y1, false);
	}



	// Gradient ring settings
	var inner_radius = radius - 10;
	var outer_radius = radius + 10;
	var gradient_segments = 100;

	for (var i = 0; i < gradient_segments; i++) {
	    var a0 = start_angle + (angle_range / gradient_segments) * i;
	    var a1 = start_angle + (angle_range / gradient_segments) * (i + 1);

	    var x0_inner = cx + lengthdir_x(inner_radius, a0);
	    var y0_inner = cy + lengthdir_y(inner_radius, a0);
	    var x0_outer = cx + lengthdir_x(outer_radius, a0);
	    var y0_outer = cy + lengthdir_y(outer_radius, a0);

	    var x1_inner = cx + lengthdir_x(inner_radius, a1);
	    var y1_inner = cy + lengthdir_y(inner_radius, a1);
	    var x1_outer = cx + lengthdir_x(outer_radius, a1);
	    var y1_outer = cy + lengthdir_y(outer_radius, a1);

	    // Fading gradient from outer (alpha 0) to inner (alpha 1)
	    draw_primitive_begin(pr_trianglestrip);
	    draw_vertex_color(x0_outer, y0_outer, col, 0);
	    draw_vertex_color(x0_inner, y0_inner, col, 1);
	    draw_vertex_color(x1_outer, y1_outer, col, 0);
	    draw_vertex_color(x1_inner, y1_inner, col, 1);
	    draw_primitive_end();
	}



	// Draw head sprite at center
	draw_sprite_ext(spr_head, 0, cx, cy+(sprite_get_height(spr_head)/2*scale_gui),scale_gui,scale_gui,0,color1,1);
	draw_text_outlined(cx,cy,"Kills: " + string(global.kill_count),color1,1);


//city

if (room=rmCity)  {
	
// Draw Health Bar
draw_text(32, 32, "Health:");
draw_rectangle_color(120, 30, 220, 50, c_red, c_red, c_red, c_red, false);
draw_rectangle_color(120, 30, 120 + (global.health / global.max_health) * 100, 50, c_lime, c_lime, c_lime, c_lime, false);

// Draw Burnout Bar
draw_text(32, 60, "Burnout:");
draw_rectangle_color(120, 58, 220, 78, c_gray, c_gray, c_gray, c_gray, false);
draw_rectangle_color(120, 58, 120 + (global.burnout / global.max_burnout) * 100, 78, c_orange, c_orange, c_orange, c_orange, false);

// Draw Aggression
draw_text(32, 100, "Aggression: " + string(global.aggression));

// Draw Coins and Credits
draw_text(32, 130, "Coins: " + string(global.coins));
draw_text(32, 160, "Credits: " + string(global.credits));

// Draw Lives
draw_text(32, 190, "Lives: " + string(global.lives));
}


}

function scr_infinite_hud_step(){

}