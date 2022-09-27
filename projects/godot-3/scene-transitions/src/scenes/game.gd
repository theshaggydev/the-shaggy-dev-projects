extends Control

onready var main_menu_button = $content/main_menu_button

func _ready() -> void:
	main_menu_button.connect('pressed', self, 'on_main_menu')

func on_main_menu() -> void:
	SceneTransition.change_scene('res://src/scenes/main_menu.tscn', 'clouds')
