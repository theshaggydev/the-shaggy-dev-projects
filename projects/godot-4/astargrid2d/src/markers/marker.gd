extends Area2D

signal position_updated

var is_dragging := false
var is_mouse_over := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect('mouse_entered', _on_mouse_entered)
	connect('mouse_exited', _on_mouse_exited)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT:
		is_dragging = event.pressed and is_mouse_over
		if is_dragging:
			get_viewport().set_input_as_handled()
		return
	
	if event is InputEventMouseMotion and is_dragging:
		global_position = get_global_mouse_position()
		emit_signal('position_updated')

func _on_mouse_entered() -> void:
	is_mouse_over = true

func _on_mouse_exited() -> void:
	is_mouse_over = false
