extends Control

# Preload our cursor graphics so they're ready to go
const CURSOR = preload("res://cursor/cursor.png")
const LOADING_FRAMES = [
	preload("res://cursor/loading_1.png"),
	preload("res://cursor/loading_2.png"),
	preload("res://cursor/loading_3.png"),
	preload("res://cursor/loading_4.png"),
	preload("res://cursor/loading_5.png"),
	preload("res://cursor/loading_6.png"),
	preload("res://cursor/loading_7.png"),
	preload("res://cursor/loading_8.png")
]

export (float) var frames_per_second = 16.0
var current_frame = 0

func _ready():
	# Connect our signals and default to a cursor with no loading animation
	$trigger_button.connect("pressed", self, "begin_load")
	$animation_timer.connect("timeout", self, "update_frame")
	Input.set_custom_mouse_cursor(CURSOR, Input.CURSOR_ARROW, Vector2(64, 64))

func begin_load():
	# When the loading button is pressed, we start our animation timer
	# and go to the first frame of the loading animation
	$animation_timer.start(1.0 / frames_per_second)
	current_frame = 0
	Input.set_custom_mouse_cursor(LOADING_FRAMES[current_frame], Input.CURSOR_ARROW, Vector2(64, 64))

func update_frame():
	# If we have a cursor shape other than the default, don't try to override it
	if Input.get_current_cursor_shape() != Input.CURSOR_ARROW:
		return

	# Increment our loading animation, cycling through the array indefinitely
	current_frame += 1
	if current_frame >= LOADING_FRAMES.size():
		current_frame = 0
	Input.set_custom_mouse_cursor(LOADING_FRAMES[current_frame], Input.CURSOR_ARROW, Vector2(64, 64))
