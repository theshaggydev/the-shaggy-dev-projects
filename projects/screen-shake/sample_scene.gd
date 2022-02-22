extends Node2D

# How quickly to move through the noise
export var NOISE_SHAKE_SPEED: float = 30.0
export var NOISE_SWAY_SPEED: float = 1.0
# Noise returns values in the range (-1, 1)
# So this is how much to multiply the returned value by
export var NOISE_SHAKE_STRENGTH: float = 60.0
export var NOISE_SWAY_STRENGTH: float = 10.0
# The starting range of possible offsets using random values
export var RANDOM_SHAKE_STRENGTH: float = 30.0
# Multiplier for lerping the shake strength to zero
export var SHAKE_DECAY_RATE: float = 3.0

enum ShakeType {
	Random,
	Noise,
	Sway
}

onready var camera = $camera
onready var random_shake = $ui/button_container/random_shake
onready var noise_shake = $ui/button_container/noise_shake
onready var noise_sway = $ui/button_container/noise_sway

onready var noise = OpenSimplexNoise.new()
# Used to keep track of where we are in the noise
# so that we can smoothly move through it
var noise_i: float = 0.0
onready var rand = RandomNumberGenerator.new()
var shake_type: int = ShakeType.Random
var shake_strength: float = 0.0

func _ready() -> void:
	rand.randomize()
	
	# Randomize the generated noise
	noise.seed = rand.randi()
	# Period affects how quickly the noise changes values
	noise.period = 2
	
	random_shake.connect("pressed", self, "apply_random_shake")
	noise_shake.connect("pressed", self, "apply_noise_shake")
	noise_sway.connect("pressed", self, "apply_noise_sway")
	
func apply_random_shake() -> void:
	shake_strength = RANDOM_SHAKE_STRENGTH
	shake_type = ShakeType.Random
	
func apply_noise_shake() -> void:
	shake_strength = NOISE_SHAKE_STRENGTH
	shake_type = ShakeType.Noise
	
func apply_noise_sway() -> void:
	shake_type = ShakeType.Sway
	
func _process(delta: float) -> void:
	# Fade out the intensity over time
	shake_strength = lerp(shake_strength, 0, SHAKE_DECAY_RATE * delta)
	
	var shake_offset: Vector2
	
	match shake_type:
		ShakeType.Random:
			shake_offset = get_random_offset()
		ShakeType.Noise:
			shake_offset = get_noise_offset(delta, NOISE_SHAKE_SPEED, shake_strength)
		ShakeType.Sway:
			shake_offset = get_noise_offset(delta, NOISE_SWAY_SPEED, NOISE_SWAY_STRENGTH)
	
	# Shake by adjusting camera.offset so we can move the camera around the level via it's position
	camera.offset = shake_offset

func get_noise_offset(delta: float, speed: float, strength: float) -> Vector2:
	noise_i += delta * speed
	# Set the x values of each call to 'get_noise_2d' to a different value
	# so that our x and y vectors will be reading from unrelated areas of noise
	return Vector2(
		noise.get_noise_2d(1, noise_i) * strength,
		noise.get_noise_2d(100, noise_i) * strength
	)

func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)
