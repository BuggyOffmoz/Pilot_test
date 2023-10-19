extends Node2D

@onready var stateManager = $"../StateManager"
@onready var sprite = $Sprite2D

@export var sheep_parent: CharacterBody2D



func update_flip_h_direction_sprite(player_position: Vector2):
	if player_position.x < 0:
		sprite.flip_h = false
	elif player_position.x > 0:
		sprite.flip_h = true
		





