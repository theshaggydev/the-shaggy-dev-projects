extends Node2D

var cursor = preload("res://cursor/cursor.png")

func _input(event):
	if event is InputEventMouseMotion:
		if get_global_mouse_position().x >= 512:
			Input.set_custom_mouse_cursor(null)
		else:
			Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))
