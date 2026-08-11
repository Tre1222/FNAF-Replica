extends CanvasLayer



func _process(_delta):
    if Global.cameras_open:
        visible = true
    else:
        visible = false