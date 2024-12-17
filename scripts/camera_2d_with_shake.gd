# Implementation tutorial for this from KidsCanCode: https://kidscancode.org/godot_recipes/3.x/2d/screen_shake/index.html
extends Camera2D

@export var decay = 0.1
@export var max_offset = Vector2(75, 75)
@export var max_roll = 0.1

@onready var noise = FastNoiseLite.new()

var trauma = 0.0 #current shake strength
var trauma_power = 2 #exponent
var noise_y = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# this refreshes the seed for random gen. not strictly needed
	randomize()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.seed = randi()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if trauma:
		shake_rand()
	trauma = lerp(trauma, 0.0, decay)

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)
	
func shake_rand():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * randf_range(-1.0, 1.0)
	offset.x = max_offset.x * amount * randf_range(-1.0, 1.0)
	offset.y = max_offset.y * amount * randf_range(-1.0, 1.0)

func shake_noise():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed, noise_y)
