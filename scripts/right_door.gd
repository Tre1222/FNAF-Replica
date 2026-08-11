extends MeshInstance3D


func _ready() -> void:
    print("Right Door script is ready!")

func lower_right_door() -> void:
    var door_animation = get_node("DoorAnimation") as AnimationPlayer
    door_animation.play("LowerRightDoor")

