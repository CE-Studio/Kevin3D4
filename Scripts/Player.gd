extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 15
const DIVE_VELOCITY = 10
var jumps = 0
var dives = 0
var direction2 = Vector3.ZERO
var isDiving:bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		jumps = 0
		dives = 0
		$MeshInstance3D.rotation_degrees = Vector3(0, 0, 0)
		isDiving = false

	# Handle jump and double jump
	if Input.is_action_just_pressed("ui_accept") and jumps < 2:
		velocity.y = JUMP_VELOCITY
		jumps += 1
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if isDiving:
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			direction2 = direction
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	
	elif direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		direction2 = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
	
	#dive
	if Input.is_action_just_pressed("Dive") and dives < 1:
		velocity.y = DIVE_VELOCITY 
		dives += 1
		$MeshInstance3D.rotate_x(-1)
		isDiving = true
	if isDiving:
		
		velocity.x = direction2.x * DIVE_VELOCITY
		velocity.z = direction2.z * DIVE_VELOCITY 
		if Input.is_action_just_pressed("ui_accept"):
			velocity.x = 0
			velocity.z = 0
			isDiving = false
	
	
		

	move_and_slide()



func _process(_delta):
	if Input.is_action_pressed("Camera"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	print(position.y)
func _input(event):	
	if Input.is_action_pressed("Camera") and (event is InputEventMouseMotion):
		rotate_y(event.relative.x/-180)
		$SpringArm3D.rotate_x(event.relative.y/-180)
