extends Area3D


func _on_body_entered(body):
	if body is Player:
		Player.rizz = true
		$"../AudioStreamPlayer3D".play()
		$"../AnimationPlayer2".play("collect")
		queue_free()
