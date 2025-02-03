shader_type spatial;
render_mode cull_disabled;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D DEPTH_TEXTURE : hint_depth_texture, filter_linear_mipmap;

void fragment() {
    vec2 screen_uv = SCREEN_UV;

    // Read depth values
    float character_depth = textureLod(SCREEN_TEXTURE, screen_uv, 0.0).r;
    float scene_depth = textureLod(DEPTH_TEXTURE, screen_uv, 0.0).r;

    // Difference in depth: Only render outline where the object is hidden
    float depth_diff = scene_depth - character_depth;

    if (depth_diff > 0.001) {
        ALBEDO = vec3(1.0, 0.0, 0.0); // Red outline for hidden edges
    } else {
        discard;
    }
}