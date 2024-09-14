shader_type canvas_item;

group_uniforms Palette_Colors;
uniform vec4 palette_light: source_color = vec4(1.0);
uniform vec4 palette_mid_light: source_color = vec4(1.0);
uniform vec4 palette_mid_dark: source_color = vec4(1.0);
uniform vec4 palette_dark: source_color = vec4(1.0);
group_uniforms;


void fragment() 
{
	vec4 pixel_color = texture(TEXTURE, UV);
	vec4 error_color = vec4(1.0, 0.0, 0.0, 1.0);
	
	float light_range = 0.9;
	float mid_range = 0.5;
	float dark_range = 0.1;
	
	if (pixel_color.a < 0.9)
	{
		COLOR.a = 0.0;
	}
	else if (pixel_color.r > light_range)
	{
		COLOR = palette_light;
	}
	else if (pixel_color.r < dark_range)
	{
		COLOR = palette_dark;
	}
	else if (pixel_color.r  > mid_range)
	{
		COLOR = palette_mid_light;
	}
	else if (pixel_color.r < mid_range)
	{
		COLOR = palette_mid_dark;
	}
	else
	{
		COLOR = error_color;
	}
}

