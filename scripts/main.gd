extends Node3D

var left_limit = deg_to_rad(-40.0)
var right_limit = deg_to_rad(40.0)
var up_limit = deg_to_rad(40.0)
var down_limit = deg_to_rad(-40.0)

var zoom_in_limit = 99.4
var zoom_out_limit = 50
var zoom_speed = 50

var rotation_speed = 1.5
var smooth_speed = 5.0
var target_rotation_y = 0.0
var target_rotation_x = 0.0
var deadzone = 0.15



func _ready():
	print("Main script is ready!")
	Global.office_camera = get_node("FreddyFazbearsPizza_Packed/office_camera")
	Global.right_door_camera = get_node("FreddyFazbearsPizza_Packed/right_door_camera")
	Global.left_door_camera = get_node("FreddyFazbearsPizza_Packed/left_door_camera")
	Global.left_hallway_camera = get_node("FreddyFazbearsPizza_Packed/left_hallway_camera")
	Global.right_hallway_camera = get_node("FreddyFazbearsPizza_Packed/right_hallway_camera")
	Global.janitor_camera = get_node("FreddyFazbearsPizza_Packed/janitor_camera")
	Global.dining_room_camera = get_node("FreddyFazbearsPizza_Packed/lobby_room_camera")
	Global.bathroom_camera = get_node("FreddyFazbearsPizza_Packed/bathroom_camera")
	Global.foxy_camera = get_node("FreddyFazbearsPizza_Packed/foxy_camera")
	Global.parts_room_camera = get_node("FreddyFazbearsPizza_Packed/parts_room_camera")
	Global.stage_camera = get_node("FreddyFazbearsPizza_Packed/stage_camera")
	Global.current_camera = Global.dining_room_camera

	if Global.office_camera:
		target_rotation_y = Global.office_camera.rotation.y
		target_rotation_x = Global.office_camera.rotation.x

func movement(delta):
	if Global.cameras_open:
		return

	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport().get_visible_rect().size
	
	var center_x = screen_size.x / 2.0
	var center_y = screen_size.y / 2.0
	
	var offset_x = (mouse_pos.x - center_x) / center_x
	var offset_y = (mouse_pos.y - center_y) / center_y

	if abs(offset_x) < deadzone:
		offset_x = 0.0
	else:
		offset_x = sign(offset_x) * ((abs(offset_x) - deadzone) / (1.0 - deadzone))

	if abs(offset_y) < deadzone:
		offset_y = 0.0
	else:
		offset_y = sign(offset_y) * ((abs(offset_y) - deadzone) / (1.0 - deadzone))

	if Input.is_action_just_pressed("zoom_in"):
		Global.office_camera.fov -= zoom_speed * delta

	if Input.is_action_just_pressed("zoom_out"):
		Global.office_camera.fov += zoom_speed * delta

	target_rotation_y -= offset_x * rotation_speed * delta
	target_rotation_x -= offset_y * rotation_speed * delta

	target_rotation_y = clamp(target_rotation_y, left_limit, right_limit)
	target_rotation_x = clamp(target_rotation_x, down_limit, up_limit)
	Global.office_camera.fov = clamp(Global.office_camera.fov, zoom_out_limit, zoom_in_limit)
	Global.office_camera.rotation.y = lerp_angle(Global.office_camera.rotation.y, target_rotation_y, smooth_speed * delta)
	Global.office_camera.rotation.x = lerp_angle(Global.office_camera.rotation.x, target_rotation_x, smooth_speed * delta)



func _process(delta):
	movement(delta)
	
	if Global.cameras_open:
		Global.current_camera.make_current()
	else:
		Global.office_camera.make_current()
