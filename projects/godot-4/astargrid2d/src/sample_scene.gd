extends Node2D

@onready var game_map = $game_map
@onready var path = $path
@onready var start = $start
@onready var goal = $goal
@onready var ui = $ui

var astar_grid: AStarGrid2D
var start_cell: Vector2i
var end_cell: Vector2i

func _ready() -> void:
	ui.connect('options_updated', _on_options_updated)
	_init_grid()
	_update_grid_from_tilemap()
	find_path()

func _on_layout_updated() -> void:
	_update_grid_from_tilemap()
	find_path()

func _on_options_updated(heuristic: int, diagonal: int, jump: bool) -> void:
	astar_grid.default_compute_heuristic = heuristic
	astar_grid.default_estimate_heuristic = heuristic
	astar_grid.diagonal_mode = diagonal
	astar_grid.jumping_enabled = jump
	
	find_path()

func _on_marker_positions_updated() -> void:
	var new_start_cell = game_map.local_to_map(start.position)
	var new_end_cell = game_map.local_to_map(goal.position)
	
	if new_start_cell != start_cell or new_end_cell != end_cell:
		find_path()

func _init_grid() -> void:
	astar_grid = AStarGrid2D.new()
	astar_grid.size = game_map.get_used_rect().size
	astar_grid.cell_size = game_map.tile_set.tile_size
	astar_grid.update()

func _update_grid_from_tilemap() -> void:
	for i in range(astar_grid.size.x):
		for j in range(astar_grid.size.y):
			var id = Vector2i(i, j)
			if game_map.get_cell_source_id(0, id) >= 0:
				var tile_type = game_map.get_cell_tile_data(0, id).get_custom_data('tile_type')
				astar_grid.set_point_solid(Vector2i(i, j), tile_type == 'wall')
			else:
				astar_grid.set_point_solid(Vector2i(i, j), true)

func find_path() -> void:
	path.clear()
	start_cell = game_map.local_to_map(start.position)
	end_cell = game_map.local_to_map(goal.position)
	
	if start_cell == end_cell or !astar_grid.is_in_boundsv(start_cell) or !astar_grid.is_in_boundsv(end_cell):
		return

	var id_path = astar_grid.get_id_path(start_cell, end_cell)
	for id in id_path:
		path.set_cell(0, id, 1, Vector2(0, 0))
