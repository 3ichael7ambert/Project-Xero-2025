attribute vec3 in_Position;
attribute vec2 in_TextureCoord;
attribute vec4 in_Color;
attribute vec3 in_Normal; // <-- make sure your vertex format provides this

varying vec2 v_vTexcoord;
varying vec4 v_vColor;
varying vec3 v_wNormal;
varying float v_faceUp;   // for subtle orientation-based pop
varying float v_height;   // world y for a vertical gradient

void main(){
    v_vTexcoord = in_TextureCoord;
    v_vColor    = in_Color;

    vec4 wpos = gm_Matrices[MATRIX_WORLD] * vec4(in_Position, 1.0);
    gl_Position = gm_Matrices[MATRIX_PROJECTION] * gm_Matrices[MATRIX_VIEW] * wpos;

    mat3 N = mat3(gm_Matrices[MATRIX_WORLD]);
    v_wNormal = normalize(N * in_Normal);

    v_faceUp = clamp(v_wNormal.y * 0.5 + 0.5, 0.0, 1.0);  // 0 side/down → 1 up
    v_height = wpos.y;
}
