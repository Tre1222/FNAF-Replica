extends TextureButton

func _ready():
    print("Camera Arrow script is ready!")

func _on_timer_timeout() -> void:
    emit_signal("mouse_entered")
    emit_signal("mouse_entered")
