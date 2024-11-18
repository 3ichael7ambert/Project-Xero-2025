/// @description Create objects
with (instance_create(0, 0, objCamera360))
{
    target = instance_create(__view_get( e__VW.WView, 0 )/2, __view_get( e__VW.HView, 0 )/2, obj_Player1);
}
create_parallax_layer(backCloudLayer1, 0.2, 0.2, 0.2, 0, 1000, c_white, 0.6);
create_parallax_layer(backCloudLayer2, 0.4, 0.4, 0.1, 0, 1010, c_white, 0.3);
create_parallax_layer(backCloudLayer3, 0.6, 0.6, 0.05, 0, 1020, c_white, 0.15);

alarm[0] = room_speed;


///Set random background colour
__background_set_colour( choose(
                    make_colour_rgb(240, 220, 160),
                    make_colour_rgb(200, 230, 240),
                    make_colour_rgb(200, 240, 200),
                    make_colour_rgb(240, 180, 180),
                    ) );


