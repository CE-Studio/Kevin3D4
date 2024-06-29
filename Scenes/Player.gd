extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 15
const DIVE_VELOCITY = 70.0
var jumps = 0
var dives = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	
	
	#dive
	if Input.is_action_just_pressed("Dive") and dives < 1:
		velocity.y = DIVE_VELOCITY / 10
		velocity.x = DIVE_VELOCITY
		dives += 1
		$MeshInstance3D.rotate_x(-1)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		jumps = 0
		dives = 0
		$MeshInstance3D.rotation_degrees = Vector3(0, 0, 0)

	# Handle jump and double jump
	if Input.is_action_just_pressed("ui_accept") and jumps < 2:
		velocity.y = JUMP_VELOCITY
		jumps += 1
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
	#dive
	if Input.is_action_just_pressed("Dive") and dives < 1:
		velocity.y = DIVE_VELOCITY / 20
		if direction:
			velocity.x += direction.x * DIVE_VELOCITY
			velocity.z += direction.z * DIVE_VELOCITY 
		dives += 1
		$MeshInstance3D.rotate_x(-1)

	move_and_slide()



func _process(delta):
	if Input.is_action_pressed("Camera"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	print(position.y)
func _input(event):	
	if Input.is_action_pressed("Camera") and (event is InputEventMouseMotion):
		rotate_y(event.relative.x/-180)
		$SpringArm3D.rotate_x(event.relative.y/-180)
