extends AnimatableBody3D


func _ready():
	$Timer.one_shot = true
	$Timer2.one_shot = true


func _process(delta):
	if not $Timer.is_stopped():
		$MeshInstance3D.mesh.material.set_shader_parameter("FloatParameter", 0.1/$Timer.time_left )


func _on_area_3d_body_entered(body):
	if body is Player:
		$Ragdoll.playing = true
		$Timer.start()
	

func _on_timer_timeout():
	visible = false
	$CollisionShape3D.disabled = true
	$Ragdoll.playing = false
	$Timer2.start()


func _on_timer_2_timeout():
	$MeshInstance3D.mesh.material.set_shader_parameter("FloatParameter", 0)
	visible = true
	$CollisionShape3D.disabled = false
	pass # Replace with function body.
