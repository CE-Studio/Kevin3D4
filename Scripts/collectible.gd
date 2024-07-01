extends Area3D
class_name Bean



@onready var sprite = $Sprite3D
@onready var shape = $CollisionShape3D
@onready var noise = $AudioStreamPlayer3D
var isCollectible := true

# Called when the node enters the scene tree for the first time.
func _ready():
	isCollectible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isCollectible == false:
		sprite.visible = false
		shape.disabled = true
	else:
		sprite.visible = true
		shape.disabled = false
		



func on_player_touch(body):
	if body is Player:
		noise.play()
		isCollectible = false
		Player.beanos += 1
		
