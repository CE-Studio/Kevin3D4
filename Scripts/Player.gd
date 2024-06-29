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
}
var animstate:anims = anims.IDLE


var jumps:int = 0
var dives:int = 0
var direction2 := Vector3.ZERO
var isDiving := false
var isDoubleJump := false
var isJumping := false
var sprint:int = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity:float = ProjectSettings.get_setting("physics/3d/default_gravity")


static var beanos:int = 0


@onready var djumpEffect:GPUParticles3D = $"Double Jump Effect"
@onready var sprintEffect:GPUParticles3D = $Sprint
@onready var diveEffect:GPUParticles3D = $Dive


func _ready():
	djumpEffect.one_shot = true
	djumpEffect.emitting = false
	sprintEffect.emitting = false
	diveEffect.one_shot = true
	diveEffect.emitting = false
	$player/Armature/Skeleton3D/Vert.set_surface_override_material(0, preload("res://Assets/Materials/kevin34.tres"))


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#sprinting
	if Input.is_action_pressed("Sprint"):
		sprint = 2
		sprintEffect.emitting = true
		animstate = anims.RUN
	elif not Input.is_action_pressed("Sprint"): 
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
		if input_dir == Vector2.ZERO:
			animstate = anims.IDLE

	# Handle jump and double jump
	if Input.is_action_just_pressed("ui_accept") and jumps < 2:
		velocity.y = JUMP_VELOCITY
		jumps += 1
		if jumps > 1:
			isDoubleJump = true
			djumpEffect.emitting = true
			isJumping = false
		else:
			isJumping = true
			print("jump")
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
	if Input.is_action_just_pressed("Dive") and dives < 1:
		velocity.y = DIVE_VELOCITY 
		dives += 1
		$player.rotate_x(-1)
		isDiving = true
		diveEffect.emitting = true
	
	
	if isDiving:
		velocity.x = direction2.x * DIVE_VELOCITY * sprint
		velocity.z = direction2.z * DIVE_VELOCITY * sprint
		animstate = anims.DIVE
		if Input.is_action_just_pressed("ui_accept"):
			velocity.x = 0
			velocity.z = 0
			isDiving = false
			
	
	if position.y < -100:
		position = Vector3.ZERO
		velocity = Vector3.ZERO
		animstate = anims.IDLE
	
	move_and_slide()


func _process(_delta):
	if Input.is_action_pressed("Camera"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _input(event):	
	if Input.is_action_pressed("Camera") and (event is InputEventMouseMotion):
		rotate_y(event.relative.x/-180)
		$SpringArm3D.rotate_x(event.relative.y/-180)
