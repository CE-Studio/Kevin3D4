extends Area3D


@export var open := false


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		open = true


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		open = false
