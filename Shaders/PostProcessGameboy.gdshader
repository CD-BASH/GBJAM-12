shader_type spatial;
render_mode unshaded, fog_disabled;

uniform sampler2D screen_texture : source_color,hint_screen_texture,filter_nearest;
uniform sampler2D depth_texture : source_color,hint_depth_texture,filter_linear;

group_uniforms Palette_Colors;
uniform vec3 palette_light: source_color = vec3(1.0);
uniform vec3 palette_mid_light: source_color = vec3(1.0);
uniform vec3 palette_mid_dark: source_color = vec3(1.0);
uniform vec3 palette_dark: source_color = vec3(1.0);
uniform vec3 error_color: source_color = vec3(1.0);
group_uniforms;


void vertex() {
	POSITION = vec4(VERTEX.xy,1.0,1.0);
}

void fragment(){
	float depth = texture(depth_texture, SCREEN_UV).r;
	vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, depth);
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc,1.0);
	view.xyz /= view.w;
	vec3 original = texture(screen_texture, SCREEN_UV).rgb;
	
	float light_range = 0.9;
	float mid_range = 0.5;
	float dark_range = 0.1;
	
	if (original.r > light_range)
	{
		ALBEDO = palette_light;
	}
	else if (original.r < dark_range)
	{
		ALBEDO = palette_dark;
	}
	else if (original.r  > mid_range)
	{
		ALBEDO = palette_mid_light;
	}
	else if (original.r < mid_range)
	{
		ALBEDO = palette_mid_dark;
	}
	else
	{
		ALBEDO = error_color;
	}
}
