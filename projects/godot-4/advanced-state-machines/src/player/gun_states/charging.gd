extends State

@export
var idle_state: State

@export
var charge_time := 1.0

var time_remaining := 0.0

func enter() -> void:
	super()
	time_remaining = charge_time

func process_frame(delta: float) -> State:
	if parent.velocity.x < 0:
		animations.flip_h = true
	elif parent.velocity.x > 0:
		animations.flip_h = false
	
	time_remaining -= delta
	if time_remaining <= 0.0:
		return idle_state
	
	return null
