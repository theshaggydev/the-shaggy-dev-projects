extends Line2D

func _ready() -> void:
	var line_poly = Geometry.offset_polyline_2d(points, width / 2, Geometry.JOIN_ROUND, Geometry.END_ROUND)
	
	# offset_polyline_2d can potentially return multiple polygons
	# so iterate through all polyons and create collision shapes from them
	for poly in line_poly:
		var col = CollisionPolygon2D.new()
		col.polygon = poly
		$StaticBody2D.add_child(col)
