extends StaticBody3D
class_name Switch


signal on_switch_activate


const SPIN_SPEED:float = -5.0


var stepArea:Area3D
#var mesh:MeshInstance3D
var mesh:Node3D
var anim:AnimationPlayer
var isActive:bool = false


func _ready():
	mesh = $"ModelStuffs"
	stepArea = $"StepArea"
	anim = $"ModelStuffs/AnimationPlayer"


func _process(delta):
	if isActive:
		mesh.rotate_y(SPIN_SPEED * delta)


func _on_player_step(body):
	if body is Player && !isActive:
		isActive = true
		on_switch_activate.emit()
		$AudioStreamPlayer3D.play()
		anim.play("Activated")
		print("Boing!")
