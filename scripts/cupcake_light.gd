extends OmniLight3D



@export var base_energy = 1.5
@export var flicker_speed = 0.05
@export var energy_deviation = 0.4
@export var range_deviation = 0.3

@export var target_positon = Vector3.ZERO
@export var x_deviation = 0.2
@export var y_deviation = 0.2
var target_energy = base_energy
var target_range = 5.0
var base_range = 5.0
var time_passed = 0.0

func _ready() -> void:
    base_energy = omni_range

func _process(delta) -> void:
    time_passed += delta
    if time_passed >= flicker_speed:
        target_energy = base_energy + randf_range(-energy_deviation, energy_deviation)
        target_range = base_range + randf_range(-range_deviation, range_deviation)
        target_positon = position + Vector3(randf_range(-x_deviation, x_deviation), randf_range(-y_deviation, y_deviation), 0)
        time_passed = 0.0

    light_energy = lerp(light_energy, target_energy, delta * 15.0)
    omni_range = lerp(omni_range, target_range, delta * 15.0)