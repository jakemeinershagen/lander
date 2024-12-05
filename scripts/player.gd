extends CharacterBody2D

const ROTATION_SPEED = 1.0
const ACCEL = 7.0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ZOOM_INCREMENT = 0.01 * Vector2.ONE

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity = Vector2.ZERO

	velocity += ACCEL * Input.get_action_strength("burn") * -transform.y

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("roll_left", "roll_right")
	if direction:
		rotation += direction * ROTATION_SPEED * delta

	if Input.is_action_just_released("zoom_in"):
		$Camera2D.zoom += ZOOM_INCREMENT
	if Input.is_action_just_pressed("zoom_out") and $Camera2D.zoom > 2 * ZOOM_INCREMENT:
		$Camera2D.zoom -= ZOOM_INCREMENT

	move_and_slide()
