extends Area3D
class_name Bean

const SPEED = 40.0

@onready var sprite = $AnimatedSprite3D
@onready var timer = $Timer
@onready var ray = $RayCast3D


func _ready():
	timer.start()


func _process(delta):
	position += transform.basis * Vector3(0, 0,-SPEED) * delta


func _on_timer_timeout():
	queue_free()
