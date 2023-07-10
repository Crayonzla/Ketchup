extends CharacterBody2D

const SPDs = 100
var SPD = 64
var action = 0
var jumpCount = 0
var isRunning = false

@export var jump_height : float = 32
@export var jump_time_to_peak : float = 0.5
@export var jump_time_to_descent : float = 0.4

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1

var motion = Vector2()

func _physics_process(delta):
	motion.y += getGravity() * delta
	if Input.is_action_just_pressed("Select") && jumpCount < 1:
		jump()
		action = 2
		jumpCount += 1
	if is_on_floor():
		jumpCount = 0
	
		
	movement()
	update_animation()
	set_velocity(motion)
	move_and_slide()
	set_up_direction(Vector2.UP)
	set_floor_stop_on_slope_enabled(true)
	set_max_slides(4)
	move_and_slide()
	motion = velocity

func update_animation():
	if action == 0:
		$AnimationPlayer.play("Idle")
	else:
		$AnimationPlayer.stop()

func movement():
	if Input.is_action_pressed("Left"):
		$Sprite2D.flip_h = true
		motion.x = -SPD
	elif Input.is_action_pressed("Right"):
		$Sprite2D.flip_h = false
		motion.x = SPD
	else:
		motion.x = 0
		action = 0;
	
	if Input.is_action_pressed("Special") && motion.x > 0:
		SPD == 900
	else:
		SPD == 64

func jump():
	motion.y = jump_velocity
	
func getGravity() -> float:
	return jump_gravity if motion.y < 0.0 else fall_gravity
	
func _on_visible_on_screen_notifier_2d_screen_exited():
		get_tree().change_scene_to_file("res://game_over.tscn")
