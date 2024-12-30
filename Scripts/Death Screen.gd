extends Panel


@onready var player = $".."
@onready var cam = $"../SpringArm3D"


func _ready():
	hide()


func _process(_delta):
	if player.isDead and !visible:
		Player.instance.die.play()
		show()
		EMU.mouse_mode = Input.MOUSE_MODE_VISIBLE
		cam.rotation += Vector3(0.01, 0.01, 0.01)


func _on_button_pressed():
	Player.beanos = 0
	player.respawn()
	cam.rotation = Vector3.ZERO
	EMU.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player.global_position = player.spawnpoint
	player.velocity = Vector3.ZERO
	player.animstate = player.anims.IDLE
	hide()
	Engine.time_scale = 1.0
	AudioServer.playback_speed_scale = 1.0
	player.isDead = false
	player.isTripleJump = 0
	player.beandouble = false
