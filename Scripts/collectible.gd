extends Area3D


@onready var main = $"."
@onready var sprite = $Sprite3D
@onready var shape = $CollisionShape3D
@onready var noise = $AudioStreamPlayer3D


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
		if Player.instance.beandouble:
			Player.beanos += 2
		else:
			Player.beanos += 1
