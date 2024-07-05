extends AnimatableBody3D
class_name MovingPlatform


@onready var anim:AnimationPlayer = $"AnimationPlayer"


func on_trigger():
	anim.speed_scale = 1
	$AudioStreamPlayer3D.play()


func _on_animation_player_animation_finished(_anim_name):
	$AudioStreamPlayer3D.stop()


func _on_area_3d_body_entered(body):
	if body is Player:
		Player.instance.moving.play()
