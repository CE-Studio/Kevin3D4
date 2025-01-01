extends Panel


func _ready():
	hide()
	_h.call_deferred()
	

func _h():
	EMU.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pauseUnpause()


var _tooktolong := false


func pauseUnpause():
	if get_tree().paused:
		get_tree().paused = false
		hide()
		$"../stnaleypause".hide()
		EMU.mouse_mode = Input.MOUSE_MODE_CAPTURED
		if _tooktolong:
			Player.instance.resume.play()
	else:
		get_tree().paused = true
		if Player.stanley:
			$"../stnaleypause".show()
		else:
			show()
		EMU.mouse_mode = Input.MOUSE_MODE_VISIBLE
		$"../Pausetimer".start(30)
		_tooktolong = false


func _on_again_pressed():
	pauseUnpause()
	winnerbox.loadBearingNumber = 0
	Player.speedrunTime = 0
	if DLC.active:
		Player.speedrunning = false
		get_tree().change_scene_to_file.call_deferred("res://Scenes/Cutscenes/the_kevin_parable.tscn")
	else:
		Player.stanley = false
		get_tree().change_scene_to_file.call_deferred("res://Scenes/CutSceneMusicPiano1.tscn")


func _on_set_pressed():
	$"../stnaleypause/TextureRect".show()


func _on_menu_pressed():
	pauseUnpause()
	EMU.mouse_mode = Input.MOUSE_MODE_VISIBLE
	winnerbox.loadBearingNumber = 0
	Player.speedrunTime = 0
	Player.stanley = false
	get_tree().change_scene_to_file.call_deferred("res://Scenes/title.tscn")


func _on_button_mouse_entered():
	$"../stanleysounds".play()


func _on_pausetimer_timeout():
	_tooktolong = true
