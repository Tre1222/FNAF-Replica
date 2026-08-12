extends Control

@onready var settings_button = $"../settings_button"

func _ready():
	settings_button.connect("delete_scene", Callable(self, "queue_free"))
	