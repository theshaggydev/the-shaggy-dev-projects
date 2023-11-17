extends State

@export
var charging_state: State

# Since these states can't trigger a state change from an internal event,
# just track when animation is finished and exit the next frame
var is_complete := false

func enter() -> void:
	is_complete = false
	super()
	await animations.animation_finished
	is_complete = true

func process_frame(delta: float) -> State:
	if parent.velocity.x < 0:
		animations.flip_h = true
	elif parent.velocity.x > 0:
		animations.flip_h = false
	
	if is_complete:
		return charging_state
	return null
