extends Area2D


var Gumball = preload("res://Level Assets/Enemies/gumball.tscn")

func _fire():
	var gumball = Gumball.instantiate()
	var main = get_tree().current_scene
	main.add_child(gumball)
	gumball.position = $Marker2D.global_position


func _on_timer_timeout():
	$AnimationPlayer.play("fire")
	
func _on_animation_player_animation_finished(anim_name):
	_fire()
