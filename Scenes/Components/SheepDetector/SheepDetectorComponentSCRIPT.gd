extends Area2D


@export var parent_reference: Node2D




func _on_body_entered(body):
	parent_reference.sheep_detected(body)

func _on_body_exited(body):
	parent_reference.sheep_scape(body)
