extends Sprite3D


const lines := [
	"Whaaaaaat?",
	"...What is it?",
	"What do you want?",
	"I'm working!",
	"Kevin!",
	"Leave me alone, I'm trying to work!",
	"Kevin...",
	"Stop.",
	"Stop...",
	"Stop it!",
	"KEVIN! LEAVE ME ALONE!",
	"YOU'RE A FUCKING IDIOT, KEVIN!",
	"...",
]
var lsize = lines.size()
var index:int = 0
var speaking := false


@onready var hoof:Sprite2D = $Panel/Control/Sprite2D
@onready var idiotlabel:Label = $Panel/Control/Label
@onready var idiotpanel:Panel = $Panel
@onready var lbl:Label = $Label
@onready var hoofinit:Vector2 = $Panel/Control/Sprite2D.position
@onready var lblinit:Vector2 = $Panel/Control/Label.position
@onready var audio:AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var origangle := rotation.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if idiotpanel.visible:
		hoof.position = Vector2(randf() * 30, randf() * 30) + hoofinit
		idiotlabel.position = Vector2(randf() * 30, randf() * 30) + lblinit
	if speaking:
		rotation.y = lerp_angle(rotation.y, PI + Vector2(global_position.z, global_position.x).angle_to_point(Vector2(Player.instance.global_position.z, Player.instance.global_position.x)), delta * 8)
	else:
		rotation.y = lerp_angle(rotation.y, origangle, delta * 8)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		speaking = true
		audio.play()
		lbl.text = lines[index]
		if index != lsize - 2:
			lbl.show()
		else:
			idiotpanel.show()
		if index < lsize - 1:
			index += 1


func _on_area_3d_body_exited(body: Node3D) -> void:
	speaking = false
	if body is Player:
		lbl.hide()
		idiotpanel.hide()
