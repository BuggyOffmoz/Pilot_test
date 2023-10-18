extends Node



func return_positive_vector(aux_vector: Vector2):
	var fixed_distance: Vector2 = aux_vector
	
	# Verifico si los flotantes son menores que cero.
	
	# Y si es el caso, los multiplico por menos uno, para dar un resultado
	# positivo del mismo valor (un efecto espejo).
	
	# Importante que se calcule cada uno por separado, ya que solo queremos
	# arreglar los casos donde sean negativos, pero no todo el vector
	# si no es necesario.
	
	# Caso de la pos x
	if aux_vector.x < 0:
		fixed_distance.x *= -1
	else:
		pass
	
	# Caso de la pos y
	if aux_vector.y < 0:
		fixed_distance.y *= -1
	else:
		pass
	
	# A este punto ya estaria arreglado de ser necesario.
	return(fixed_distance)




