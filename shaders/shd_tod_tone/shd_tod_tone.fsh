varying vec2 v_vTexcoord;
varying vec4 v_vColor;

uniform vec3  u_ToneColor;   // 0..1 RGB (your blended sky color)
uniform float u_Strength;    // 0..1 (how strong to tint)
uniform float u_Lift;        // 0..1 (lift shadows a bit at day)
uniform float u_Gamma;       // ~1.0..1.2 (day can be slightly flatter)

void main(){
    vec4 src = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColor;

    // simple grade: lift -> gamma -> tint
    vec3 c = src.rgb;

    // Lift (push up shadows slightly)
    c = mix(c, max(c, vec3(u_Lift)), 1.0);

    // Gamma (daytime: a bit flatter)
    c = pow(max(c, 0.0), vec3(1.0 / max(u_Gamma, 0.0001)));

    // Tint toward tone color
    c = mix(c, mix(c, u_ToneColor, 0.6), u_Strength);

    gl_FragColor = vec4(c, src.a);
}
