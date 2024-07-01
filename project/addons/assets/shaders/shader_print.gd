# perlin_noise_3d.gd
# debug_node.gd
@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeDebug
var testnode

# Set the name of the node
func _get_name():
	return "DebugNode"

# Set the category under which the node will appear
func _get_category():
	return "Debug"

# Set the description of the node
func _get_description():
	return "Outputs the input value for debugging purposes."

# Initialize default values
func _init():
	set_input_port_default_value(0, Vector3(0, 0, 0))
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 1.0)
	set_input_port_default_value(3, 0.0)

# Set the return type icon
func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

# Set the number of input ports
func _get_input_port_count():
	return 4

# Set the names of the input ports
func _get_input_port_name(port):
	match port:
		0:
			return "uv"
		1:
			return "offset"
		2:
			return testnode
		3:
			return "time"

# Set the types of the input ports
func _get_input_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR

# Set the number of output ports
func _get_output_port_count():
	return 1

# Set the name of the output port
func _get_output_port_name(port):
	return "debug_output"

# Set the type of the output port
func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR

# Generate the GLSL code for the node
func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + " = " + set_input_port_default_value(2,testnode) + ";"
