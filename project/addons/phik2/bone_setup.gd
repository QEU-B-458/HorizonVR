@tool
extends Node3D 
class_name bone_setup
@export var skeleton: Skeleton3D
@export var bone_idx: int
@export var base : Node3D
@export var excute_button: bool = false:
	set = _run
var current_state: int = bone_idx
var previous_state: int = bone_idx 
var next_state: int = bone_idx 


func _run(new_value: bool) -> void:
	excute_button = false
	previous_state = bone_idx - 1
	current_state = bone_idx
	next_state = current_state + 1
	add_rb_and_collider_recursive(skeleton,bone_idx)

	
func update_state(bidx:int):
	previous_state = current_state
	current_state = next_state
	next_state += 1
	
func add_rb_and_collider_recursive(skeleton: Skeleton3D, bone_idx: int):
	
	var bone_name = skeleton.get_bone_name(bone_idx)
	print("bone name ", bone_name)
	var start_bone = skeleton.get_bone_global_pose(bone_idx)
	var bone_mid_point = start_bone.origin.length() 
	#print("start bone", start_bone)
	
	print("ps ",previous_state)
	print("cs ",current_state)
	print("ns ",next_state)
	
	var qt = skeleton.get_bone_pose_rotation(bone_idx)
	
	#var qtt = qt.
	
	var rb = RigidBody3D.new()
	rb.transform = start_bone
	base.add_child(rb)
	rb.set_owner(base.owner)
	rb.name = bone_name
	
	#var bone_start = skeleton.get_bone_pose_position(current_state)
	#print("bst ", bone_start)
	var bone_end = skeleton.get_bone_global_pose(next_state)
	
	#var offset_vector = bone_end - bone_start
	#print("ov ",offset_vector)
	## Calculate the half-distance vector
	#var half_distance_vector = offset_vector / 2
	#print("hdv ", half_distance_vector)
	## Calculate the midpoint in global coordinates
	#var midpoint = bone_start + half_distance_vector
	
	var bone_start = rb.transform.origin
	print("bst ", bone_start)
	var offset_vector = bone_end - bone_start
	print("ov ",offset_vector)
	# Calculate the half-distance vector
	var half_distance_vector = offset_vector / 2
	print("hdv ", half_distance_vector)
	# Calculate the midpoint in global coordinates
	var midpoint = bone_start + half_distance_vector
	
	
	
	#print("bone length ", bone_length)
	print("bm ", midpoint)
	#print("end ",end_pos)
	#print("gbp ", global_bone_pos)
	#
	var mi = CollisionShape3D.new()
	mi.transform.origin = midpoint
	rb.add_child(mi)
	mi.set_owner(rb.owner)
	print(bone_name)
	mi.name = bone_name + " collider"
	
	
	#var bone_length = start_pos.distance_to(end_pos)
	#var bone_midpoint = (start_pos + end_pos) / 2
	
	#var bone_attachment = BoneAttachment3D.new()
	#bone_attachment.name = "BoneAttachment_" + bone_name
	#bone_attachment.bone_name = bone_name
	#bone_attachment.transform.origin = bone_midpoint
	#skeleton.add_child(bone_attachment)
	
	#var rb = RigidBody3D.new()
	#rb.name = "RigidBody_" + bone_name
	#rb.transform.origin = bone_midpoint
	#bone_attachment.add_child(rb)
	
	#var collider = CollisionShape3D.new()
	#collider.name = "Collider_" + bone_name
	#collider.transform.origin = Vector3.ZERO
	#rb.add_child(collider)
	update_state(bone_idx)
	for child_bone_idx in skeleton.get_bone_children(bone_idx):
		add_rb_and_collider_recursive(skeleton, child_bone_idx)
		
