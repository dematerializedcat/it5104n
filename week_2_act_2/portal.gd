extends Node2D

@export var next_scene: PackedScene  # drag Level2.tscn here in Inspector

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("player"):
		call_deferred("_load_next_scene")

func _load_next_scene():
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
