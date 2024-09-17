shader_type spatial;
render_mode unshaded;

group_uniforms Palette_Colors;
uniform vec3 palette_light: source_color = vec3(1.0);
group_uniforms;

void fragment() {
	ALBEDO = vec3(palette_light);
}