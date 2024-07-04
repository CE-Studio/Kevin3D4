extends Area3D
class_name winnerbox

static var loadBearingNumber = 0
const Levels = [
	"res://Scenes/Levels/level_1.tscn",
	"res://Scenes/Levels/level_template.tscn",
	"res://Scenes/Levels/factorylvl.tscn",
	"res://Scenes/Levels/level_template.tscn",
]

@export var WinZone:Shape3D
@onready var shape = $CollisionShape3D



# Called when the node enters the scene tree for the first time.
func _ready():
	shape.shape = WinZone


func _on_body_entered(body):
	if body is Player:
		loadBearingNumber += 1
		SpeedrunTimer.split()
		get_tree().change_scene_to_file.call_deferred(Levels[loadBearingNumber])
