extends BaseState

# Object CharacterBody2D to be moved with the Script
#@export var actor : CharacterBody2D
## Maximum speed of actor when moving
@export var max_speed: = 200.0
## Add force to movement
@export var follow_force: = 0.05
@export var cohesion_force: = 0.05
@export var algin_force: = 0.05
## Fuerza de separación entree ovejas
@export var separation_force: = 0.05
## Distancia de vision para unirsee a un Grupo
@export var view_distance: = 50.0 
## Distancia de colision entre ovejas
@export var avoid_distance: = 20.0 

@onready var flockRadius = $FlockView/CollisionShape2D

var _flock: Array = []
var _mouse_target: Vector2

var moveBody = false
var pushObject

func Enter():
	print("FLOCK ENTER STATE")
	
func Exit():
	print("FLOCK EXIT STATE")


func _ready():
	randomize()
	flockRadius.shape.radius = view_distance
	#actor.velocity = Vector2(randi_range(-1, 1), randi_range(-1, 1)).normalized() * max_speed


func _on_flock_view_body_entered(body):
	if self != body:
		_flock.append(body)


func _on_flock_view_body_exited(body):
	if _flock.size() != 0:
		_flock.remove_at(_flock.find(body))


func set_move(body):
	_mouse_target = body.position
	pushObject = body
	moveBody = true
	stateManager.ChangeState("FlockState")






func PhysicsUpdate(delta):
	var mouse_vector = Vector2.ZERO
	if _mouse_target != Vector2.ZERO and moveBody:
		mouse_vector = player.global_position.direction_to(pushObject.position) * max_speed * follow_force * -1
		# get cohesion, alginment, and separation vectors
		var vectors = get_flock_status(_flock)
		
		# steer towards vectors
		var cohesion_vector = vectors[0] * cohesion_force
		var align_vector = vectors[1] * algin_force
		var separation_vector = vectors[2] * separation_force

		var acceleration = cohesion_vector + align_vector + separation_vector + mouse_vector
		player.velocity = player.velocity.move_toward(acceleration * max_speed, 2000 * delta).limit_length(max_speed)
		
		## if the sheep is moving, see where it is running.
		animationManager.update_flip_h_direction_sprite(mouse_vector)
	else:
		var vectors = get_flock_status(_flock)
		player.velocity = player.velocity.move_toward(Vector2.ZERO + (vectors[2] * separation_force), 200 * delta)

	player.move_and_slide()
	

func get_flock_status(flock: Array):
	var center_vector: = Vector2()
	var flock_center: = Vector2()
	var align_vector: = Vector2()
	var avoid_vector: = Vector2()
	
	for f in flock:
		var neighbor_pos: Vector2 = f.global_position

		align_vector += f.velocity
		flock_center += neighbor_pos

		var d = player.global_position.distance_to(neighbor_pos)
		if d > 0 and d < avoid_distance:
			avoid_vector -= (neighbor_pos - player.global_position).normalized() * (avoid_distance / d * max_speed)
	
	var flock_size = flock.size()
	if flock_size:
		align_vector /= flock_size
		flock_center /= flock_size

		var center_dir = player.global_position.direction_to(flock_center)
		var center_speed = max_speed * (player.global_position.distance_to(flock_center) / flockRadius.shape.radius)
		center_vector = center_dir * center_speed

	return [center_vector, align_vector, avoid_vector]
