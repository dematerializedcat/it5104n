extends CharacterBody3D

const SPEED = 5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):

	var input_dir = Vector3.ZERO
	
	if Input.is_action_pressed("fwd"):
		input_dir.z -= 1
	if Input.is_action_pressed("back"):
		input_dir.z += 1
	if Input.is_action_pressed("left"):
		input_dir.x -= 1
	if Input.is_action_pressed("right"):
		input_dir.x += 1
	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y += 8
	
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	velocity.x = input_dir.x * SPEED
	velocity.z = input_dir.z * SPEED

	move_and_slide()
