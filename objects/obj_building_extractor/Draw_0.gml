/// @description Insert description here
// You can write your code in this editor


depth = 0;

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
 

builder.submit();

gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);
