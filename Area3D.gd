extends Area3D
class_name winnerbox

static var loadBearingNumber = 0
static var Levels = [
	preload("res://Scenes/Levels/level_1.tscn")
]

@export var WinZone:Shape3D
@onready var shape = $CollisionShape3D



# Called when the node enters the scene tree for the first time.
func _ready():
	shape.shape = WinZone


func _on_body_entered(body):
	if body is Player:
		loadBearingNumber +=0
		get_tree().change_scene_to_packed(Levels[loadBearingNumber])
