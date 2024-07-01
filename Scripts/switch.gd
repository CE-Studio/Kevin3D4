extends StaticBody3D
class_name Switch


signal on_switch_activate


const SPIN_SPEED:float = 5.0


var stepArea:Area3D
var mesh:MeshInstance3D
var isActive:bool = false


func _ready():
	mesh = $"MeshInstance3D"
	stepArea = $"StepArea"


func _process(delta):
	if isActive:
		mesh.rotate_y(SPIN_SPEED * delta)


func _on_player_step(body):
	if body is Player && !isActive:
		isActive = true
		on_switch_activate.emit()
		$AudioStreamPlayer3D.play()
		print("Boing!")
