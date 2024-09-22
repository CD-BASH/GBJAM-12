shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float rotation_angle : hint_range(0, 180);
uniform sampler2D render_target : filter_nearest;

vec2 simulate_vertical_cube(vec2 uv, float angle) {
    vec2 centered_uv = uv - vec2(0.5, 0.5);
    float perspective_scale = abs(cos(angle));
    centered_uv.y /= perspective_scale;
    centered_uv.y += sin(angle) * 0.2;
	//centered_uv.x += sin(angle);
    return centered_uv + vec2(0.5, 0.5 + (angle * 0.1));
	//return centered_uv + vec2(0.5, 0.5);
}

void fragment() {
	vec2 uv = SCREEN_UV;
	vec2 uv2 = SCREEN_UV;
	float reverse = 1.0 - rotation_angle;
	uv = simulate_vertical_cube(uv ,rotation_angle);
	uv2 = simulate_vertical_cube(uv2,rotation_angle * -1.0);
	vec4 out_color = texture(screen_texture, uv);
	vec4 holdImage = texture(render_target, uv2);
	//out_color = vec4(out_color.r,0,0,1); // cheeky red effect
	COLOR = holdImage + out_color;
}