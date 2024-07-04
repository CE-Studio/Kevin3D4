extends Area3D

@onready var shape = $CollisionShape3D
@onready var sprite = $Sprite3D
@onready var sound = $AudioStreamPlayer3D
func _on_body_entered(body):
	if body is Player:
		_h.call_deferred()
func _respawn():
	sprite.visible = true
	shape.disabled = false
		
		
func _h():
	Player.instance.Invincibile = true
	shape.disabled = true
	sprite.visible = false
	sound.play()
