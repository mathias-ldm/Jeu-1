shader_type canvas_item;

uniform vec2 tiled_factor = vec2(1.0, 1.0);

void fragment() {
	vec2 tiled_uvs = UV * tiled_factor;
	COLOR = vec4(tiled_uvs, 0, 1.0);
}
