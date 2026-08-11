extends MeshInstance3D

@onready var lightnode = get_node("SpotLight3D")
var enabled = false



func _ready() -> void:
	lightnode.visible = enabled



func _on_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, _normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		enabled = !enabled
		lightnode.visible = enabled
