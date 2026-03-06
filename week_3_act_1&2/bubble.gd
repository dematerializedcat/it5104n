extends Area2D

# Speed of the bubble
var speed = 400
var direction = Vector2.ZERO
var damage = 20

func _process(delta):
	position += direction * speed * delta
	# Optional: delete bubble if off-screen
	if position.x < 0 or position.x > 2000 or position.y < 0 or position.y > 2000:
		queue_free()

func _on_Bubble_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()  # destroy bubble on hit

func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
