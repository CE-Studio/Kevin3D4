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


@onready var hoof := $Panel/Control/Sprite2D
@onready var idiotlabel := $Panel/Control/Label
@onready var hoofinit:Vector2 = $Panel/Control/Sprite2D.position
@onready var lblinit:Vector2 = $Panel/Control/Label.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if index == lsize - 2:
		hoof.position = Vector2(randf() * 30, randf() * 30) + hoofinit
		idiotlabel.position = Vector2(randf() * 30, randf() * 30) + lblinit
