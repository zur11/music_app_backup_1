extends Control


func _on_goto_config_menu_button_pressed():
	var config_menu = load("res://menus_screens/config_menu/config_menu_theme_1.tscn").instantiate()
	SceneManagerSystem.get_container("ScreenContainer").goto_scene(config_menu)

func _on_go_back_menu_pressed():
	SceneManagerSystem.get_container("ScreenContainer").goto_previous_scene()
