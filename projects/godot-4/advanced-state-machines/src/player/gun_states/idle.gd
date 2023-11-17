extends State

@export
var firing_state: State

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('fire'):
		return firing_state
	return null

func process_frame(delta: float) -> State:
	if parent.velocity.x < 0:
		animations.flip_h = true
	elif parent.velocity.x > 0:
		animations.flip_h = false
	return null
