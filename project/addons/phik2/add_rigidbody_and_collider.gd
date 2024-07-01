@tool
extends EditorScript

@export var excute_button: bool = false:
	set = run
func run(new_value: bool) -> void:
	excute_button = false
	print("dutton ", excute_button)
	
	
func add_rb_and_collider_recursive(skeleton: Skeleton3D, bone_idx: int):
	var bone_name = skeleton.get_bone_name(bone_idx)
	
	var start_pos = skeleton.global_transform.origin
	var end_pos = start_pos + skeleton.get_bone_global_pose(bone_idx).origin
	var bone_length = start_pos.distance_to(end_pos)
	var bone_midpoint = (start_pos + end_pos) / 2
	
	var bone_attachment = BoneAttachment3D.new()
	bone_attachment.name = "BoneAttachment_" + bone_name
	bone_attachment.bone_name = bone_name
	bone_attachment.transform.origin = bone_midpoint
	skeleton.add_child(bone_attachment)
	
	var rb = RigidBody3D.new()
	rb.name = "RigidBody_" + bone_name
	rb.transform.origin = bone_midpoint
	bone_attachment.add_child(rb)
	
	var collider = CollisionShape3D.new()
	collider.name = "Collider_" + bone_name
	collider.transform.origin = Vector3.ZERO
	rb.add_child(collider)
	
	for child_bone_idx in skeleton.get_bone_children(bone_idx):
		add_rb_and_collider_recursive(skeleton, child_bone_idx)
