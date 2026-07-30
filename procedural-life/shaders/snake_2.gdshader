shader_type canvas_item;

uniform vec4 Color1 : source_color;
uniform vec4 Color2 : source_color;
uniform vec4 Color3 : source_color;
uniform int border_widtha;
uniform int border_widthb;
const float pixels = 32.0;

void fragment() {
	vec4 pixel_color = texture(TEXTURE,UV);
	if (pixel_color.rgb == vec3(0.0,0.0,0.0)){
		pixel_color = Color1;
		for (int i=1;i<border_widtha;i++){
			if (texture(TEXTURE,UV+vec2(0,float(i)/pixels)).rgb == vec3(1.0,1.0,1.0)){
					pixel_color = Color3;
				}
			if (texture(TEXTURE,UV-vec2(0,float(i)/pixels)).rgb == vec3(1.0,1.0,1.0)){
				pixel_color = Color3;
			}
		}
	}
	
	if (pixel_color.rgb == vec3(1.0,1.0,1.0)){
		pixel_color = Color2;
		for (int i=1;i<border_widthb;i++){
			if (texture(TEXTURE,UV+vec2(0,float(i)/pixels)).rgb == vec3(0.0,0.0,0.0)){
					pixel_color = Color3;
				}
			if (texture(TEXTURE,UV-vec2(0,float(i)/pixels)).rgb == vec3(0.0,0.0,0.0)){
				pixel_color = Color3;
			}
		}
		
	}
	COLOR = pixel_color;	
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
