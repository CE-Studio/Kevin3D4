extends Panel


func _ready():
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pauseUnpause()


func pauseUnpause():
	if get_tree().paused:
		get_tree().paused = false
		hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		get_tree().paused = true
		show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
