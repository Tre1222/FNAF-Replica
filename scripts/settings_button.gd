extends TextureButton

func _ready():
    print("Settings Button script is ready!")
    Global.settings_open = false


const SETTINGS_SCENE = preload("res://scenes/settings.tscn")
signal delete_scene



func _pressed():
    if Global.settings_open:
        Global.settings_open = false
        emit_signal("delete_scene")
    else:
        Global.settings_open = true
        var settings = SETTINGS_SCENE.instantiate()
        add_sibling(settings)
        
