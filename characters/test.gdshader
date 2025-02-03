shader_type canvas_item;

uniform vec4 silhouette_color : source_color = vec4(0.0, 0.0, 0.0, 0.5);
uniform float outline_size = 2.0; // Outline thickness

void fragment() {
    vec4 sprite_color = texture(TEXTURE, UV);
    
    float offset = outline_size / 100.0;
    
    vec4 left = texture(TEXTURE, UV + vec2(-offset, 0.0));
    vec4 right = texture(TEXTURE, UV + vec2(offset, 0.0));
    vec4 up = texture(TEXTURE, UV + vec2(0.0, offset));
    vec4 down = texture(TEXTURE, UV + vec2(0.0, -offset));

    // If background color detected (transparent part), draw silhouette
    if (sprite_color.a < 0.1 && (left.a > 0.1 || right.a > 0.1 || up.a > 0.1 || down.a > 0.1)) {
        COLOR = silhouette_color;
    } else {
        COLOR = sprite_color;
    }
}
