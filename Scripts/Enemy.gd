extends Area3D
class_name Enemy


@onready var timer:Timer = $Timer
@onready var model:Node3D = $enemy

var shoot := false

static var bullet = preload("res://Scenes/enemy_bullet.tscn")


var health:int:
	set(value):
		health = value
		_death()


func _ready():
	init(1)


func init(newHP:int):
	health = newHP


func _process(delta):
	if not $Timer.is_stopped():
			#$MeshInstance3D.mesh.material.set_shader_parameter("FloatParameter", 0.05/timer.time_left )
			$enemy/Armature/Skeleton3D/Vert.get_surface_override_material(0).set_shader_parameter("FloatParameter", 1/timer.time_left)
	model.look_at(Player.instance.global_position, Vector3.UP, true)
	if shoot:
		shoot = false
		var h:RigidBody3D = bullet.instantiate()
		$"../".add_child(h)
		h.global_position = global_position
		h.look_at(Player.instance.global_position, Vector3.UP, true)
		h.linear_velocity = ((h.global_transform.basis * Vector3.BACK) * 6)
		h.freeze = false
	model.rotation.x = 0


func on_stomp(body:Node3D): # This function is connected to StompArea's body_entered signal
	if body is Player:
		health -= 1
		body.velocity.y = body.JUMP_VELOCITY * 0.75


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
	if body is Player:
		Player.instance.isDead = true
	elif body is Bean:
		health -=1
			

func _shoot():
	shoot = true
	$Timer2.start(randf_range(4, 6))
