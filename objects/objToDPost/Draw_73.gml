// Helpers (use your versions if already added)

var hour   = date_get_hour(date_current_datetime());
var minute = date_get_minute(date_current_datetime());
var bg_col = scr_timeofday_color(hour, minute);
var tone   = col_to_vec3(bg_col);

// Day factor (0 midnight → 1 noon)
var t  = (hour + minute/60) / 24;
var day = 0.5 * (1 - cos(2*pi*t));

// Grade knobs
var strength = lerp(0.10, 0.35, day);       // more tint near sunrise/sunset, mild at night/noon
var lift     = lerp(0.00, 0.08, day);       // lift shadows in the day
var gamma    = lerp(1.00, 1.12, day);       // slightly flatter in the day

if (sh_tone != -1) {
    shader_set(sh_tone);
    shader_set_uniform_f(u_tone, tone[0], tone[1], tone[2]);
    shader_set_uniform_f(u_str,  strength);
    shader_set_uniform_f(u_lift, lift);
    shader_set_uniform_f(u_gam,  gamma);

    draw_surface(application_surface, 0, 0);
    shader_reset();
} else {
    draw_surface(application_surface, 0, 0);
}
