extends Area3D


func _on_body_entered(body):
	if body is Player:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		body.queue_free()
		$Camera3D.make_current()
		if Player.rizz:
			$AnimationPlayer.play("rizz")
		elif Player.speedran:
			$AnimationPlayer.play("speedrun")
		else:
			$AnimationPlayer.play("normal")


func _on_animation_player_animation_finished(anim_name):
	pass # Replace with function body.
