shader_type canvas_item;

uniform vec2 origin;
uniform float radius = 0.2;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec2 grid_uv = round(UV * float(32)) / float(32);
	
	if (grid_uv.x*grid_uv.x + grid_uv.y*grid_uv.y < radius*radius)
		COLOR.a = 0.0;//(grid_uv.x*grid_uv.x + grid_uv.y*grid_uv.y) / (radius*radius*10.0);
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
