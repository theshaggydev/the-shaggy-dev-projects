extends Node2D

func _process(delta):
	$cursor.global_position = get_global_mouse_position()
