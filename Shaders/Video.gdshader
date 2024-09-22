shader_type spatial;
render_mode unshaded, fog_disabled;
uniform sampler2D render_target : filter_nearest,source_color;

void fragment() {
	vec4 col = texture(render_target,UV);
	ALBEDO = col.rgb;
}