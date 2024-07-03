extends Area3D


func _on_body_entered(body):
	if body is Player:
		$"../AnimationPlayer".play("fade")


func _on_body_exited(body):
	if body is Player:
		$"../AnimationPlayer".play_backwards("fade")
