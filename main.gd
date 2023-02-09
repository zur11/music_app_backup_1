extends Node2D

func _ready():
	var initial_background: Node
	var initial_screen: Node
	
	initial_background = load("res://backgrounds/background_landscape_theme_1.tscn").instantiate()
	initial_screen = load("res://menus_screens/games_menu/games_menu_theme_1.tscn").instantiate()
	#initial_screen = load("res://game_screen/game_screen.tscn")

	SceneManagerSystem.get_container("BackgroundContainer").goto_scene_without_history(initial_background)
	SceneManagerSystem.get_container("ScreenContainer").goto_scene(initial_screen)
