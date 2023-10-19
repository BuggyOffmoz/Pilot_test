extends Node


class_name WorldBaseObject

var array_sheeps_detected: Array[CharacterBody2D]


func sheep_detected(body):
	if array_sheeps_detected.has(body):
		pass
	else:
		array_sheeps_detected.insert(array_sheeps_detected.size(),body)

func sheep_scape(body):
	if array_sheeps_detected.has(body):
		array_sheeps_detected.remove_at(array_sheeps_detected.find(body))
	else:
		pass
