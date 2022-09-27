extends Node2D

enum State {
	Off,
	On
}

const CHARGE_RATE = 1
const MAX_CHARGE = 4
const MIN_CHARGE  = 1

var current_state = State.Off
var charge_amount = MIN_CHARGE

# To avoid hardcoding paths within our code
onready var activation_area = $activation_area
onready var animations = $animations

func _ready():
	activation_area.connect("body_entered", self, "_on_body_entered")
	activation_area.connect("body_exited", self, "_on_body_exited")
	
func _process(delta: float) -> void:
	match current_state:
		State.Off:
			pass
		State.On:
			_process_on_state(delta)

func _process_on_state(delta: float) -> void:
	# Not 100% accurate to the max value, but good enough for demonstration purposes
	# Just use the clamp function if you want a hard limit at the max charge amount
	if charge_amount < MAX_CHARGE:
		charge_amount += delta * CHARGE_RATE
		# speed_scale is a multiplier of the base frame rate
		# so increasing this value makes the light blink faster
		animations.speed_scale = charge_amount
	
func _change_state(new_state: int) -> void:
	current_state = new_state
	animations.speed_scale = 1
	
	match current_state:
		State.Off:
			animations.play('off')
		State.On:
			charge_amount = MIN_CHARGE
			animations.play('on')
	
func _on_body_entered(body: PhysicsBody2D) -> void:
	if body is Player:
		_change_state(State.On)

func _on_body_exited(body: PhysicsBody2D) -> void:
	if body is Player:
		_change_state(State.Off)
