extends Node

const kev:PackedScene = preload("res://Scenes/Player.tscn")
@onready var fakekev:Node3D = $"../Player"
@onready var spinner:MeshInstance3D = $"../lanes/checkout2/chechout/Cube/Cube_001/Cylinder"
@onready var instruct:Node2D = $"../Node2D"
var fade := 0.0


func swappy() -> void:
	if is_instance_valid(fakekev):
		var newkev:Player = kev.instantiate()
		get_parent().add_child(newkev)
		newkev.global_position = fakekev.global_position
		newkev.global_rotation.y = fakekev.global_rotation.y
		fakekev.queue_free()
		Player.stanley = true


func _process(delta: float) -> void:
	if is_instance_valid(Player.instance):
		if Player.instance.global_position.distance_to(spinner.global_position) < 2:
			fade = move_toward(fade, 10, delta)
		else:
			fade = move_toward(fade, 0, delta)
		instruct.modulate.a = clampf((fade / 2.0) - 4, 0, 1)
		var p = Player.instance.cam.unproject_position(spinner.global_position)
		instruct.position = p
