extends Polygon2D

func _ready():
	var collision_shape = CollisionPolygon2D.new()
	# Polygon2D.polygon contains a list of all vertices on the drawn polygon
	# so just copy those points over to the new collision shape
	collision_shape.polygon = polygon
	$StaticBody2D.add_child(collision_shape)
