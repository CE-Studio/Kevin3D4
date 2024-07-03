extends Node3D


@export var DEBUG_STARTHERE := false


func _ready():
	if DEBUG_STARTHERE:
		Player.instance.global_position = global_position


func _on_area_3d_body_entered(body):
	if body is Player:
		body.spawnpoint = global_position
