extends Control

func _ready():
	$VBoxContainer/GoToAngloGreekButton.connect("pressed", _goto_game)
	$VBoxContainer/GoToAngloPianoButton.connect("pressed", _goto_game)

func _goto_game():
	var game_screen: GamesScreen = load("res://game_screen/game_screen_theme_1.tscn").instantiate()
	
	var piano:Node = load("res://game_screen/answers/piano/piano.tscn").instantiate()
	var question_output:Node = load("res://game_screen/questions/question_output.tscn").instantiate()
	
	var current_game: Game = Game.new(question_output, piano)
	
	game_screen.current_game = current_game
	
	SceneManagerSystem.get_container("ScreenContainer").goto_scene(game_screen)

func _on_go_to_test_button_pressed():
	var test_menu = load("res://menus_screens/test_menu/test_menu_theme_1.tscn").instantiate()
	SceneManagerSystem.get_container("ScreenContainer").goto_scene(test_menu)

func _on_go_to_game_button_pressed():
	SceneManagerSystem.get_container("ScreenContainer").goto_previous_scene()
