extends Node3D


var _a := false


func _on_area_3d_body_entered(body):
	if body is Player:
		Player.stanley = true


func _on_area_3d_body_exited(body):
	if body is Player:
		Player.stanley = false


func _on_area_3d_2_body_entered(body):
	if body is Player:
		if !_a:
			_a = true
			$AnimationPlayer.play("new_animation")
