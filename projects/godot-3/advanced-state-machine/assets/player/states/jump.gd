extends BaseState

export (float) var jump_force = 100
export (float) var move_speed = 60
export (NodePath) var fall_node
export (NodePath) var run_node
export (NodePath) var walk_node
export (NodePath) var idle_node

onready var fall_state: BaseState = get_node(fall_node)
onready var run_state: BaseState = get_node(run_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var idle_state: BaseState = get_node(idle_node)

func enter() -> void:
	# This calls the base class enter function, which is necessary here
	# to make sure the animation switches
	.enter()
	player.velocity.y = -jump_force

func physics_process(delta: float) -> BaseState:
	var move = 0
	if Input.is_action_pressed("move_left"):
		move = -1
		player.animations.flip_h = true
	elif Input.is_action_pressed("move_right"):
		move = 1
		player.animations.flip_h = false
	
	player.velocity.x = move * move_speed
	player.velocity.y += player.gravity
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if player.velocity.y > 0:
		return fall_state

	if player.is_on_floor():
		if move != 0:
			if Input.is_action_pressed("run"):
				return run_state
			return walk_state
		return idle_state
	return null
