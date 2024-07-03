
extends Node3D

@onready var sky = $WorldEnvironment.environment
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sky.sky_rotation.y += delta * .2
	pass
