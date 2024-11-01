class_name StageTwoCamera
extends CameraControllerBase

@export var autoscroll_speed: Vector3 = Vector3(10.0, 0.0, 10.0)
@export var top_left: Vector2 = Vector2(-11, -5)
@export var bottom_right: Vector2 = Vector2(11 ,5)

var left_edge
var top_edge
var right_edge
var bottom_edge

func _ready() -> void:
	position += Vector3(0.0, dist_above_target, 0.0)
	super()

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	global_position.x += autoscroll_speed.x * delta
	global_position.z += autoscroll_speed.z * delta
	
	left_edge = global_position.x + top_left.x
	top_edge = global_position.z + top_left.y
	bottom_edge = global_position.z + bottom_right.y
	right_edge = global_position.x + bottom_right.x
	
	if target.global_position.x < left_edge:
		target.global_position.x = left_edge
	if target.global_position.z < top_edge:
		target.global_position.z = top_edge
	if target.global_position.x > right_edge:
		target.global_position.x = right_edge
	if target.global_position.z > bottom_edge:
		target.global_position.z = bottom_edge
		
	super(delta)

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, top_left.y))
	
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(bottom_right.x, 0, bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(top_left.x, 0, top_left.y))
	
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)

	await get_tree().process_frame
	mesh_instance.queue_free()
