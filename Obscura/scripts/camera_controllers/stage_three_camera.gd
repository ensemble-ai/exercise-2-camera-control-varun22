class_name stage_three_camera
extends CameraControllerBase

func _ready() -> void:
	position += Vector3(0.0, dist_above_target, 0.0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
@export var follow_speed: float = 10.0
@export var catchup_speed: float = 15.0
@export var leash_distance: float = 50.0

func _process(_delta: float) -> void:
	var distance_to_target: float = global_position.distance_to(target.global_position)

	var speed: float = follow_speed if target.velocity.length() > 0 else catchup_speed

	if distance_to_target > leash_distance:
		global_position.x = target.global_position.x
		global_position.z = target.global_position.z
	elif target.velocity == Vector3.ZERO:
		global_position.x = lerp(global_position.x, target.global_position.x, speed * _delta / distance_to_target)
		global_position.z = lerp(global_position.z, target.global_position.z, speed * _delta / distance_to_target)

	#if draw_camera_logic:
		#draw_logic()
		#
#func draw_logic() -> void:
	#var mesh_instance := MeshInstance3D.new()
	#var immediate_mesh := ImmediateMesh.new()
	#var material := ORMMaterial3D.new()
	#
	#mesh_instance.mesh = immediate_mesh
	#mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	#
	#var _size: float = 5
	#var left: float = -_size
	#var right: float = _size
	#var top: float = -_size
	#var bottom: float = _size
	#
	#immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	#immediate_mesh.surface_add_vertex(Vector3(left, 0, 0))
	#immediate_mesh.surface_add_vertex(Vector3(right, 0, 0))
	#
	#immediate_mesh.surface_add_vertex(Vector3(0, 0, top))
	#immediate_mesh.surface_add_vertex(Vector3(0, 0, bottom))
	#immediate_mesh.surface_end()
	#
	#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	#material.albedo_color = Color.WHITE
	#
	#add_child(mesh_instance)
	#mesh_instance.global_transform = Transform3D.IDENTITY
	#mesh_instance.global_position = Vector3(target.global_position.x, target.global_position.y, target.global_position.z)
	#
	##mesh is freed after one update of _process
	#await get_tree().process_frame
	#mesh_instance.queue_free()
