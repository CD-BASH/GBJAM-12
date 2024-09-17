shader_type spatial;
render_mode unshaded, fog_disabled, cull_disabled;
uniform sampler2D test_texture : filter_nearest;

void fragment() {
	vec4 tex = texture(test_texture,UV);
	ALBEDO = tex.xyz;
	ALPHA = tex.a;
	ALPHA_SCISSOR_THRESHOLD= 0.1;
}
