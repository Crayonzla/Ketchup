extends CharacterBody2D

const speed = 1
const maxspeed = 60
const jump = -200
const gravity = 8
const acc = 1
const deacc = 1.2

var motion = Vector2()

func _physics_process(delta):
	left_movement()
	right_movement()
	_jump()
	_gravity()

func idle():
	if motion.x == 0 && motion.y == 0:
		$AnimationPlayer.play("Idle")

func left_movement():
	if Input.is_action_pressed("ui_left"):
		$Sprite2D.flip_h = true
		motion.x  = max(motion.x - acc, -maxspeed)
	elif motion.x < 0:
		motion.x = min(motion.x + deacc, 0)

func right_movement():
	if Input.is_action_pressed("ui_right"):
		$Sprite2D.flip_h = false
		motion.x  = min(motion.x + acc, maxspeed)
	elif motion.x > 0:
		motion.x = max(motion.x - deacc, 0)

	set_velocity(motion)
	move_and_slide()
	motion = velocity

func _jump():
	if Input.is_action_pressed("ui_up") && motion.y == 0:
		motion.y = min(motion.y - 1, jump)

func _gravity():
	motion.y += gravity

