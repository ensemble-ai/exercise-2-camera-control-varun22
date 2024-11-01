class_name stage_three_camera
extends CameraControllerBase

@export var follow_speed: float = 50.0
@export var catchup_speed: float = 5.0
@export var leash_distance: float = 12.5
 
func _ready() -> void:
	position += Vector3(0.0, dist_above_target, 0.0)
	super()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
	
	var distance: float = global_position.distance_to(target.global_position)
	
	if target.velocity.length() == 0:
		position = position.lerp(target.global_position, catchup_speed * delta)
	
	else:
		if distance > leash_distance:
			var direction = (target.global_position - global_position).normalized()
			var target_position = target.global_position - (direction * leash_distance)
			
			global_position.x = lerp(global_position.x, target_position.x, follow_speed * delta)
			global_position.z = lerp(global_position.z, target_position.z, follow_speed * delta)
		else:
			global_position.x = lerp(global_position.x, target.global_position.x, follow_speed * delta / distance)
			global_position.z = lerp(global_position.z, target.global_position.z, follow_speed * delta / distance)
			
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
