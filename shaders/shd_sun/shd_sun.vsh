// attributes from your vertex format
attribute vec3 in_Position;
attribute vec2 in_TextureCoord;
attribute vec4 in_Color;
attribute vec3 in_Normal; // <-- add this to your vertex format

varying vec2 v_vTexcoord;
varying vec4 v_vColor;
varying vec3 v_wNormal;

void main() {
    v_vTexcoord = in_TextureCoord;
    v_vColor    = in_Color;

    // world position
    vec4 wpos = gm_Matrices[MATRIX_WORLD] * vec4(in_Position, 1.0);
    gl_Position = gm_Matrices[MATRIX_PROJECTION] * gm_Matrices[MATRIX_VIEW] * wpos;

    // world-space normal (no non-uniform scale in your matrices; if you use it, build a proper normal matrix)
    mat3 N = mat3(gm_Matrices[MATRIX_WORLD]);
    v_wNormal = normalize(N * in_Normal);
}
