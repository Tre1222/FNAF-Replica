extends CanvasLayer






func _on_right_movement_mouse_entered() -> void:
	Global.right_movement = true


func _on_right_movement_mouse_exited() -> void:
	Global.right_movement = false


func _on_left_movement_mouse_entered() -> void:
	Global.left_movement = true


func _on_left_movement_mouse_exited() -> void:
	Global.left_movement = false
