class_name GotoGameButton extends Button

@export var game:Game

func _ready():
	game.reset_scenes()
