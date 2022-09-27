extends Node2D

var spell: Spell

func _ready() -> void:
	$controls/HBoxContainer/cast.connect("pressed", self, "cast_spell")

func create_spell() -> void:
	var elements = []
	
	# Add the cast function for each element if it's selected
	if $controls/HBoxContainer/fire_toggle.pressed:
		elements.append(funcref(self, 'cast_fire'))
	if $controls/HBoxContainer/water_toggle.pressed:
		elements.append(funcref(self, 'cast_water'))
	if $controls/HBoxContainer/earth_toggle.pressed:
		elements.append(funcref(self, 'cast_earth'))

	# The spell will call all cast effects it is given
	spell = Spell.new(elements)

func cast_spell() -> void:
	create_spell()
	spell.cast()

func cast_fire() -> void:
	$fire_particles.emitting = true

func cast_earth() -> void:
	$earth_particles.emitting = true

func cast_water() -> void:
	$water_particles.emitting = true
