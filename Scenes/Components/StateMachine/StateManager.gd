extends Node2D

class_name StateManager

## Actor of State Machine
@export var actor : CharacterBody2D

## First state to execute
@export var currentState : BaseState


func init(player: CharacterBody2D) -> void:
	for child in get_children():
		child.animationManager = $"../AnimationManager"
		child.player = player
		child.stateManager = self
		
	currentState.Enter()
	
func _process(delta):
	currentState.Update(delta)
	
func _physics_process(delta):
	currentState.PhysicsUpdate(delta)
	
func _unhandled_input(event):
	currentState.HandleInput(event)
	
func ChangeState(state : String):
	if not state:
		return
	var stateNode = get_node(state)
	currentState.Exit()
	stateNode.Enter()
	currentState = stateNode
