extends RigidBody2D

onready var polygon = $Polygon2D

func _ready():
	# Store the polygon's global position so we can reset its position after moving its parent
	var polygon_global_position = polygon.global_position
	# Move the rigidbody to the center of the polygon, taking into account
	# any offset the Polygon2D node may have relevant to the rigidbody
	var polygon_center = get_polygon_center()
	global_position += polygon_center + polygon.position
	# Move the polygon node to its original position
	polygon.global_position = polygon_global_position
	
	var collision_shape = CollisionPolygon2D.new()
	collision_shape.polygon = offset_polygon_points(polygon_center)
	add_child(collision_shape)

# Offset the points of the polygon by the center of the polygon
func offset_polygon_points(center: Vector2):
	var adjusted_points = []
	for point in polygon.polygon:
		# Moving the collision shape itself doesn't seem to work as well as offsetting the polygon points
		# for putting the collision shape in the right position after moving the rigidbody.
		# Therefore, to have the collision shape appear where drawn, subtract the polygon center from each point
		# to move the point by the amount the rigidbody was moved relative to the original Polygon2D's position.
		adjusted_points.append(point - center)
	return adjusted_points

# A simple weighted average of all points of the polygon to find the center
func get_polygon_center():
	var center_weight = polygon.polygon.size()
	var center = Vector2(0, 0)
	
	for point in polygon.polygon:
		center.x += point.x / center_weight
		center.y += point.y / center_weight
	
	return center
