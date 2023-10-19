extends Area2D


@export var parent_reference: Node2D



func _on_body_entered(body):
	if parent_reference.has_method("sheep_detected"):
		parent_reference.sheep_detected(body)
	else:
		pass

func _on_body_exited(body):
	if parent_reference.has_method("sheep_detected"):
		parent_reference.sheep_scape(body)
	else:
		pass
