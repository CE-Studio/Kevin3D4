extends Area3D
class_name winnerbox

static var loadBearingNumber = 0
const Levels = [
	"res://Scenes/Levels/level_1.tscn",
	"res://Scenes/Cutscenes/L1_end_cutscene.tscn",
	"res://Scenes/Cutscenes/Rap.tscn",
	"res://Scenes/Levels/TechnoWizardry.tscn",
	"res://Scenes/finalecutscenemusic.tscn",
]

@export var WinZone:Shape3D
@onready var shape = $CollisionShape3D



# Called when the node enters the scene tree for the first time.
func _ready():
	shape.shape = WinZone


func _on_body_entered(body):
	if body is Player:
		Engine.time_scale = 1
		AudioServer.playback_speed_scale = 1
		loadBearingNumber += 1
		SpeedrunTimer.split()
		get_tree().change_scene_to_file.call_deferred(Levels[loadBearingNumber])
