extends Node2D

func _ready():
	var initial_background
	var initial_screen
	
	initial_background = load("res://backgrounds/background_landscape_theme_1.tscn")
	initial_screen = load("res://menus_screens/games_menu/games_menu.tscn")
	#initial_screen = load("res://game_screen/game_screen.tscn")

	SceneManagerSystem.get_container("BackgroundContainer").goto_scene_without_history(initial_background)
	SceneManagerSystem.get_container("ScreenContainer").goto_scene(initial_screen)
