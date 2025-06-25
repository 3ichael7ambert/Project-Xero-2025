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
	global.spr_head = sprHead_old;
	global.spr_eyes = sprHead_old;
	global.spr_pupil = sprHead_old;
	global.color1=c_white;
	
	//2-4 players
	global.p2_health = 100;
	global.p2_burnout = 0;         
	global.p2_lives = 3;
	global.p2_max_health = 100;
	global.p2_max_burnout = 100;
	global.p2_kill_count = 0;
	global.p2_spr_head = sprHead_old;
	global.p2_spr_eyes = sprHead_old;
	global.p2_spr_pupil = sprHead_old;
	global.p2_color1=c_white;
	
	
	
	global.p3_health = 100;
	global.p3_burnout = 0;         
	global.p3_lives = 3;
	global.p3_max_health = 100;
	global.p3_max_burnout = 100;
	global.p3_kill_count = 0;
	global.p3_spr_head = sprHead_old;
	global.p3_spr_eyes = sprHead_old;
	global.p3_spr_pupil = sprHead_old;
	global.p3_color1=c_white;
	
	
	global.p4_health = 100;
	global.p4_burnout = 0;         
	global.p4_lives = 3;
	global.p4_max_health = 100;
	global.p4_max_burnout = 100;
	global.p4_kill_count = 0;
	global.p4_spr_head = sprHead_old;
	global.p4_spr_eyes = sprHead_old;
	global.p4_spr_pupil = sprHead_old;
	global.p4_color1=c_white;
	
	
	
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


function scr_infinite_hud_draw() {
	draw_set_font(fnt_menu_hud);
/// @description Kingdom Hearts-style circular health bar with spr_head in center (no ternary)

/// @description Draw HUD for up to 4 players, spaced left to right

var total_players = global.players;
var padding = 32;
var total_width = display_get_gui_width();
var space_between = total_width / (total_players + 1);

for (var i = 0; i < total_players; i++) {
    var player_index = i + 1;

        var hp, maxhp, spr_head, color1, kills;

    switch (player_index) {
        case 1:
            hp = global.health;
            maxhp = global.max_health;
            spr_head = global.spr_head;
            color1 = global.color1;
            kills = global.kill_count;
            break;
        case 2:
            hp = global.p2_health;
            maxhp = global.p2_max_health;
            spr_head = global.p2_spr_head;
            color1 = global.p2_color1;
            kills = global.p2_kill_count;
            break;
        case 3:
            hp = global.p3_health;
            maxhp = global.p3_max_health;
            spr_head = global.p3_spr_head;
            color1 = global.p3_color1;
            kills = global.p3_kill_count;
            break;
        case 4:
            hp = global.p4_health;
            maxhp = global.p4_max_health;
            spr_head = global.p4_spr_head;
            color1 = global.p4_color1;
            kills = global.p4_kill_count;
            break;
        default:
            // Fallback for undefined players
            hp = 0;
            maxhp = 100;
            spr_head = sprHead_old;
            color1 = c_gray;
            kills = 0;
            break;
    }


    // Center of this HUD
    var cx = space_between * player_index;
    var cy = display_get_gui_height() - 100;

    // Health settings
    var radius = 64;
    var hp_ratio = clamp(hp / maxhp, 0, 1);
    var segments = 100;
    var angle_range = 270;
    var start_angle = -135;

    // Decide HP color
    var col;
    if (hp_ratio > 0.5) {
        col = c_lime;
    } else if (hp_ratio > 0.25) {
        col = c_yellow;
    } else {
        col = c_red;
    }

    draw_set_color(col);

    // Draw health arc
    var end_angle = start_angle + angle_range * hp_ratio;
    for (var j = 0; j < segments; j++) {
        var a0 = start_angle + (angle_range / segments) * j;
        var a1 = start_angle + (angle_range / segments) * (j + 1);

        if (a1 > end_angle) break;

        var x0 = cx + lengthdir_x(radius, a0);
        var y0 = cy + lengthdir_y(radius, a0);
        var x1 = cx + lengthdir_x(radius, a1);
        var y1 = cy + lengthdir_y(radius, a1);

        draw_triangle(cx, cy, x0, y0, x1, y1, false);
    }

    // Draw gradient ring
    var inner_radius = radius - 10;
    var outer_radius = radius + 10;
    var gradient_segments = 100;

    for (var j = 0; j < gradient_segments; j++) {
        var a0 = start_angle + (angle_range / gradient_segments) * j;
        var a1 = start_angle + (angle_range / gradient_segments) * (j + 1);

        var x0_inner = cx + lengthdir_x(inner_radius, a0);
        var y0_inner = cy + lengthdir_y(inner_radius, a0);
        var x0_outer = cx + lengthdir_x(outer_radius, a0);
        var y0_outer = cy + lengthdir_y(outer_radius, a0);

        var x1_inner = cx + lengthdir_x(inner_radius, a1);
        var y1_inner = cy + lengthdir_y(inner_radius, a1);
        var x1_outer = cx + lengthdir_x(outer_radius, a1);
        var y1_outer = cy + lengthdir_y(outer_radius, a1);

        draw_primitive_begin(pr_trianglestrip);
        draw_vertex_color(x0_outer, y0_outer, col, 0);
        draw_vertex_color(x0_inner, y0_inner, col, 1);
        draw_vertex_color(x1_outer, y1_outer, col, 0);
        draw_vertex_color(x1_inner, y1_inner, col, 1);
        draw_primitive_end();
    }

    // Draw head
    var scale_gui = 0.2;
    draw_sprite_ext(spr_head, 0, cx, cy + (sprite_get_height(spr_head) / 2 * scale_gui), scale_gui, scale_gui, 0, color1, 1);

    // Draw kill count (placeholder)
    draw_text_outlined(cx, cy, "P" + string(player_index) + " Kills: " + string(global.kill_count), color1, 1);
}


//city
// Draw extra UI for rmCity
if (room == rmCity) {
    draw_text(32, 32, "Health:");
    draw_rectangle_color(120, 30, 220, 50, c_red, c_red, c_red, c_red, false);
    draw_rectangle_color(120, 30, 120 + (global.health / global.max_health) * 100, 50, c_lime, c_lime, c_lime, c_lime, false);

    draw_text(32, 60, "Burnout:");
    draw_rectangle_color(120, 58, 220, 78, c_gray, c_gray, c_gray, c_gray, false);
    draw_rectangle_color(120, 58, 120 + (global.burnout / global.max_burnout) * 100, 78, c_orange, c_orange, c_orange, c_orange, false);

    draw_text(32, 100, "Aggression: " + string(global.aggression));
    draw_text(32, 130, "Coins: " + string(global.coins));
    draw_text(32, 160, "Credits: " + string(global.credits));
    draw_text(32, 190, "Lives: " + string(global.lives));
}


}

function scr_infinite_hud_step(){

}