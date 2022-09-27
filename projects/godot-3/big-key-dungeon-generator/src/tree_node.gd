# Node is already used by Godot, so using an alternative name
class_name TreeNode
extends Node

var children = []
var id = ''
var keys = []
var pos: Vector2

func _init(node_id):
	id = node_id

func _to_string():
	return '\n---\nNode: %s\nChildren: %s\nKeys: %s\n---' % [id, children, keys]
