shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec2 size = vec2(32.0, 28.0);
uniform float rotation_angle : hint_range(0, 180);

vec2 simulate_vertical_cube(vec2 uv, float angle) {
    vec2 centered_uv = uv - vec2(0.5, 0.5);
    float perspective_scale = abs(cos(angle));
    centered_uv.y /= perspective_scale; 
    centered_uv.y += sin(angle) * 0.2;  
    return centered_uv + vec2(0.5, 0.5); 
}

/*
vec2 rotate_uv(vec2 uv, float angle) {
    float cos_angle = cos(angle);
    float sin_angle = sin(angle);
	vec2 a = vec2(cos_angle, sin_angle);
	vec2 b = vec2(-sin_angle, cos_angle);
    mat2 rotation_matrix = mat2(a, b);
    vec2 centered_uv = uv - vec2(0.5, 0.5);  // Center the rotation around the middle of the screen
    return rotation_matrix * centered_uv + vec2(0.5, 0.5);
}*/

void fragment() {
	vec2 uv = SCREEN_UV;
	uv = simulate_vertical_cube(uv,rotation_angle);
	vec4 out_color = texture(screen_texture, uv);
	out_color = vec4(out_color.r,0,0,1);
	COLOR = vec4(out_color);
}