shader_type spatial;

uniform float radius : hint_range(0.0, 10.0) = 1.0;

void vertex() {
    vec3 pos = VERTEX;
    float angle = pos.x / radius;
    float new_z = radius * sin(angle);
    float new_x = radius * (1.0 - cos(angle));
    VERTEX.x = new_x;
    VERTEX.z = new_z;
}


//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
