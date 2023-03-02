extends Control

func _ready():
	for goto_game_button in get_node("%GotoGameButtons").get_children():
		goto_game_button.pressed.connect(_goto_game.bind(goto_game_button))

func _goto_game(goto_game_button: GotoGameButton):
	var game_screen = load("res://game_screen/game_screen_theme_1.tscn").instantiate()
	game_screen.current_game = goto_game_button.game

	SceneManagerSystem.get_container("ScreenContainer").goto_scene(game_screen)

func _on_go_to_test_button_pressed():
	var test_menu = load("res://menus_screens/test_menu/test_menu_theme_1.tscn").instantiate()
	SceneManagerSystem.get_container("ScreenContainer").goto_scene(test_menu)

func _on_go_back_pressed():
	SceneManagerSystem.get_container("ScreenContainer").goto_previous_scene()
