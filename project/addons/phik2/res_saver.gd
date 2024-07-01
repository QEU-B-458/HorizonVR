@tool
extends Node3D
@export var excute_button: bool = false:
	set = _run


func _run(new_value: bool) -> void:
	excute_button = false
	print("Hello")
	var args = OS.get_cmdline_args()
	args.remove(0) # remove run script arg '-s'
	args.remove(0) # remove script name arg
	
	var image_path = args[0]
	
	var image = Image.new()
	image.load(image_path)
	
	print("Saving ", image_path, " to ", "image_resource.tres")
	
	
	OS.kill(OS.get_process_id())
