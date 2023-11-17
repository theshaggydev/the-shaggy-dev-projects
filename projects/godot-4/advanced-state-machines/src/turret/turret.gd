extends Node2D

# What state the turret is in
enum TurretState {
	Scanning,
	Firing,
	Recharging
}

# How long to stay in the firing and recharge states
@export
var firing_time: float = 0.5
@export
var recharge_time: float = 2.0

# Grab a reference to the nodes we need
@onready
var animations = $animations 
@onready
var raycast = $raycast
@onready
var view_line = $view_line

# Set the default state
var current_state: TurretState = TurretState.Scanning
# This timer will count down to our next state change
var state_change_timer: float = 0.0

# Handles everything related to changing states
# You could also move each state's setup into a separate function if you had a lot to do.
func change_state(new_state: TurretState) -> void:
	current_state = new_state
	match current_state:
		TurretState.Scanning:
			animations.play('scanning')
			view_line.visible = true
		TurretState.Firing:
			# Firing just plays an animation and moves on for demo purposes.
			animations.play('firing')
			state_change_timer = firing_time
			view_line.visible = false
		TurretState.Recharging:
			animations.play('recharging')
			state_change_timer = recharge_time
			view_line.visible = false

# Since we're dealing with a physics check on raycasting,
# scanning updates should happen during the physics update.
func _physics_process(delta: float) -> void:
	if current_state != TurretState.Scanning:
		return
	# Fire when the Player intersects the raycast.
	# Note this check requires that Player is a registered class_name
	# This is declared at the top of the player's script, which we'll see in a bit.
	var collider = raycast.get_collider()
	if collider and collider is Player:
		change_state(TurretState.Firing)

# Count down the timers and transition states when appropriate
func _process(delta: float) -> void:
	match current_state:
		TurretState.Firing:
			state_change_timer -= delta
			if state_change_timer <= 0.0:
				change_state(TurretState.Recharging)
		TurretState.Recharging:
			state_change_timer -= delta
			if state_change_timer <= 0.0:
				change_state(TurretState.Scanning)
