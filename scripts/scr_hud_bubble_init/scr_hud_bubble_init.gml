function scr_hud_bubble_init(){


///TRACKING BUBBLES
/////////
bubble_visible = false;
bubble_alpha = 0;
bubble_scale = 0;
bubble_max_scale = 1;
// In objEnemyPlane Create Event
bubble_visible = false;
bubble_alpha = 0;
bubble_scale = 0;
bubble_target_scale = .5; // ← this is the one that was missing
bubble_pulse_offset = random(1000); // each enemy gets a different offset
/////////////////



}