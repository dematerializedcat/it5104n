extends CharacterBody2D

@export var speed := 450.0
@export var acceleration := 2000.0
@export var friction := 1800.0
@export var jump_velocity := -550.0
@export var gravity := 1500.0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity

	# Horizontal movement with acceleration
	var direction = Input.get_axis("left", "right")

	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.name == "Spikes":
			die()
	
func die():
	call_deferred("_reload_scene")

func _reload_scene():
	var tree = get_tree()
	if tree:
		tree.reload_current_scene()
