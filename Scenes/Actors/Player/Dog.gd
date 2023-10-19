extends CharacterBody2D

@export var maxSpeed : float = 1000.0
@export var acceleration : float = 1000.0
@export var friction : float = 1000.0

@onready var barkingArea = $Areas/BarkingArea/CollisionShape2D

var input_vector = Vector2.ZERO

func _physics_process(delta):
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up") 
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * maxSpeed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		

	move_and_slide()
	
func _unhandled_input(event):
	if event.is_action_pressed("bark"):
		barkingArea.set_deferred("disabled", false)
	if event.is_action_released("bark"):
		barkingArea.set_deferred("disabled", true)
	
func _on_barking_area_body_entered(body):
	body.set_move(self)


func _on_barking_area_body_exited(body):
	body.stop_move()
