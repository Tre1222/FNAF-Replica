extends CanvasLayer

signal camera_arrow_toggled()

@onready var camera_arrow = get_node("camera_arrow")



func _ready() -> void:
	print("Camera Arrow UI script is ready!")



func _on_camera_arrow_mouse_entered() -> void:
	Global.cameras_open = !Global.cameras_open
	print("Cameras Open" if Global.cameras_open else "Cameras Closed")
	camera_arrow.flip_v = !camera_arrow.flip_v
	emit_signal("camera_arrow_toggled")
