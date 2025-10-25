extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const ACCELERATION = 35
const DECELERATION = 25
var double_jump = 1


func _physics_process(delta: float) -> void:
	
	velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if not is_on_floor() and double_jump == 1:
			double_jump = 0
			velocity.y = JUMP_VELOCITY
		elif is_on_floor():
			double_jump = 1
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if direction > 0:
			velocity.x = move_toward(velocity.x, SPEED, ACCELERATION)
		elif direction < 0:
			velocity.x = move_toward(velocity.x, -SPEED, ACCELERATION)
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, DECELERATION)
		else:
			velocity.x = move_toward(velocity.x, 0, 1.1*DECELERATION)
	
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		$Body.play("run")
		$Body.flip_h = false
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		$Body.play("run")
		$Body.flip_h = true
	else:
		$Body.play("idle")
				
			
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			double_jump = 1
			velocity.y = JUMP_VELOCITY
	else: 
		if Input.is_action_just_pressed("ui_accept") and double_jump == 1:
				double_jump = 0
				velocity.y = JUMP_VELOCITY
		if velocity.y < 0:
			$Body.play("jump")
		else:
			$Body.play("fall")



	move_and_slide()
