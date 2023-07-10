extends Node2D

@onready var global = get_node("/root/Global")
@onready var AnimPlayer = $AnimationPlayer

func _ready():
	if global.lives <=0:
		global.lives = 0
	elif global.lives > 0:
		global.lives -= 1
	$Label.text = str(global.lives) + " Lives"
	AnimPlayer.play("Game Over")

func _process(delta):
	if Input.is_action_pressed("Select"):
		if global.world == 1:
			get_tree().change_scene_to_file("res://world.tscn")
