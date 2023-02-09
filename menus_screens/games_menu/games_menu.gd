extends Control

func _ready():
	$VBoxContainer/GoToAngloGreekButton.connect("pressed", _goto_game)
	$VBoxContainer/GoToAngloPianoButton.connect("pressed", _goto_game)

func _goto_game():
	var game_screen: GamesScreen = load("res://game_screen/game_screen.tscn").instantiate()
	
	var piano:Node = load("res://game_screen/answers/piano/piano.tscn").instantiate()
	var question_output:Node = load("res://game_screen/questions/question_output.tscn").instantiate()
	
	var current_game: Game = Game.new(question_output, piano)
	
	game_screen.current_game = current_game
	
	SceneManagerSystem.get_container("ScreenContainer").goto_scene(game_screen)
