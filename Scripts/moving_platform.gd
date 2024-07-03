extends AnimatableBody3D
class_name MovingPlatform


@onready var anim:AnimationPlayer = $"AnimationPlayer"


func on_trigger():
	anim.speed_scale = 1
