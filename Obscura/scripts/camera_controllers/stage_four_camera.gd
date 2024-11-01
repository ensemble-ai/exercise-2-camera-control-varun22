class_name stage_four_camera
extends CameraControllerBase

@export var lead_speed: float = 20.0
@export var catchup_delay_duration: float = 0.2
@export var catchup_speed: float = 5.0
@export var leash_distance: float = 5.0

func _ready() -> void:
	position = target.global_position
	super()

func _process(delta: float) -> void:
	if !current:
		return

	if target.velocity.length() > 0.01:
		var target_position = target.global_position + (target.velocity.normalized() * leash_distance)
	
		if target.velocity.length() > 50:
			position = position.lerp(target_position, 40.0 * delta)
		else:
			position = position.lerp(target_position, lead_speed * delta)
	else:
		position = position.lerp(target.global_position, catchup_speed * delta)
		
	if draw_camera_logic:
		draw_logic()
		
	super(delta)
	
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(-5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(5, 0, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 5))
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	await get_tree().process_frame
	mesh_instance.queue_free()
