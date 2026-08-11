shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float scanline_count : hint_range(0, 1080) = 300.0;

float noise(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}



void fragment() {
	vec2 uv = SCREEN_UV;
	
	// Create dynamic horizontal line glitch glitches
	float time_glitch = sin(TIME * 10.0) * cos(TIME * 2.0);
	if (noise(vec2(floor(uv.y * 30.0), time_glitch)) > 0.98) {
		uv.x += noise(vec2(uv.y, TIME)) * 0.02;
	}
	
	// Sample the scene behind the color rect
	vec4 text_color = texture(SCREEN_TEXTURE, uv);
	
	// Add dynamic static noise over everything
	float static_noise = noise(uv * TIME) * 0.12;
	text_color.rgb += vec3(static_noise);
	
	// Add horizontal TV scanlines
	float scanline = sin(uv.y * scanline_count * 3.14159) * 0.04;
	text_color.rgb -= vec3(scanline);
	
	COLOR = text_color;
}
