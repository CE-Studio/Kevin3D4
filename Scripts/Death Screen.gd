extends Panel
@onready var player = $".."
@onready var cam = $"../SpringArm3D"
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player.isDead:
		show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		cam.rotation += Vector3(0.01, 0.01, 0.01)
		
	
		
	


func _on_button_pressed():
	Player.beanos = 0
	player.respawn()
	cam.rotation = Vector3.ZERO
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player.position = player.spawnpoint
	player.velocity = Vector3.ZERO
	player.animstate = player.anims.IDLE
	hide()
	Engine.time_scale = 1.0
	player.isDead = false

