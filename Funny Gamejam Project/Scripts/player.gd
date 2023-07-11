extends CharacterBody2D

const SPDs = 100
const acc = 5
const deacc = 1.5
const SPD = 64

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
	print(motion.x)
	jump(delta)
	movement()
	update_animation()
	
	set_velocity(motion)
	set_up_direction(Vector2.UP)
	set_floor_stop_on_slope_enabled(true)
	set_max_slides(4)
	move_and_slide()
	move_and_slide()
	motion = velocity

func movement():
#Left Movement
	if Input.is_action_pressed("Left"):
		$Sprite2D.flip_h = true
		motion.x = max(motion.x - acc, -SPD)
	elif motion.x < 0:
		motion.x = min(motion.x + deacc, 0)
		
#Right Movement
	elif Input.is_action_pressed("Right"):
		$Sprite2D.flip_h = false
		motion.x = min(motion.x + acc, SPD)
	elif motion.x > 0:
		motion.x = max(motion.x - deacc, 0)

	else:
		motion.x = 0
		action = 0;

func jump(delta):
	motion.y += getGravity() * delta
	if Input.is_action_just_pressed("Select") and jumpCount < 1:
		motion.y = jump_velocity
		action = 2
		jumpCount += 1
	if is_on_floor():
		jumpCount = 0

func update_animation():
	if action == 0:
		$AnimationPlayer.play("Idle")
	else:
		$AnimationPlayer.stop()

func getGravity() -> float:
	return jump_gravity if motion.y < 0.0 else fall_gravity
	
func _on_visible_on_screen_notifier_2d_screen_exited():
		get_tree().change_scene_to_file("res://Misc/game_over.tscn")
