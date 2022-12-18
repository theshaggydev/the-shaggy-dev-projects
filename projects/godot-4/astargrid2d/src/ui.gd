extends CanvasLayer

signal options_updated(heuristic, diagonal, jump)

@onready var heuristic = $controls_container/controls/heuristic/options
@onready var diagonal = $controls_container/controls/diagonal/options
@onready var jump = $controls_container/controls/jump

func _on_options_changed() -> void:
	emit_signal('options_updated', heuristic.selected, diagonal.selected, jump.button_pressed)
