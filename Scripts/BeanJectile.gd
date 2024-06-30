extends Node3D

const SPEED = 40.0

@onready var sprite = $AnimatedSprite3D
@onready var timer = $Timer
@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0, 0,-SPEED) * delta
	


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
