extends CharacterBody3D
class_name Player

const SPEED := 10.0
const JUMP_VELOCITY := 15.0
const DIVE_VELOCITY := 10.0


enum anims {
	IDLE = 0,
	WALK = 1,
	RUN = 2,
	JUMP = 3,
	DJUMP = 4,
	DIVE = 5,
	SHOOTIN = 6,
	DYIN = 7,
}
var animstate:anims = anims.IDLE


var jumps:int = 0
var dives:int = 0
var direction2 := Vector3.ZERO
var isDiving := false
var isDoubleJump := false
var isJumping := false
var sprint:float = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity:float = ProjectSettings.get_setting("physics/3d/default_gravity")
var beanjectile = load("res://Scenes/bean_jectile.tscn")
var lerp_speed = 0.1
var isLerping := false
var lerp_time: float = 1.0
var current_lerp_time: float = 0.0
static var beanos:int = 0:
	set(value):
		Player.instance._lbl.text = str(value)
		beanos = value
static var instance:Player
var target_position = Vector3(1,1, .5)
var start_position = Vector3.ZERO
var isDead := false
var bHop = 0
var isTripleJump = 0
var Invincibile := false
var InvNum = 0

@onready var djumpEffect:GPUParticles3D = $"Double Jump Effect"
@onready var sprintEffect:GPUParticles3D = $Sprint
@onready var diveEffect:GPUParticles3D = $Dive
@onready var cam = $SpringArm3D/Camera3D 
@onready var _lbl:Label = $UI/BeanCounter/Label
@onready var spawnpoint:Vector3 = position
@onready var timer = $Timer
@onready var invtime = $"UI/Invinble Timer"

func _ready():
	Player.instance = self
	djumpEffect.one_shot = true
	djumpEffect.emitting = false
	sprintEffect.emitting = false
	diveEffect.one_shot = true
	diveEffect.emitting = false
	start_position = cam.position
	timer.one_shot = true
	$player/Armature/Skeleton3D/Vert.set_surface_override_material(0, preload("res://Assets/Materials/kevin34.tres"))


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#sprinting
	if Input.is_action_pressed("Sprint") and not Input.is_action_pressed("Camera"):
		sprint = 1.7
		sprintEffect.emitting = true
		animstate = anims.RUN
	elif not Input.is_action_pressed("Sprint") and not Input.is_action_pressed("Camera") : 
		sprint = 1
		sprintEffect.emitting = false 
		animstate = anims.WALK
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		jumps = 0
		dives = 0
		$player.rotation_degrees = Vector3(0, 0, 0)
		isDiving = false
		isJumping = false
		isDoubleJump = false
		if input_dir == Vector2.ZERO and not Input.is_action_pressed("Camera"):
			animstate = anims.IDLE
	
	# Handle jump and double jump
	if Input.is_action_just_pressed("ui_accept") and jumps < (2 + isTripleJump):
		velocity.y = JUMP_VELOCITY
		jumps += 1
		bHop = 0
		if jumps > 1:
			isDoubleJump = true
			djumpEffect.emitting = true
			isJumping = false
		else:
			isJumping = true
	
	if isDoubleJump:
		animstate = anims.DJUMP	
	if isJumping:
		animstate = anims.JUMP	
	
	if direction:
		velocity.x = direction.x * SPEED * sprint
		velocity.z = direction.z * SPEED * sprint
		direction2 = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
		
	#dive
	if Input.is_action_just_pressed("Dive") and dives < 1 and not Input.is_action_pressed("Camera"):
		velocity.y = DIVE_VELOCITY
		dives += 1
		bHop +=1
		$player.rotate_x(-1)
		isDiving = true
		diveEffect.emitting = true
	
	if isDiving:
		velocity.x = direction2.x * DIVE_VELOCITY * sprint * (bHop/4 + 1)
		velocity.z = direction2.z * DIVE_VELOCITY * sprint * (bHop/4 + 1)
		animstate = anims.DIVE
		if Input.is_action_just_pressed("ui_accept"):
			velocity.x = 0
			velocity.z = 0
			isDiving = false
	
	if position.y < -100:
		isDead = true
	
	move_and_slide()


func _process(delta):
	
	if Invincibile:
		isDead = false
		if InvNum == 0:
			timer.start()
			InvNum += 1
		invtime.show()
		invtime.text = str(floor(timer.time_left))
	
	if isDead:
		Engine.time_scale = 0.4 
		animstate = anims.DYIN
	
	if Input.is_action_pressed("Camera"):
		animstate = anims.SHOOTIN
		$Aiming/CenterContainer/TextureRect.visible = true
		if Input.is_action_just_pressed("Shoot") and beanos > 0:
			var i = beanjectile.instantiate()
			i.position = $SpringArm3D/Camera3D.global_position
			i.transform.basis = $SpringArm3D/Camera3D.global_transform.basis
			beanos -= 1
			get_parent().add_child(i)
	else:
		$Aiming/CenterContainer/TextureRect.visible = false
	
	if $RayCast3D.is_colliding():
		$MeshInstance3D.visible = true
		$MeshInstance3D.global_position = $RayCast3D.get_collision_point() + Vector3(0,.01,0)
	else:
		$MeshInstance3D.visible = false


func _input(event):	
	if (event is InputEventMouseMotion):
		rotate_y(event.relative.x/-180)
		$SpringArm3D.rotate_x(event.relative.y/-180)
	if event.is_action_pressed("Camera"):
		$SpringArm3D/AnimationPlayer.play("Shoot")
		
	if event.is_action_released("Camera"):
		$SpringArm3D/AnimationPlayer.play("ComeBack")


func respawn():
	_notifyReset(get_tree().get_root())


func _notifyReset(obj:Node):
	if obj.has_method(&"_respawn"):
		obj._respawn()
	for i in obj.get_children():
		_notifyReset(i)
		



func _on_timer_timeout():
	InvNum = 0
	Invincibile = false
	invtime.hide()
