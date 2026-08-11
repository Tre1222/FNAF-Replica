extends MeshInstance3D



@onready var audio_player = get_node("AudioStreamPlayer3D")
@onready var click_sound = get_node("click_sound")

@onready var turn_on_sound = load ("res://assets/audio/office/turn_on.mp3")
@onready var turn_off_sound = load ("res://assets/audio/office/turn_off.mp3")

var is_playing = false
func _on_static_body_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        
        if is_playing:
            click_sound.stream = turn_off_sound
            click_sound.play()

            audio_player.stop()
            is_playing = false
        else:
            
            click_sound.stream = turn_on_sound
            click_sound.play()
            is_playing = true
            audio_player.play()
