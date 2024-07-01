extends Area3D
class_name Enemy


@onready var timer = $Timer


var health:int:
	set(value):
		health = value
		_death()
var mainHit:CollisionShape3D  # The main hitbox that hurts the player
var stompHit:Area3D # The secondary hitbox that the player can hit to deal damage


func _ready():
	mainHit = $"MainHitbox"
	stompHit = $"StompArea"
	init(1)


func init(newHP:int):
	health = newHP


func _process(delta):
	if not $Timer.is_stopped():
			#$MeshInstance3D.mesh.material.set_shader_parameter("FloatParameter", 0.05/timer.time_left )
			$enemy/Armature/Skeleton3D/Vert.get_surface_override_material(0).set_shader_parameter("FloatParameter", 0.05/timer.time_left)


func on_player_collision(body:Node3D): # This function is connected to StompArea's body_entered signal
	if body is Player:
		print(str(body.position.y - position.y) + ", " + str(body.velocity.y))
		if body.position.y > position.y + 0.75 and body.velocity.y <= 0: # Player is above and descending
			health -= 1
			body.velocity.y = body.JUMP_VELOCITY * 0.75
			print("Ouch!")
		else:
			print("I kill you now")
			Player.instance.isDead = true


func _death():
	if health <= 0:
		var h := AudioStreamPlayer3D.new()
		h.stream = preload("res://Assets/Sound Effects/aaaaaaaaaaaaaaaaaaaaa.mp3")
		h.finished.connect(h.queue_free)
		get_parent().add_child(h)
		h.play()
		timer.start()


func _on_timer_timeout():
	queue_free()


func _on_area_entered(area):
	if area is Bean:
		health -=1


func _on_body_entered(body):
	print("ouchie")
	if body is Bean:
		health -=1
