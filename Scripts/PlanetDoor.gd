extends AnimatableBody3D


func on_activate():
	$"AnimationPlayer".speed_scale = 1
	$"AudioStreamPlayer3D".play()
