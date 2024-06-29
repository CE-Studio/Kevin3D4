extends StaticBody3D


var stepArea:Area3D
var mesh:MeshInstance3D
var isActive:bool = false


const spinSpeed:float = 5.0


signal on_switch_activate


func _ready():
	mesh = $"MeshInstance3D"
	stepArea = $"StepArea"


func _process(delta):
	if isActive:
		mesh.rotate_y(spinSpeed * delta)


func _on_player_step(body):
	if body is Player && !isActive:
		isActive = true
		on_switch_activate.emit()
		print("Boing!")
