extends CharacterBody2D

const ROTATION_SPEED = 1.0
const ACCEL = 7.0
const FRICTION = 0.1
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ZOOM_INCREMENT = 0.01 * Vector2.ONE

@onready var fuel = Globals.fuel
@onready var roll_fuel_consump = Globals.roll_fuel_consump
@onready var burn_fuel_consump = Globals.burn_fuel_consump

var game_over = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION)

	if not game_over and fuel > 0:
		player_move(delta)
	else:
		$EngineSound.stop()
		$ExhaustParticles.emitting = false

	if Input.is_action_just_released("zoom_in"):
		$Camera2D.zoom += ZOOM_INCREMENT
	if Input.is_action_just_pressed("zoom_out") and $Camera2D.zoom > 2 * ZOOM_INCREMENT:
		$Camera2D.zoom -= ZOOM_INCREMENT

	move_and_slide()


func player_move(delta: float):
	var direction := Input.get_axis("roll_left", "roll_right")
	if direction:
		rotation += direction * ROTATION_SPEED * delta
		fuel -= roll_fuel_consump * delta

	velocity += ACCEL * Input.get_action_strength("burn") * -transform.y
	if Input.get_action_strength("burn") > 0:
		fuel -= burn_fuel_consump * delta
		if not $EngineSound.playing:
			$EngineSound.play()
		$ExhaustParticles.emitting = true
		#$Camera2D.add_trauma(0.020)
	else:
		$EngineSound.stop()
		$ExhaustParticles.emitting = false

func fail():
	$Camera2D.add_trauma(0.9)
	$ExplosionSound.play()
	$ExplosionAndSmoke.start()
	game_over = true

func _on_success_hitbox_body_entered(body: Node2D) -> void:
	if body is TileMapLayer and velocity.length() / Globals.tile_size.y <= 5.0:
		print("success")
		game_over = true
	elif body is TileMapLayer:
		fail()
		

func _on_fail_hitbox_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		fail()
