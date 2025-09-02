varying vec2 v_vTexcoord;
varying vec4 v_vColor;
varying vec3 v_wNormal;
varying float v_faceUp;
varying float v_height;

uniform vec3  u_LightDir;    // world-space dir FROM light TO scene
uniform vec3  u_LightColor;  // sun color (scaled outside as needed)
uniform vec3  u_SkyColor;    // sky ambient
uniform vec3  u_GroundColor; // ground ambient
uniform float u_Ambient;     // ambient amount
uniform float u_GradBase;    // vertical gradient strength
uniform float u_GradScale;   // how fast height fades (1/units)

void main(){
    vec4 tex = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColor;
    if (tex.a <= 0.001) discard;

    vec3 N = normalize(v_wNormal);
    if (!all(greaterThan(abs(N), vec3(0.0001)))) N = vec3(0.0, 1.0, 0.0);

    // Diffuse
    float NdotL = max(dot(N, -u_LightDir), 0.0);

    // Hemisphere ambient
    float hemi = clamp(N.y * 0.5 + 0.5, 0.0, 1.0);
    vec3  hemiCol = mix(u_GroundColor, u_SkyColor, hemi);

    // “POP”: roof brighter, sides darker (orientation bias)
    float orientBoost = mix(0.80, 1.10, v_faceUp); // sides ~0.8, tops ~1.1

    // Vertical gradient: darker lower down → quick city pop
    float hfac = clamp(exp(-abs(v_height) * u_GradScale), 0.0, 1.0);
    float grad = mix(1.0 - u_GradBase, 1.0, hfac); // base dark at street level

    vec3 base = tex.rgb;
    vec3 diffuse = base * u_LightColor * NdotL;
    vec3 ambient = base * hemiCol * u_Ambient;

    vec3 color = (ambient + diffuse) * orientBoost * grad;
    gl_FragColor = vec4(color, tex.a);
}
