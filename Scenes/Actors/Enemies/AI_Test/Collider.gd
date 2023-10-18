extends Line2D


@onready var area = $Area2D

func _ready():
	#segmentCollision()
	rectCollision()

func segmentCollision():
	## Segment ##
	for i in points.size() - 1:
		var new_shape = CollisionShape2D.new()
		area.add_child(new_shape)
		var segment = SegmentShape2D.new()
		segment.a = points[i]
		segment.b = points[i + 1]
		new_shape.shape = segment
		
func rectCollision():
	## Rectangle ##
	var line_width = 5
	for i in points.size() - 1:
		var new_shape = CollisionShape2D.new()
		area.add_child(new_shape)
		var rect = RectangleShape2D.new()
		new_shape.position = (points[i] + points[i + 1]) / 2
		new_shape.rotation = points[i].direction_to(points[i + 1]).angle()
		var length = points[i].distance_to(points[i + 1])
		rect.extents = Vector2(length / 2, line_width)
		new_shape.shape = rect
