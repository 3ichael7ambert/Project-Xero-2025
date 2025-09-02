attribute vec3 in_Position;
attribute vec2 in_TextureCoord;
attribute vec4 in_Color;
varying vec2 v_vTexcoord;
varying vec4 v_vColor;
void main(){
    v_vTexcoord = in_TextureCoord;
    v_vColor    = in_Color;
    gl_Position = vec4(in_Position, 1.0);
}
