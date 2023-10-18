extends RayCast2D

func _process(_delta):
	
	position = get_global_mouse_position()
	
	if self.is_colliding():
		print("dsadsad")
