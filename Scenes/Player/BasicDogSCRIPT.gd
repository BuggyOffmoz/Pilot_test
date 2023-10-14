extends CharacterBody2D



# EXPORTS-----------------------------------------------------------------------
@export var draw_line_reference: Node

# CONSTANTS---------------------------------------------------------------------


# BOOLEANS----------------------------------------------------------------------
var in_movement = false
var next_point_distance = false
var to_last_point = false
var aux_int = 0
# INTEGERS ---------------------------------------------------------------------
var speed = 200


# ARRAYS------------------------------------------------------------------------
var points_of_directions: Array

# VECTORS ----------------------------------------------------------------------
var direction: Vector2
var to_direction: Vector2


var actual_point: Vector2
var next_point: Vector2

# FUNCTIONS---------------------------------------------------------------------

func _process(delta):
	move()


func start_line_path():
	in_movement = true
	draw_line_reference.its_possible_to_draw = false
	move()

func finalize_line_path():
	in_movement = false
	next_point_distance = false
	aux_int = 0
	draw_line_reference.its_possible_to_draw = true
	draw_line_reference.clear()

func move():
	if in_movement == true:
		change_next_position()
		
		if next_point_distance == false:
			velocity = (next_point - self.global_position).normalized() * speed
			move_and_slide()
			next_point_distance = verify_distances()


func change_next_position():
	
	if aux_int == 0:
		next_point = points_of_directions[0]
	elif next_point_distance == true:
		next_point = points_of_directions[aux_int]
		next_point_distance = false

func verify_distances():
		var distance: Vector2 = self.global_position - next_point
		distance = fix_distance(distance)
		if distance.x <= 2 and distance.y <= 2:
			aux_int += 1
			if aux_int >= points_of_directions.size():
				finalize_line_path()
				return(false)
			return(true)
		else:
			return(false)
			


func fix_distance(aux_vector: Vector2):
	var fixed_distance: Vector2
	fixed_distance = aux_vector
	if aux_vector.x < 0:
		fixed_distance.x *= -1
	else:
		pass
	
	if aux_vector.y < 0:
		fixed_distance.y *= -1
	else:
		pass
	
	return(fixed_distance)
func set_direction_points_array(aux_array_points: Array):
	points_of_directions = aux_array_points
	start_line_path()



# SIGNALS-----------------------------------------------------------------------
