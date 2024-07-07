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
	if anim_name == "rizz":
		$Control/winrizz.show()
	if anim_name == "speedrun":
		$Control/winspeed.show()
	if anim_name == "normal":
		$Control/winnormal.show()


func _on_normal_pressed():
	winnerbox.loadBearingNumber = 0
	Player.speedrunTime = 0
	Player.stanley = false
	Player.speedrunning = true
	Player._timerSpawned = false
	if is_instance_valid(SpeedrunTimer.instance):
		SpeedrunTimer.instance.queue_free()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().change_scene_to_file.call_deferred("res://Scenes/CutSceneMusicPiano1.tscn")


func _on_speed_pressed():
	winnerbox.loadBearingNumber = 0
	Player.speedrunTime = 0
	Player.stanley = false
	Player.speedrunning = false
	Player._timerSpawned = false
	if is_instance_valid(SpeedrunTimer.instance):
		SpeedrunTimer.instance.queue_free()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().change_scene_to_file.call_deferred("res://Scenes/CutSceneMusicPiano1.tscn")


func _on_rizz_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	winnerbox.loadBearingNumber = 0
	Player.speedrunTime = 0
	Player.stanley = false
	get_tree().change_scene_to_file.call_deferred("res://Scenes/title.tscn")
