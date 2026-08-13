extends VBoxContainer

@onready var candle_volume_slider = get_node("first_row/candle_margin/candle_volume_container/candle_volume_slider")
@onready var music_volume_slider = get_node("first_row/music_margin/music_volume_container/music_volume_slider")
func _ready():
    candle_volume_slider.value = Global.candle_volume
    music_volume_slider.value = Global.music_volume


func _on_candle_volume_slider_value_changed(value: float) -> void:
    Global.candle_volume = value
    print("Candle Volume: " + str(value))




func _on_music_volume_slider_value_changed(value: float) -> void:
    Global.music_volume = value
    print("Music Volume: " + str(value))



