extends AudioStreamPlayer


func _process(delta):
	if !playing:
		if !Player.speedrunning:
			play()
