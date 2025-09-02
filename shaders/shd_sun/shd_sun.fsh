varying vec2 v_vTexcoord;
varying vec4 v_vColor;
varying vec3 v_wNormal;

uniform vec3 u_LightDir;   // world-space, normalized; points FROM light TO scene
uniform vec3 u_LightColor; // e.g., vec3(1.0, 0.96, 0.90) at noon, warmer at sunset
uniform vec3 u_SkyColor;   // e.g., vec3(0.35, 0.50, 0.85)
uniform vec3 u_GroundColor;// e.g., vec3(0.25, 0.20, 0.18)
uniform float u_Ambient;   // 0..1 blend factor for ambient strength (try 0.4)

void main() {
    vec4 tex = texture2D(gm_BaseTexture, v_vTexcoord);
    if (tex.a <= 0.001) discard;

    vec3 N = normalize(v_wNormal);
    float NdotL = max(dot(N, -u_LightDir), 0.0); // light coming along -dir

    // Hemispheric ambient: mix ground/sky by how much the normal points up
    float hemi = clamp(N.y * 0.5 + 0.5, 0.0, 1.0);
    vec3 hemiCol = mix(u_GroundColor, u_SkyColor, hemi);

    // Combine
    vec3 base = tex.rgb * v_vColor.rgb;
    vec3 diffuse = base * u_LightColor * NdotL;
    vec3 ambient = base * mix(vec3(0.0), hemiCol, u_Ambient);

    gl_FragColor = vec4(ambient + diffuse, tex.a * v_vColor.a);
}
