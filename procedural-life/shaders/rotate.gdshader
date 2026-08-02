shader_type canvas_item;

uniform float angle : hint_range(0.0, 2.0 * 3.14, 0.1);
uniform vec2 pivot = vec2(0.5,0.5);

vec2 RotateUV( vec2 uv, vec2 center, float angle_rad){
	mat2 rm = mat2(
		vec2(cos(angle_rad),-sin(angle_rad)),
		vec2(sin(angle_rad),cos(angle_rad))
	);
	uv -= center;
	uv = rm * uv;
	uv += center;
	
	return uv;
}

void fragment() {
	vec2 new_uv = RotateUV(UV, pivot, angle);
	vec4 color_image = texture(TEXTURE, new_uv);
	COLOR = color_image;
	//COLOR.rg = UV;
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
