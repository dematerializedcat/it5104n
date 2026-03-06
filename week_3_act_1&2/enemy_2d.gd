extends CharacterBody2D

# Movement speed
var speed = 40

# Patrol boundaries (local to enemy start position)
var patrol_start = Vector2.ZERO
var patrol_end = Vector2(100, 0)

# State variables
var moving_right = true
var chasing = false

# Detection range for player
var detection_range = 50

# Reference to the player node (set this in _ready)
var player = null
var health = 100
@onready var health_bar = $ProgressBar

func _ready():
	patrol_start = position
	patrol_end = position + patrol_end
	player = get_parent().get_node("Player")  # adjust path as needed

func take_damage(amount):
	health -= amount
	health_bar.value = health
	
	if health <= 0:
		if player:
			player.score += 100  # increment score
			player.score_label.text = "Score: " + str(player.score)
			queue_free()

func _physics_process(delta):
	if player:
		var distance_to_player = position.distance_to(player.position)
		
		# Check if player is near
		if distance_to_player <= detection_range:
			chasing = true
		elif distance_to_player > detection_range and chasing:
			# Player left detection range; go back to patrol
			chasing = false
	
	if chasing:
		chase_player(delta)
	else:
		patrol(delta)

func patrol(delta):
	var target_pos = patrol_start
	if moving_right:
		target_pos = patrol_end
	var direction = (target_pos - position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	# Check if close to patrol point, then flip direction
	if position.distance_to(target_pos) < 5:
		moving_right = !moving_right

func chase_player(delta):
	var direction = (player.position - position).normalized()
	velocity = direction * speed * 1.2  # a bit faster chasing
	move_and_slide()
