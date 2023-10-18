extends BaseState


func Enter():
	print("Idle")

func Exit():
	pass
	
func HandleInput(_event):
	pass
	#if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left") \
	#or Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
	#	stateManager.ChangeState("FlockState")
