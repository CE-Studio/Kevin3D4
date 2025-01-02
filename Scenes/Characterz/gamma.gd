extends Sprite3D


const app := "Gamma: "
const speed := 0.05
var talktime := 0.0
var line := ""
var index:int = 0
@onready var panel:MarginContainer = $MarginContainer2
@onready var label:Label = $MarginContainer2/PanelContainer/MarginContainer/Label
@onready var audio:AudioStreamPlayer3D = $AudioStreamPlayer
@onready var origangle := rotation.y
@export var talking := false


var lines:Array[String] = [
	"Oh, hi sweetie!",
	"Ohh, I should have eaten before shopping today...",
	"Where did I put my wallet...?",
	"Hmm... This isn't on my list... but I might as well.",
	"Ooh, that's a good deal!",
]


func _process(delta: float) -> void:
	if talking:
		if index < line.length():
			talktime += delta
			if talktime >= speed:
				talktime -= speed
				audio.play()
				label.text += line[index]
				index += 1
		if is_instance_valid(Player.instance):
			rotation.y = lerp_angle(rotation.y, PI + Vector2(global_position.z, global_position.x).angle_to_point(Vector2(Player.instance.global_position.z, Player.instance.global_position.x)), delta * 5)
			if global_position.distance_to(Player.instance.global_position) > 5:
				talking = false
				index = 0
				talktime = 0
				label.text = ""
				panel.hide()
	elif is_instance_valid(Player.instance):
		rotation.y = lerp_angle(rotation.y, origangle, delta)
		if global_position.distance_to(Player.instance.global_position) <= 3:
			talking = true
			line = app + lines.pick_random()
			panel.show()
	else:
		rotation.y = lerp_angle(rotation.y, origangle, delta)
