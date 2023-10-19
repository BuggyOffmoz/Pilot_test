extends CharacterBody2D

@onready var stateManager = $StateManager
@onready var flockState = $StateManager/FlockState

@export_enum("White","Black") var type_of_sheep: String


func _ready():
	stateManager.init(self)
	
func set_move(body):
	flockState.set_move(body)
	

func stop_move():
	flockState.moveBody = false

