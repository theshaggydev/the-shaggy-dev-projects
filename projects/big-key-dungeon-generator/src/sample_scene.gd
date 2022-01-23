extends MarginContainer

var circle_size = 28
var circle_spacing = 70
var font: DynamicFont
var font_small: DynamicFont
var start_pos = Vector2.ONE * circle_spacing
var subtree_idx = 0

var nodes = []

func _ready() -> void:
	$HBoxContainer/generate_button.connect("pressed", self, "_generate")
	_init_fonts()
	
func _generate() -> void:
	nodes = $generator.generate()
	update()
	
func _init_fonts() -> void:
	font = DynamicFont.new()
	font.font_data = preload("res://Kenney Future.ttf")
	font.size = 20
	font_small = DynamicFont.new()
	font_small.font_data = preload("res://Kenney Future.ttf")
	font_small.size = 15

func _draw() -> void:
	if not nodes:
		return

	subtree_idx = 0
	_draw_subtree(0, 0)
	_draw_edges(0)
	
func _draw_subtree(idx, depth) -> void:
	var parent = nodes[idx]
	var first_half = floor(parent.children.size() / 2)
	for i in range(first_half):
		_draw_subtree(parent.children[i], depth + 1)
	
	parent.pos = start_pos + Vector2(subtree_idx, depth) * circle_spacing
	_draw_node(parent.pos, parent.id)
	subtree_idx += 1
	
	for i in range(parent.children.size() - first_half):
		_draw_subtree(parent.children[first_half + i], depth + 1)
		
func _draw_node(pos, id) -> void:
	draw_circle(pos, circle_size + 2, Color.black)
	draw_circle(pos, circle_size, Color.red)
		
func _draw_edges(idx) -> void:
	var node = nodes[idx]
	for child_idx in node.children:
		draw_line(node.pos, nodes[child_idx].pos, Color.black, 2)
		_draw_edges(child_idx)
	
	var id_size = font.get_string_size(str(node.id))
	draw_string(font, node.pos - id_size / 2, str(node.id))
	
	if node.keys:
		var size = font_small.get_string_size(str(node.keys))
		draw_string(font_small, Vector2(node.pos.x - size.x / 2, node.pos.y + size.y / 2), str(node.keys))
