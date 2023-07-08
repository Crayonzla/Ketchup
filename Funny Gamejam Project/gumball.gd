extends Area2D

const speed = 2

func _physics_process(delta):
	position.x += speed
	rotation += speed 

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(area):
	get_tree().change_scene_to_file("res://game_over.tscn")
