extends CharacterBody2D

func _physics_process(delta):
	position = get_global_mouse_position()


func _on_area_2d_body_entered(body):
	body.set_move(self)


func _on_area_2d_body_exited(body):
	body.stop_move()
