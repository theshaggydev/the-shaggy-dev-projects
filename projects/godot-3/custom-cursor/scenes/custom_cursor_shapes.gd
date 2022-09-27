extends Control

var cursor = preload("res://cursor/cursor.png")
var cursor_ibeam = preload("res://cursor/cursor_ibeam.png")

func _ready():
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))
	Input.set_custom_mouse_cursor(cursor_ibeam, Input.CURSOR_IBEAM, Vector2(16, 16))
