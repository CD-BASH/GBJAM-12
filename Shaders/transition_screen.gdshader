shader_type canvas_item;

uniform vec2 tiling = vec2(1.0, 1.0);
uniform vec2 offset;
uniform float number_frame;
uniform float frame_index;

uniform vec4 color_transition: source_color = vec4(1.0);

void vertex() {
	UV = UV * tiling + offset * TIME;
	UV.x = (UV.x / number_frame) + (frame_index * 1.0 / number_frame);
}

void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	
	if (pixel_color.a != 0.0)
	{
		pixel_color = vec4(color_transition.rgb, 1.0);
	}
	
	COLOR = pixel_color;
}
