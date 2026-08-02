shader_type canvas_item;

uniform float strength : hint_range(0.0, 1000, 1);
uniform vec2 pivot = vec2(0.5,0.5);

vec2 TwirlUV( vec2 uv, vec2 center, float angle_rad){
	
	uv -= center;
	angle_rad *=  length(uv);
	mat2 rm = mat2(
		vec2(cos(angle_rad),-sin(angle_rad)),
		vec2(sin(angle_rad),cos(angle_rad))
	);
	uv = rm * uv;
	uv += center;
	
	return uv;
}

void fragment() {
	vec2 new_uv = TwirlUV(UV, pivot, strength+ float(sin(TIME)*2.0) * 10.0);
	vec4 color_image = texture(TEXTURE, new_uv);
	COLOR = color_image;
	//COLOR.rg = UV;
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
