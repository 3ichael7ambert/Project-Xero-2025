if global.debug = true {
    //draw the fps
    draw_set_halign(fa_center)
    if fps > 55 draw_set_color(c_white) else draw_set_color(c_red)
    draw_text(__view_get( e__VW.XView, 0 )+(__view_get( e__VW.WView, 0 )/2),__view_get( e__VW.YView, 0 )+20,string_hash_to_newline("FPS "+string(fps)))
}
else {
    draw_set_halign(fa_center)
    draw_set_color(c_white)
    draw_text(__view_get( e__VW.XView, 0 )+(__view_get( e__VW.WView, 0 )/2),__view_get( e__VW.YView, 0 )+20,string_hash_to_newline("Walk - left, right#Jump - space#Restart - R#Debug - D"))
}

