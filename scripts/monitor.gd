extends AnimatedSprite2D


@onready var timer = get_node("Timer")

func _on_camera_arrow_ui_camera_arrow_toggled() -> void:
    if Global.cameras_open:
        timer.wait_time = 0.2333
        visible = true
        play("monitor_flip_up")
        timer.start()
    else:
        timer.wait_time = 0.2333
        visible = true
        play("monitor_flip_down")
        timer.start()

func _on_timer_timeout() -> void:
    visible = false