shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(0.0,0.0,0.0,1.0);
uniform bool corner_pixel = true;

void fragment() {
	vec4 base = texture(TEXTURE, UV);
	if (base.a > 0.0){
		COLOR = base;
	}
	else{
		vec2 image_picture_size = TEXTURE_PIXEL_SIZE;
		bool valid_size = 
			texture(TEXTURE,UV+vec2(-image_picture_size.x,0)).a  > 0.0 ||
			texture(TEXTURE,UV+vec2(+image_picture_size.x,0)).a  > 0.0 ||
			texture(TEXTURE,UV+vec2(0,-image_picture_size.y)).a  > 0.0 ||
			texture(TEXTURE,UV+vec2(0,+image_picture_size.y)).a  > 0.0;
		bool valid_corner = 
			texture(TEXTURE,UV+vec2(-image_picture_size.x,-image_picture_size.y)).a  > 0.0 ||
			texture(TEXTURE,UV+vec2(+image_picture_size.x,+image_picture_size.y)).a  > 0.0 ||
			texture(TEXTURE,UV+vec2(+image_picture_size.x,-image_picture_size.y)).a  > 0.0 ||
			texture(TEXTURE,UV+vec2(-image_picture_size.x,+image_picture_size.y)).a  > 0.0;
		if (valid_size || (corner_pixel && valid_corner)){
			COLOR = outline_color;
		}
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
