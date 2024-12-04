extends CharacterBody2D

const ROTATION_SPEED = 1.0
const ACCEL = 2.0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity = Vector2.ZERO

	velocity += ACCEL * Input.get_action_strength("burn") * -transform.y
	print(velocity)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("roll_left", "roll_right")
	if direction:
		rotation += direction * ROTATION_SPEED * delta

	move_and_slide()
