// shd_distort.fsh
varying vec2 v_vTexcoord;
uniform float u_time;
uniform sampler2D u_tex;

void main() {
    // wobble texcoords
    float amp = 0.01;       // distortion amount
    float freq = 12.0;
    float speed = 1.8;
    vec2 uv = v_vTexcoord;
    uv.x += sin((uv.y*freq) + u_time*speed) * amp;
    uv.y += cos((uv.x*freq) + u_time*speed) * amp * 0.6;

    gl_FragColor = texture2D(u_tex, uv);
}
