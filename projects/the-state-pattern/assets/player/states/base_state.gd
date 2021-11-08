class_name BaseState
extends Node

# Don't get confused, this is not the same as on the switch example
# This enum is used so that each child state can reference each other for its return value
enum State {
	Null,
	Idle,
	Walk,
	Fall,
	Jump
}

export (String) var animation_name

# Due to cyclic dependencies, we can't type our player variable here
# So just remember that this is a reference to the entire player node
var player

func enter() -> void:
	player.animations.play(animation_name)

func exit() -> void:
	pass

# Enums are internally stored as ints, so that is the expected return type
func input(event: InputEvent) -> int:
	return State.Null

func process(delta: float) -> int:
	return State.Null

# Pass in a reference to the player's kinematic body so that it can be moved by the state
func physics_process(delta: float) -> int:
	return State.Null