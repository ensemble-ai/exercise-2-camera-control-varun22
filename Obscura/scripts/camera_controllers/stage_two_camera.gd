class_name StageTwoCamera
extends CameraControllerBase

@export var autoscroll_speed: Vector3 = Vector3(10.0, 0.0, 10.0)
@export var top_left: Vector2 = Vector2(-22.5, -12.5)
@export var bottom_right: Vector2 = Vector2(22.5 ,12.5)

var left_edge
var top_edge
var right_edge
var bottom_edge

func _ready() -> void:
	position += Vector3(target.global_position.x, dist_above_target, target.global_position.y)

func _process(delta: float) -> void:
	if draw_camera_logic:
		draw_logic()
	#
	#position.x += autoscroll_speed.x * delta
	#position.z += autoscroll_speed.z * delta
	#
	#left_edge = position.x + top_left.x
	#top_edge = position.z + top_left.y
	#bottom_edge = position.z + bottom_right.y
	#right_edge = position.x + bottom_right.x
	#
	#if target.global_position.x < left_edge:
		#target.global_position.x = left_edge
	#if target.global_position.z < top_edge:
		#target.global_position.z = top_edge
	#if target.global_position.x > right_edge:
		#target.global_position.x = right_edge
	#if target.global_position.z > bottom_edge:
		#target.global_position.z = bottom_edge
#
#func draw_logic() -> void:
	#var mesh_instance := MeshInstance3D.new()
	#var immediate_mesh := ImmediateMesh.new()
	#var material := ORMMaterial3D.new()
	#
	#mesh_instance.mesh = immediate_mesh
	#mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
#
	## Define frame coordinates based on top_left and bottom_right
	#var frame_left = position.x + top_left.x
	#var frame_right = position.x + bottom_right.x
	#var frame_top = position.z + top_left.y
	#var frame_bottom = position.z + bottom_right.y
	#var vessel_y = target.global_position.y  # Draw at the same y level as the Vessel
#
	## Begin drawing frame edges
	#immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	#
	## Top edge (left to right)
	#immediate_mesh.surface_add_vertex(Vector3(frame_left, vessel_y, frame_top))
	#immediate_mesh.surface_add_vertex(Vector3(frame_right, vessel_y, frame_top))
	#
	## Right edge (top to bottom)
	#immediate_mesh.surface_add_vertex(Vector3(frame_right, vessel_y, frame_top))
	#immediate_mesh.surface_add_vertex(Vector3(frame_right, vessel_y, frame_bottom))
	#
	## Bottom edge (right to left)
	#immediate_mesh.surface_add_vertex(Vector3(frame_right, vessel_y, frame_bottom))
	#immediate_mesh.surface_add_vertex(Vector3(frame_left, vessel_y, frame_bottom))
	#
	## Left edge (bottom to top)
	#immediate_mesh.surface_add_vertex(Vector3(frame_left, vessel_y, frame_bottom))
	#immediate_mesh.surface_add_vertex(Vector3(frame_left, vessel_y, frame_top))
	#
	#immediate_mesh.surface_end()
#
	## Set up material properties
	#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	#material.albedo_color = Color.WHITE
	#
	#add_child(mesh_instance)
	#mesh_instance.global_transform = Transform3D.IDENTITY
	#mesh_instance.global_position = Vector3(target.global_position.x, target.global_position.y, target.global_position.z)
	#
	## Queue free after one frame to avoid persistent mesh instances
	#await get_tree().process_frame
	#mesh_instance.queue_free()
