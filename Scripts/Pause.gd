extends Panel


func _ready():
	hide()
	_h.call_deferred()
	

func _h():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pauseUnpause()


func pauseUnpause():
	if get_tree().paused:
		get_tree().paused = false
		hide()
		$"../stnaleypause".hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		get_tree().paused = true
		if Player.stanley:
			$"../stnaleypause".show()
		else:
			show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_again_pressed():
	if !Player.dlc:
		pauseUnpause()
		winnerbox.loadBearingNumber = 0
		Player.speedrunTime = 0
		Player.stanley = false
		get_tree().change_scene_to_file.call_deferred("res://Scenes/CutSceneMusicPiano1.tscn")


func _on_set_pressed():
	$"../stnaleypause/TextureRect".show()


func _on_menu_pressed():
	pauseUnpause()
	winnerbox.loadBearingNumber = 0
	Player.speedrunTime = 0
	Player.stanley = false
	get_tree().change_scene_to_file.call_deferred("res://Scenes/title.tscn")
