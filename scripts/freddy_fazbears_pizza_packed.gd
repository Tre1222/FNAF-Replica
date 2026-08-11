extends Node3D
var left_door = null
var right_door = null
var left_door_button = null
var right_door_button = null
var left_door_light = null
var right_door_light = null

var left_door_open = true
var right_door_open = true

func _ready() -> void:
    print("Freddy Fazbear's Pizza Packed script is ready!")
    left_door = get_node("F1Door_Left")
    right_door = get_node("F1Door_Right")
    left_door_button = get_node("DoorPanel_Left/DoorButton_Left")
    right_door_button = get_node("DoorPanel_Right/DoorButton_Right")
    left_door_light = get_node("DoorPanel_Left/LightButton_Left")
    right_door_light = get_node("DoorPanel_Right/LightButton_Right")



func _on_left_button_thing_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
    if event is InputEventMouseButton and event.pressed:
        print("Left button pressed!", event)

func _on_light_button_thing_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
    if event is InputEventMouseButton and event.pressed:
        print("Right button pressed!", event)

