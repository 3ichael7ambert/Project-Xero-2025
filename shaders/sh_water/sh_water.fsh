//
// Water shader with contrast, saturation, brightness and wave.
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float pixelH;
uniform float pixelW;
uniform float springs[1000];
uniform float time;
uniform float fizzle;
uniform float springCount;
uniform float contrast;
uniform float saturation;
uniform float brightness;

void main()
{
	vec2 p = v_vTexcoord;
	float py = 1.0 - p.y;
	float pixelsIn = (p.x / pixelW);
	int chunk = int(floor(p.x * springCount));
	int nextchunk = int(min(floor(p.x * springCount)+1.0, 99.0));
	float chunkpercent = (p.x * springCount) - floor(p.x * springCount);
	p.y = p.y + ((sin((pixelsIn*0.1) + time)*(1.5*pixelH)) * py);
	p.y = p.y + ((sin((pixelsIn*0.15) - time*1.2)*(1.5*pixelH)) * py);
	p.y = p.y + (mix(springs[chunk] * pixelH, springs[nextchunk] * pixelH, chunkpercent) * py);
	p.y = max(p.y,0.0);
	
	vec4 out_col = texture2D( gm_BaseTexture, p ).rgba;
	float grey = dot(out_col, vec4(0.299, 0.587, 0.114, 0.5));
	
	out_col	= mix(vec4(grey), out_col, saturation); // saturation
	out_col	= (out_col - 0.5) * contrast + 0.5; // contrast
	out_col	= out_col + brightness; // brightness
	
	gl_FragColor = vec4(out_col);
}