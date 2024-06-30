extends StaticBody3D
class_name Enemy

@onready var timer = $Timer
var health:int
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
			pass


func on_player_collision(body:Node3D): # This function is connected to StompArea's body_entered signal
	if body is Player:
		print(str(body.position.y - position.y) + ", " + str(body.velocity.y))
		if body.position.y > position.y + 0.75 and body.velocity.y <= 0: # Player is above and descending
			health -= 1
			body.velocity.y = body.JUMP_VELOCITY * 0.75
			print("Ouch!")
		else:
			print("I kill you now")
	if health <= 0:
		var h := AudioStreamPlayer3D.new()
		h.stream = preload("res://Assets/Sound Effects/aaaaaaaaaaaaaaaaaaaaa.mp3")
		h.finished.connect(h.queue_free)
		get_parent().add_child(h)
		h.play()
		timer.start()
	


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
