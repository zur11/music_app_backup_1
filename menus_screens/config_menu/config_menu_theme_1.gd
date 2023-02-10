extends Control

func _on_change_to_theme_1_buttton_pressed():
	SceneManagerSystem.get_container("ScreenContainer").update_theme("theme_1")


func _on_change_to_theme_2_buttton_pressed():
	SceneManagerSystem.get_container("ScreenContainer").update_theme("theme_2")


func _on_go_back_button_pressed():
	SceneManagerSystem.get_container("ScreenContainer").goto_previous_scene()
