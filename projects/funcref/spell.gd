class_name Spell
extends Node

var cast_effects = []

func _init(effects: Array) -> void:
	cast_effects = effects

func cast() -> void:
	for effect in cast_effects:
		effect.call_func()
