extends RigidBody3D


func _on_body_entered(body):
	if body is Player:
		Player.instance.isDead = true
