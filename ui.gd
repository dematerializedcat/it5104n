extends CanvasLayer

var time_passed = 0

@onready var timer_label = $Label

func _process(delta):
	time_passed += delta
	timer_label.text = "Score: " + str(int(time_passed))
