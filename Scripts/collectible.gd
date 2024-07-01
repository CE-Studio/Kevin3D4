extends Area3D
class_name Bean
@onready var main = $"."
@onready var sprite = $Sprite3D
@onready var shape = $CollisionShape3D
@onready var noise = $AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.visible = true
	shape.disabled = false
	
func _respawn():
	sprite.visible = true
	shape.disabled = false
	main.monitoring = true


func on_player_touch(body):
	if body is Player:
		noise.play()
		sprite.set_deferred("visible", false)
		shape.set_deferred("disabled", true)
		Player.beanos += 1
		
