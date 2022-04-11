extends RigidBody2D

onready var sprite = $Sprite

func _ready() -> void:
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(sprite.texture.get_data())
	var polys = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, sprite.texture.get_size()), 5)

	for poly in polys:
		var collision_polygon = CollisionPolygon2D.new()
		collision_polygon.polygon = poly
		add_child(collision_polygon)

		# Generated polygon will not take into account the half-width and half-height offset
		# of the image when "centered" is on. So move it backwards by this amount so it lines up.
		if sprite.centered:
			collision_polygon.position -= bitmap.get_size()/2
