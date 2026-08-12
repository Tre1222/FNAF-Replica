extends MeshInstance3D



@onready var sound_player = get_node("AudioStreamPlayer3D")

func _on_static_body_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and not Global.cameras_open:
        sound_player.play()

