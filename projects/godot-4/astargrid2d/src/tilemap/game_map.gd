extends TileMap

signal layout_updated

var is_placing_wall := false
var is_dragging := false
var last_mouse_cell: Vector2i

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# LMB to place walls, RMB to remove
		is_placing_wall = event.button_index == MOUSE_BUTTON_MASK_LEFT
		is_dragging = event.pressed
		if is_dragging:
			last_mouse_cell = local_to_map(get_local_mouse_position())
			set_cell_to_drag_value(last_mouse_cell)
			layout_updated.emit()
		return
	
	if event is InputEventMouseMotion and is_dragging:
		var current_cell = local_to_map(get_local_mouse_position())
		
		var line = get_line(last_mouse_cell, current_cell)
		for point in line:
			set_cell_to_drag_value(point)

		if line.size() > 0:
			layout_updated.emit()
		last_mouse_cell = current_cell

func set_cell_to_drag_value(cell: Vector2i) -> void:
	var value = 0
	if !is_placing_wall:
		value = 1
	set_cell(0, cell, 0, Vector2i(value, 0))

func get_line(start: Vector2i, end: Vector2i) -> Array:
	var points = []
	
	var delta = end - start
	var n = max(abs(delta.x), abs(delta.y))
	
	for step in range(n):
		var t = step / n
		var lerp_point = Vector2(start).lerp(Vector2(end), t)
		var rounded_point = lerp_point.floor()
		points.append(rounded_point)

	points.append(end)
	return points
