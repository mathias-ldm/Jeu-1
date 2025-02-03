shader_type canvas_item;

uniform vec2 circle_center = vec2(0.5, 0.5); // Default center position of the circle
uniform float circle_radius = 0.01;

void vertex(){
}

void fragment() {
}

float my_distance(vec2 a, vec2 b) {
	return(pow(pow((a.x-b.x), 2) + pow((a.y-b.y), 2), 0.5));
}