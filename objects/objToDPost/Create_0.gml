/*sh_tone = asset_get_index(shd_sun);
if (sh_tone != -1 && shader_is_compiled(sh_tone)) {
    u_tone = shader_get_uniform(sh_tone, "u_ToneColor");
    u_str  = shader_get_uniform(sh_tone, "u_Strength");
    u_lift = shader_get_uniform(sh_tone, "u_Lift");
    u_gam  = shader_get_uniform(sh_tone, "u_Gamma");
} else sh_tone = -1;

application_surface_enable(true);
