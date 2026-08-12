extends TextureButton

func _ready():
    print("Camera Arrow script is ready!")
    Global.settings_toggled.connect(_on_timer_timeout)

func dissapear():
    visible = false

func appear():
    visible = true

func _on_Global_settings_toggled(settings_open: bool) -> void:
    if not settings_open:
        dissapear()
    else:
        appear()



func _on_timer_timeout() -> void:
    if Global.settings_open:
        return
    emit_signal("mouse_entered")
    emit_signal("mouse_entered")
