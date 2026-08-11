extends CanvasLayer

var lobby_camera_button = null
var left_door_cam_button = null
var right_door_cam_button = null
var left_hallway_cam_button = null
var right_hallway_cam_button = null
var janitor_cam_button = null
var foxy_cam_button = null
var parts_cam_button = null
var stage_cam_button = null
var bathroom_cam_button = null
var kitchen_cam_button = null
var cam_map = null

func _ready():
	lobby_camera_button = get_node("cam_map/lobby_camera_button")
	left_hallway_cam_button = get_node("cam_map/left_hallway_cam_button")
	left_door_cam_button = get_node("cam_map/left_door_cam_button")
	right_door_cam_button = get_node("cam_map/right_door_cam_button")
	left_hallway_cam_button = get_node("cam_map/left_hallway_cam_button")
	right_hallway_cam_button = get_node("cam_map/right_hallway_cam_button")
	janitor_cam_button = get_node("cam_map/janitor_cam_button")
	foxy_cam_button = get_node("cam_map/foxy_cam_button")
	parts_cam_button = get_node("cam_map/parts_cam_button")
	stage_cam_button = get_node("cam_map/stage_cam_button")
	bathroom_cam_button = get_node("cam_map/bathroom_cam_button")
	kitchen_cam_button = get_node("cam_map/kitchen_cam_button")
	cam_map = get_node("cam_map")
	
	



func _on_camera_arrow_ui_camera_arrow_toggled() -> void:
	if Global.cameras_open:
		cam_map.visible = true
		lobby_camera_button.disabled = false
		left_hallway_cam_button.disabled = false
		left_door_cam_button.disabled = false
		right_door_cam_button.disabled = false
		left_hallway_cam_button.disabled = false
		right_hallway_cam_button.disabled = false
		janitor_cam_button.disabled = false
		foxy_cam_button.disabled = false
		parts_cam_button.disabled = false
		stage_cam_button.disabled = false
		bathroom_cam_button.disabled = false
		kitchen_cam_button.disabled = false
		print("Buttons enabled")
	else:
		cam_map.visible = false
		lobby_camera_button.disabled = true
		left_hallway_cam_button.disabled = true
		left_door_cam_button.disabled = true
		right_door_cam_button.disabled = true
		left_hallway_cam_button.disabled = true
		right_hallway_cam_button.disabled = true
		janitor_cam_button.disabled = true
		foxy_cam_button.disabled = true
		parts_cam_button.disabled = true
		stage_cam_button.disabled = true
		bathroom_cam_button.disabled = true
		kitchen_cam_button.disabled = true
		print("Buttons disabled")


func _on_lobby_camera_button_pressed() -> void:
	Global.current_camera = Global.dining_room_camera


func _on_stage_cam_button_pressed() -> void:
	Global.current_camera = Global.stage_camera


func _on_parts_cam_button_pressed() -> void:
	Global.current_camera = Global.parts_room_camera


func _on_foxy_cam_button_pressed() -> void:
	Global.current_camera = Global.foxy_camera


func _on_bathroom_cam_button_pressed() -> void:
	Global.current_camera = Global.bathroom_camera


func _on_kitchen_cam_button_pressed() -> void:
	print("cant do that!")


func _on_right_hallway_cam_button_pressed() -> void:
	Global.current_camera = Global.right_hallway_camera


func _on_right_door_cam_button_pressed() -> void:
	Global.current_camera = Global.right_door_camera


func _on_left_door_cam_button_pressed() -> void:
	Global.current_camera = Global.left_door_camera


func _on_left_hallway_cam_button_pressed() -> void:
	Global.current_camera = Global.left_hallway_camera


func _on_janitor_cam_button_pressed() -> void:
	Global.current_camera = Global.janitor_camera
