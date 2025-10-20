/// obj_cave_extractor_sky.Draw (or End Step in your render order)

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_cullmode(cull_noculling);

// fog optional
var tod = scr_timeofday_color();
//gpu_set_fog(true, tod, 500, 1000);

builder.submit();

//gpu_set_fog(false, tod, 500, 1000);
gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);
