extends Node3D

@export var size = 8
@export var voxel_size = 0.125 # 20cm per pixel
@export var image: Texture2D

func _ready() -> void:
	var i = image.get_image()
	for x in i.get_width():
		for y in i.get_height():
			var color = i.get_pixel(x, y)
			
			if color.a > 0.1:
				create_voxel(Vector3(x, y, 0), color)

func create_voxel_shape(front_view: Texture2D):
	var front = front_view.get_image()
	
	for x in front.get_width():
		for y in front.get_height():
			var color = front.get_pixel(x,y)
			if color.a > 0.1:
				create_voxel(Vector3(x,y,0), color)
	pass

func create_voxel(pos: Vector3, color: Color):
	var cube = MeshInstance3D.new()
	var mesh = BoxMesh.new()
	
	mesh.size = Vector3.ONE * voxel_size
	cube.mesh = mesh  
	
	var mat = StandardMaterial3D.new()
	mat.albedo_color = color
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	cube.material_override = mat
	
	cube.position = pos * voxel_size
	add_child(cube)
