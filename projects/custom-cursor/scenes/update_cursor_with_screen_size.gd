extends Node2D

var cursor = preload("res://cursor/cursor.png")
var cursor_red = preload("res://cursor/cursor_red.png")

func _ready():
	Input.set_custom_mouse_cursor(cursor_red, 0, Vector2(16, 16))
	get_tree().connect("screen_resized", self, "on_screen_resized")

func on_screen_resized():
	if OS.get_window_size().y <= 600:
		Input.set_custom_mouse_cursor(cursor_red, 0, Vector2(16, 16))
	else:
		Input.set_custom_mouse_cursor(cursor, 0, Vector2(16, 16))
