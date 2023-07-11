extends StaticBody2D

var starting_position = Vector2()

func _ready():
	global_position = starting_position

func _process(delta):
	
	move_and_slide()
