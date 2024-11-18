//
// Pixel shader with transition effect
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;

void main()
{    
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord ); 
	if (gl_FragColor.r > time) gl_FragColor.a = 0.0; 
	gl_FragColor.rgb = vec3(0.0);
}