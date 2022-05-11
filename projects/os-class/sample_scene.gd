extends MarginContainer

onready var monitor_size_label = $monitor_size

onready var height_spinbox = $display_container/window_size_container/height_spinbox
onready var width_spinbox = $display_container/window_size_container/width_spinbox
onready var x_spinbox = $display_container/window_position_container/x_spinbox
onready var y_spinbox = $display_container/window_position_container/y_spinbox

onready var clipboard_contents = $system_information/clipboard_contents
onready var clipboard_source = $system_information/clipboard_source

func _ready() -> void:
	monitor_size_label.text = 'Monitor size: %s\n(May be off on monitors with scaling)' % str(OS.get_screen_size())

func _on_fullscreen_toggled(button_pressed: bool) -> void:
	OS.window_fullscreen = button_pressed

func _on_vysnc_toggled(button_pressed: bool) -> void:
	OS.vsync_enabled = button_pressed

func _on_apply_window_size() -> void:
	OS.window_size = Vector2(width_spinbox.value, height_spinbox.value)

func _on_apply_window_position() -> void:
	OS.window_position = Vector2(x_spinbox.value, y_spinbox.value)

func _on_center_window_pressed() -> void:
	OS.center_window()

func _on_clipboard_button_pressed() -> void:
	clipboard_contents.text = OS.clipboard

func _on_copy_clipboard_pressed() -> void:
	OS.clipboard = clipboard_source.text
