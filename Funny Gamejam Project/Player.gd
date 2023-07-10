extends CharacterBody2D

const speed = 1
const maxspeed = 60
const jumpmax = -100
const gravity = 325
const acc = 1
const jumpacc = 1
const deacc = 3.5
const jumpforce = 100

var motion = Vector2()

func _physics_process(delta):
	movement()
	_jump()
	_gravity(delta)
	update_animation()

func update_animation():
	if motion.x == 0:
		$AnimationPlayer.play("Idle")

func movement():
	if Input.is_action_pressed("ui_left"):
		$Sprite2D.flip_h = true
		motion.x  = max(motion.x - acc, -maxspeed)
	elif motion.x < 0 && is_on_floor():
		motion.x = min(motion.x + deacc, 0)
	if Input.is_action_pressed("ui_right"):
		$Sprite2D.flip_h = false
		motion.x  = min(motion.x + acc, maxspeed)
	elif motion.x > 0 && is_on_floor():
		motion.x = max(motion.x - deacc, 0)

	set_velocity(motion)
	move_and_slide()
	set_up_direction(Vector2.UP)
	set_floor_stop_on_slope_enabled(true)
	set_max_slides(4)
	move_and_slide()
	motion = velocity

func _jump():
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			var jumppressure = Input.get_action_strength("ui_up")
			motion.y += -jumpforce * jumppressure
			#motion.y = clamp(-motion.y, -jumpmax, jumpmax)
			print(motion.y)

func _gravity(delta):
	if not is_on_floor():
		motion.y += gravity * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited():
		get_tree().change_scene_to_file("res://game_over.tscn")
