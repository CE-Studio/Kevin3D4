extends Area3D

var isListend := false
@onready var camera = $Camera3D
@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite3D.show()
	
	pass # Replace with function body.
func _process(delta):
	$Sprite3D2.rotation.z += 2 * delta
	#poggies

func _on_body_entered(body):
	
	if body is Player:
		timer.wait_time = $AudioStreamPlayer.stream.get_length() + 1
		body.spawnpoint = global_position + Vector3(0,5,0)
		if isListend == false:
			timer.start()
			Player.instance.hide()
			Player.instance.SPEED = 0.0
			Player.instance.cam.current = false
			camera.current = true
			$AudioStreamPlayer.play()
			isListend = true
			$Sprite3D.hide()


func _on_timer_timeout():
	Player.instance.show()
	Player.instance.SPEED = 10.0
	Player.instance.cam.current = true
	camera.current = false
