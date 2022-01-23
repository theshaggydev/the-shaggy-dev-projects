extends Node

export (int) var min_nodes = 7
export (int) var max_nodes = 14
export (int) var max_keys_per_node = 2
var nodes = []

var rand = RandomNumberGenerator.new()

func _ready() -> void:
	rand.randomize()

func generate() -> Array:
	nodes = []
	
	for i in range(rand.randi_range(min_nodes, max_nodes)):
		var new_node = TreeNode.new(i)
		
		# First node is the "entrance", so can't have a parent or a lock
		if i > 0:
			# Pick a random parent and key placement from all nodes that came before it
			var parent = select_parent(i)
			var key_location = select_key_location(i)
			
			parent.children.append(i)
			key_location.keys.append(i)
			
		nodes.append(new_node)
	
	return nodes

func select_parent(i: int) -> TreeNode:
	return nodes[rand.randi_range(0, i - 1)]

func select_key_location(i: int) -> TreeNode:
	# Try to select a random node that doesn't have too many keys already
	var available_nodes = nodes.slice(0, i - 1)
	available_nodes.shuffle()
	
	for j in range(0, i - 1):
		var candidate = available_nodes[j]
		if candidate.keys.size() < max_keys_per_node:
			return candidate
	
	# If no suitable match found, return a random node that comes before the current one
	return nodes[rand.randi_range(0, i - 1)]
