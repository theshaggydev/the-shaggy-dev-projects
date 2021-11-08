class_name Player
extends KinematicBody2D

var gravity = 4
var velocity = Vector2.ZERO

onready var animations = $animations
onready var states = $state_manager

func _ready() -> void:
	# Pass a reference of the player to the states, that way they can move
	# and react accordingly
	states.set_refs(self)
	# Initialize with a default state of idle
	states.change_state(BaseState.State.Idle)

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
