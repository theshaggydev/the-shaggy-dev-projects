extends State

@export
var idle_state: State
@export
var move_state: State

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta

	var movement = get_movement_input() * move_speed
	
	if movement != 0:
		animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null
