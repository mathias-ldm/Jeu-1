shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;
uniform vec4 silhouette_color: source_color = vec4(0.0, 0.0, 0.0, 0.5);

void fragment() {
	vec4 screen_color = texture(screen_texture,SCREEN_UV);
	vec4 sprite_color = texture(TEXTURE, UV);

    if (all(lessThan(abs(sprite_color - screen_color), vec4(0.01)))) {
        discard;
    }
	
    // Apply silhouette color
    COLOR = vec4(silhouette_color.rgb, silhouette_color.a * sprite_color.a);
}
