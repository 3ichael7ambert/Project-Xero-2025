//debug


draw_text(x+10,y+10,string(global.players_array));
if (array_length(global.players_array)>=1) {
	draw_text(x+10,y+30,string(global.players_array[0].self_id));
	draw_text(x+10,y+40,string(global.players_array[0].x));
	draw_text(x+10,y+50,string(global.players_array[0].y));
}



var total_x = 0;
var total_y = 0;
var count = array_length(global.players_array);

if (count > 0) {
    for (var i = 0; i < count; i++) {
        total_x += global.players_array[i].x;
        total_y += global.players_array[i].y;
    }

    var target_x = total_x / count;
    var target_y = total_y / count;

    // Optional: draw the result
    draw_text(x + 10, y + 70, "Avg X: " + string(target_x));
    draw_text(x + 10, y + 80, "Avg Y: " + string(target_y));
}
