@tool
extends MeshInstance3D
#@export var excute_button: bool = false: set = _run

@export var height = float(0)#: set = _run
@export var radius = 0.002
@export var top_height = 0.5
@export var num_edges = 6
# Called when the node enters the scene tree for the first time.
func _ready():
	_run(2)

 
func _run(height):
	print("test", height)
	#var test = Vector3(radius * cos(1 * TAU / 1),height,radius * sin(1 * TAU / 1)),
	#print(test)
	var arr_mesh = ArrayMesh.new()
	var vertices := PackedVector3Array([
	Vector3(0,top_height + height, 0),       # 0: Top center vertex
	Vector3(radius * cos(1 * TAU / num_edges),height,radius * sin(1 * TAU / num_edges)),	# 1: Top edge vertex
	Vector3(radius * cos(2 * TAU / num_edges),height,radius * sin(2 * TAU / num_edges)),	# 2: Top edge vertex
	Vector3(radius * cos(3 * TAU / num_edges),height,radius * sin(3 * TAU / num_edges)),	# 3: Top edge vertex
	Vector3(radius * cos(4 * TAU / num_edges),height,radius * sin(4 * TAU / num_edges)),	# 4: Top edge vertex
	Vector3(radius * cos(5 * TAU / num_edges),height,radius * sin(5 * TAU / num_edges)),	# 5: Top edge vertex
	Vector3(radius * cos(6 * TAU / num_edges),height,radius * sin(6 * TAU / num_edges)),	# 6: Top edge vertex
	
	
	Vector3(radius * cos(6 * TAU / num_edges),0,radius * sin(6 * TAU / num_edges)),# 7: Bottom edge vertex
	Vector3(radius * cos(5 * TAU / num_edges),0,radius * sin(5 * TAU / num_edges)),# 8: Bottom edge vertex
	Vector3(radius * cos(4 * TAU / num_edges),0,radius * sin(4 * TAU / num_edges)),# 9: Bottom edge vertex
	Vector3(radius * cos(3 * TAU / num_edges),0,radius * sin(3 * TAU / num_edges)),# 10: Bottom edge vertex
	Vector3(radius * cos(2 * TAU / num_edges),0,radius * sin(2 * TAU / num_edges)),# 11: Bottom edge vertex
	Vector3(radius * cos(1 * TAU / num_edges),0,radius * sin(1 * TAU / num_edges)),# 12: Bottom edge vertex
	Vector3(0, 0, 0)# 13: Bottom center vertex
])
	var indices := PackedInt32Array([
		# Top face
		0, 1, 2,
		0, 2, 3,
		0, 3, 4,
		0, 4, 5,
		0, 5, 6,
		0, 6, 1,
		
		# Bottom face
		13, 7, 8,
		13, 8, 9,
		13, 9, 10,
		13, 10, 11,
		13, 11, 12,
		13, 12, 7,
		
		# Sides
		12,11,2,
		11,10,2,
		10,3,2,
		3,10,9,
		3,9,4,
		9,8,4,
		4,8,5,
		8,7,5,
		5,7,6,
		6,7,12,
		6,12,1,
		1,12,2
	])
	
	# Initialize the ArrayMesh.
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_INDEX] = indices
	
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	mesh = arr_mesh
