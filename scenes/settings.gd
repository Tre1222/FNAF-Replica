extends CanvasLayer

var settings_button;

func _ready():
	settings_button = get_parent()
	settings_button.connect("delete_scene", Callable(self, "queue_free"))
