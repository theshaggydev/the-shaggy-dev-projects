extends Sprite

onready var area = $Area2D

func _ready() -> void:
	area.connect('mouse_entered', self, '_on_mouse_entered')
	area.connect('mouse_exited', self, '_on_mouse_exited')

	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(texture.get_data())

	var polys = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, texture.get_size()))
	for poly in polys:
		var collision_polygon = CollisionPolygon2D.new()
		collision_polygon.polygon = poly
		area.add_child(collision_polygon)

		# Generated polygon will not take into account the half-width and half-height offset
		# of the image when "centered" is on. So move it backwards by this amount so it lines up.
		if centered:
			collision_polygon.position -= bitmap.get_size()/2

func _on_mouse_entered() -> void:
	modulate = Color.red

func _on_mouse_exited() -> void:
	modulate = Color.white
