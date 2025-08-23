varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D gm_BaseTexture; // application_surface
uniform vec3 u_tone_rgb;          // 0..1 tone color (from your sky color)
uniform float u_strength;         // 0..1 how strong the grade is
uniform float u_contrast;         // optional: contrast tweak (-1..+1), 0 = off

// simple contrast function around 0.5 gray
vec3 apply_contrast(vec3 c, float k) {
    if (k == 0.0) return c;
    // remap k (-1..1) -> (0..2), 1 = no change
    float f = 1.0 + k;
    return clamp((c - 0.5) * f + 0.5, 0.0, 1.0);
}

void main() {
    vec4 base = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;

    // Grade: lerp toward tone
    vec3 graded = mix(base.rgb, u_tone_rgb, clamp(u_strength, 0.0, 1.0));

    // Optional subtle contrast to keep image from looking washed
    graded = apply_contrast(graded, u_contrast);

    gl_FragColor = vec4(graded, base.a);
}
