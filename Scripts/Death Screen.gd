class_name DeathScreen
extends Panel


@onready var player = $".."
@onready var cam = $"../SpringArm3D"


static var instance:DeathScreen
static var specialdeath := false


var open := false


static func respawn():
	if is_instance_valid(instance):
		instance._on_button_pressed()


func _ready():
	instance = self
	hide()


func _process(_delta):
	if player.isDead and !open:
		open = true
		Player.instance.die.play()
		EMU.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if specialdeath:
			specialdeath = false
		else:
			show()


func _on_button_pressed():
	open = false
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


func _on_visibility_changed() -> void:
	if is_inside_tree():
		if is_visible_in_tree():
			$Button.grab_focus()
		else:
			$Button.release_focus()
