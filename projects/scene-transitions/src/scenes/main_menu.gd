extends Control

onready var play_button = $content/play_button

func _ready() -> void:
	play_button.connect('pressed', self, 'on_play')

func on_play() -> void:
	SceneTransition.change_scene('res://src/scenes/game.tscn')
