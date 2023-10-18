extends Node2D


@export var dog_player_reference: CharacterBody2D

# EXPORTS-----------------------------------------------------------------------


# CONSTANTS---------------------------------------------------------------------
const MAX_OF_POINTS = 15

# BOOLEANS----------------------------------------------------------------------
var its_possible_to_draw = true
var limit = false
var is_draw = false
var finish_draw = false

# INTEGERS ---------------------------------------------------------------------
var distanceX
var distanceY

# ARRAYS------------------------------------------------------------------------
var distance
var points_of_directions_array: Array[Vector2]

# VECTORS ----------------------------------------------------------------------


# FUNCTIONS---------------------------------------------------------------------

func _input(event):
	
	#Detecto si el evento es de tipo boton del mouse
	if event is InputEventMouseButton:
		
		#Detecto si se esta precionando y es posible dibujar
		if (event.button_index == MOUSE_BUTTON_MASK_LEFT
		and its_possible_to_draw == true
		and event.is_pressed()
		):
			is_draw = true
		
		#Detecto si se esta soltando
		if (event.button_index == MOUSE_BUTTON_MASK_LEFT
		and event.is_released()
		and is_draw == true
		and finish_draw == false
		and its_possible_to_draw == true
		):
			is_draw = false
			finish_draw = true
			share_position_array()
			finish_draw = false
		
		


func _process(delta):
	
	if is_draw == true:
		try_create_point()
	elif is_draw == false:
		pass


func try_create_point():
	var last_point_position = points_of_directions_array.size() - 1
	var mouse_position = get_global_mouse_position()
	if points_of_directions_array.is_empty():
		points_of_directions_array.insert(0,mouse_position)
		asign_first_point_line()
	else:
		distance = points_of_directions_array[last_point_position] - mouse_position
		verify_amount_of_points()
		verify_distance()
		


func verify_amount_of_points():
	if points_of_directions_array.size() >= MAX_OF_POINTS:
		limit = true
	else:
		pass


func verify_distance():
	distance = Tool.return_positive_vector(distance)
	
	if distance.x >= 15 and limit == false:
		create_new_point()
	elif distance.y >= 15 and limit == false:
		create_new_point()


func create_new_point():
	points_of_directions_array.append(get_global_mouse_position())
	create_new_line_point()


func asign_first_point_line():
	var glogal_to = points_of_directions_array[0]
	var local_position = $Line.to_local(glogal_to)
	$Line.add_point(local_position,0)
	


func create_new_line_point():
	var last_point_position = (points_of_directions_array.size() - 1)
	var glogal_to = points_of_directions_array[last_point_position]
	var local_position = $Line.to_local(glogal_to)
	$Line.add_point(local_position,last_point_position)


func show_points():
	for x in points_of_directions_array:
		var new_point = $Panel.duplicate()
		new_point.global_position = x
		new_point.visible = true
		new_point.add_to_group("extra_points")
		self.add_child(new_point)


func share_position_array():
	if finish_draw == true and is_draw == false:
		
		# Dejar esta func ref si quieres ver todos los puntos de la linea-
		show_points()
		
		dog_player_reference.set_direction_points_array(points_of_directions_array)


func clear():
	points_of_directions_array.clear()
	var eliminated_array: Array[Node]
	eliminated_array = get_tree().get_nodes_in_group("extra_points")
	for x in eliminated_array:
		x.queue_free()
	$Line.clear_points()
	limit = false

# SIGNALS-----------------------------------------------------------------------


