extends CharacterBody2D



# EXPORTS-----------------------------------------------------------------------
@export var draw_line_reference: Node

# CONSTANTS---------------------------------------------------------------------


# BOOLEANS----------------------------------------------------------------------
var in_movement = false
var low_distance_to_next_point = false
var to_last_point = false

# INTEGERS ---------------------------------------------------------------------
var speed = 200
var actual_steep_point = 0

# ARRAYS------------------------------------------------------------------------
var points_of_directions: Array

# VECTORS ----------------------------------------------------------------------
var direction: Vector2
var to_direction: Vector2


var actual_point: Vector2
var next_point: Vector2

# FUNCTIONS---------------------------------------------------------------------

func _process(delta):
	# Verifico el movimiento de forma continua (Cambiar si es necesario).
	move()


func start_line_path():
	# Inicio el movimiento del perro.
	in_movement = true
	
	# Notifico que no sea posible dibujar otra linea ya que el perro esta en
	# en movimiento.
	draw_line_reference.its_possible_to_draw = false


func finalize_line_path():
	# Finalizo el movimiento del perro siguiendo la linea.
	
	# Ademas de reiniciar valores importantes para que el perro pueda
	# iniciar un siguiente movimiento de linea.
	in_movement = false
	low_distance_to_next_point = false
	actual_steep_point = 0
	draw_line_reference.its_possible_to_draw = true
	
	# Indico que se puede borrar la linea, ya que finalizo el movimiento.
	draw_line_reference.clear()


func move():
	if in_movement == true:
		verify_changes_in_actual_steep()
		
		if low_distance_to_next_point == false:
			velocity = (next_point - self.global_position).normalized() * speed
			move_and_slide()
			verify_distances()


func verify_changes_in_actual_steep():
	# Verifico en que punto del movimiento en linea estoy (actualmente cuando
	# se dibuja la linea, tiene un limite de 15 pasos, tener en cuenta).
	
	# Verifico que el siguiente paso no sea mayor que el total que debo hacer.
	if actual_steep_point > points_of_directions.size() - 1:
		finalize_line_path()
	
	if actual_steep_point == 0:
		# Con esto hago que se inicie el primer paso, haciendo referencia al
		# primer vector dentro de -points_of_directions-.
		if points_of_directions.is_empty():
			pass
		else:
			next_point = points_of_directions[0]
	
	
	if low_distance_to_next_point == true:
		# Si se notifica que la distancia actual del perro esta cerca del punto
		# al que tenia que llegar, indico que se fije el paso a seguir.
		next_point = points_of_directions[actual_steep_point]
		
		# Y reestablezco su valor a falso.
		low_distance_to_next_point = false
		


func verify_distances():
		# Creo la variable que calcula las distancias del perro, al siguiente
		# punto.
		var distance: Vector2 = self.global_position - next_point
		
		# Arreglo el vetor a positivos.
		distance = Tool.return_positive_vector(distance)
		
		# Si la distancia calculada entre el perro y el siguiente punto
		# es lo suficientemente cercana, se retornara que es el caso
		if distance.x <= 2 and distance.y <= 2:
			low_distance_to_next_point = true
			actual_steep_point += 1
		else:
			low_distance_to_next_point = false
			


# Setters--

# Funcion llamada desde otro nodo para colocar el array de vectores
func set_direction_points_array(aux_array_points: Array):
	points_of_directions = aux_array_points
	start_line_path()



# SIGNALS-----------------------------------------------------------------------
