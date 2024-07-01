@tool
extends Resource

class_name LineGen3D

var immediate_canvas : ImmediateMesh = null

var render_mode = Mesh.PRIMITIVE_TRIANGLES
var uv_scale = 1.0

var _sf = SurfaceTool.new()
var _is = ImmediateSurface.new()
	
	
func draw_from_points_strip(p : PackedVector3Array = PackedVector3Array(),
					line_length : float = 1.0
					) -> ArrayMesh:
	_sf.begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
	
	var last = Vector3(0,0,0)
	var last_miter = null
	
	var ps = p.size()
	if ps < 2: return ArrayMesh.new()
	
	
	var acc = 0.0
	var last_dist = p[0].distance_squared_to(p[1])
	for i in range(ps-1):
		var cur_dist =p[i].distance_squared_to(p[i+1])
		acc += lerp(cur_dist,last_dist,0.2)
#	print(acc)
	acc = sqrt(acc)
	var ll = acc
#	line_length = ll
	
	var inv_ps = 1.0/(ps-1)
	
	for i in range(ps+2):
		var real_i = i
		if i > 0: i -= 1
		if i > ps-1: i -= 1
		var p1 = p[i]
		
		if p1 != null:
			if i < ps-1:
				last = p[i+1] - p1
			
			var dir = last
			if last_miter and i > 0 and i < ps-1:
				dir = last_miter
			
#			print(last_miter != null, " ", i)
			
			# TODO: calculate total_length
			var uv1x = 1.0-(inv_ps*(real_i-1)) 
#			print(uv, " ", i)
			var extras_uv2 = Vector2(line_length, inv_ps)
			
			
			_sf.set_normal( dir )
			
			_sf.set_uv( Vector2(uv1x,1.0) )
			_sf.set_uv2( extras_uv2 )
			_sf.add_vertex( p1 )
			
			_sf.set_normal( dir )
			
			_sf.set_uv( Vector2(uv1x,0.0) )
			_sf.set_uv2( extras_uv2 )
			_sf.add_vertex( p1 )
			
			
			if i < ps-2:
				last_miter = p[i+2] - p1
	
	var compress = Mesh.ARRAY_FORMAT_VERTEX+Mesh.ARRAY_FORMAT_NORMAL+Mesh.ARRAY_FORMAT_COLOR+Mesh.ARRAY_FORMAT_TEX_UV+Mesh.ARRAY_FORMAT_TEX_UV2
	
	# If vertex count > 1024, the method we use
	# to have rounded caps breaks
	# because half-float precision is not precise enough
	
	# We've enabled full-precision float for UV here
	# it's a waste of bits (uses 64 bits instead of 32) but it's a quick and easy fix,
	# and it's not as bad as using the entire vec4 COLOR buffer just to store a single float
#	compress -= Mesh.ARRAY_COMPRESS_TEX_UV
	
	return _sf.commit(null, compress)
