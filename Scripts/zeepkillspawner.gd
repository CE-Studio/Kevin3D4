extends Area3D
class_name ZKSpawner


@export var relative:Vector3 = Vector3(0, -10, 0)
@export var oneshot := true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_exited.connect(spawn)


func spawn(body):
	if body is Player:
		var zk = preload("res://Scenes/Characterz/zeepkiller.tscn").instantiate()
		get_parent().add_child(zk)
		zk.position = position + relative
		if oneshot:
			queue_free()
