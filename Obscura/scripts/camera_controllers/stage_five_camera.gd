class_name stage_five_camera
extends CameraControllerBase

@export var push_ratio: float = 0.5
@export var pushbox_top_left: Vector2 = Vector2(-12, -7)
@export var pushbox_bottom_right: Vector2 = Vector2(12, 7)
@export var speedup_zone_top_left: Vector2 = Vector2(-6, -3)
@export var speedup_zone_bottom_right: Vector2 = Vector2(6, 3)

func _ready() -> void:
	position = target.global_position
	super()

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var move_x = 0.0
	var move_z = 0.0
	
	if target.global_position.x < global_position.x + pushbox_top_left.x - 5.0 or target.global_position.x > global_position.x + pushbox_bottom_right.x + 5.0 or target.global_position.z < global_position.z + pushbox_top_left.y - 5.0 or target.global_position.z > global_position.z + pushbox_bottom_right.y + 5.0:
		global_position.x = target.global_position.x
		global_position.z = target.global_position.z
		
	if target.global_position.x > global_position.x + speedup_zone_top_left.x and target.global_position.x < global_position.x + speedup_zone_bottom_right.x and target.global_position.z > global_position.z + speedup_zone_top_left.y and target.global_position.z < global_position.z + speedup_zone_bottom_right.y:
		return
		
	if target.global_position.x < global_position.x + pushbox_top_left.x or target.global_position.x > global_position.x + pushbox_bottom_right.x:
		move_x = target.velocity.x
	else:
		move_x = target.velocity.x * push_ratio
		
	if target.global_position.z < global_position.z + pushbox_top_left.y or target.global_position.z > global_position.z + pushbox_bottom_right.y:
		move_z = target.velocity.z
	else:
		move_z = target.velocity.z * push_ratio
	
	global_position.x += move_x * delta
	global_position.z += move_z * delta
	

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_top_left.y))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_top_left.y))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_top_left.y))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_top_left.y))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)

	await get_tree().process_frame
	mesh_instance.queue_free()
