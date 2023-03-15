extends Control

const _GAMES_TRES_FOLDER_PATH := "res://games/games_tres/"

var _available_games : Array[Resource]

func _ready():
	_load_available_game_resources()
	_add_go_to_game_buttons()
	_connect_go_to_game_buttons()
	

func _load_available_game_resources():
	var dir = DirAccess.open(_GAMES_TRES_FOLDER_PATH)

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()

		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if file_name.ends_with(".gd"): 
					file_name = dir.get_next()

				var game_resource = load(_GAMES_TRES_FOLDER_PATH + file_name)
				game_resource.game_name = file_name.trim_suffix(".tres")
				_available_games.append(game_resource)
				file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func _add_go_to_game_buttons():
	for game in _available_games:
		var goto_game_button:Node = load("res://menus_screens/games_menu/go_to_game_button/go_to_game_button.tscn").instantiate()

		goto_game_button.name = game.game_name
		goto_game_button.game = game
		goto_game_button.text = game.game_name

		$"%GotoGameButtons".add_child(goto_game_button)
		
		printt(goto_game_button.game.game_achievements.acquaired_achievement_degree)
		
func _connect_go_to_game_buttons():
	for goto_game_button in get_node("%GotoGameButtons").get_children():
		goto_game_button.pressed.connect(_goto_game.bind(goto_game_button))

func _goto_game(goto_game_button: GotoGameButton):
	var game_screen = load("res://game_screen/game_screen_theme_1.tscn").instantiate()
	game_screen.current_game = goto_game_button.game

	SceneManagerSystem.get_container("ScreenContainer").goto_scene(game_screen)

func _on_go_back_pressed():
	SceneManagerSystem.get_container("ScreenContainer").goto_previous_scene()
