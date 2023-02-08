extends Control

func _ready():
	$VBoxContainer/GoToAngloGreekButton.connect("pressed", _goto_game)
	$VBoxContainer/GoToAngloPianoButton.connect("pressed", _goto_game)
	
func _goto_game():
	var game_screen: PackedScene = load("res://game_screen/game_screen.tscn")
	SceneManagerSystem.get_container("ScreenContainer").goto_scene(game_screen)
