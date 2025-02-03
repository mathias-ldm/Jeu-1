shader_type canvas_item;

uniform float var = 0;
uniform float amount = 32;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 grid_uv = round(UV * float(amount)) / float(amount);
	if (grid_uv.x + grid_uv.y > var) {
		COLOR.a = 0.0;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
