extends Area3D


enum mode {
	PLATFORM,
	SWITCH
}


@export var type:mode = mode.PLATFORM 




func _on_body_entered(body):
	if body is Player:
		if type == mode.PLATFORM:
			Player.instance.platform.play()
		else:
			Player.instance.findswitch.play()
