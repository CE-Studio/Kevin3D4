extends Area3D

@onready var timer = $Timer
			
			


func _on_body_entered(body):
	if body is Player:
		Player.instance.SPEED = 0.0
		timer.start($AudioStreamPlayer.stream.get_length() + 1)	
		$AudioStreamPlayer.play()
		


func _on_timer_timeout():
	Player.instance.isDead = true
	Player.instance.SPEED = 10.0

