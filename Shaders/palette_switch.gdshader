shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_nearest;

group_uniforms Source_Colors;
uniform vec4 color_light: source_color = vec4(1.0);
uniform vec4 color_mid_light: source_color = vec4(1.0);
uniform vec4 color_mid_dark: source_color = vec4(1.0);
uniform vec4 color_dark: source_color = vec4(1.0);
group_uniforms;

group_uniforms Palette_Colors;
uniform vec4 palette_light: source_color = vec4(1.0);
uniform vec4 palette_mid_light: source_color = vec4(1.0);
uniform vec4 palette_mid_dark: source_color = vec4(1.0);
uniform vec4 palette_dark: source_color = vec4(1.0);
group_uniforms;


void fragment() 
{
	vec4 pixel_color = texture(TEXTURE, UV);
	
	if (pixel_color == color_light)
		COLOR = palette_light;
	else if (pixel_color == color_mid_light)
		COLOR = palette_mid_light;
	else if (pixel_color == color_mid_dark)
		COLOR = palette_mid_dark;
	else if (pixel_color == color_dark)
		COLOR = palette_dark;
	else 
		COLOR = vec4(1.0, 0.0, 0.0,1.0);
}

