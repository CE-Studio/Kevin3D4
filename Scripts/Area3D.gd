extends Area3D


@export var Killzone:Shape3D
@onready var shape = $CollisionShape3D
func _ready():
	shape.shape = Killzone
	

func _on_body_entered(body):
	if body is Player:
		Player.instance.isDead = true

