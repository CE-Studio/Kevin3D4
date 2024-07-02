extends AnimatableBody3D


@onready var anim:AnimationPlayer = $"AnimationPlayer"


func on_trigger():
	anim.speed_scale = 1
