shader_type canvas_item;

uniform float pixelCount : hint_range(0.0,256.0) = 16;

void fragment() {
	
	vec2 p_uv = UV-0.5;
	p_uv *= pixelCount;
	p_uv = floor(p_uv);
	p_uv /= pixelCount;
	p_uv += 0.5;
	p_uv += 1.0/pixelCount/2.0;
	COLOR = texture(TEXTURE,p_uv);
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
