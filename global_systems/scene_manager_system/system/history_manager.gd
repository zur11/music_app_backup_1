class_name HistoryManager extends Resource

var _scene_history : Array = []
var _previous_instanced_scene : Node

var _theme = "theme_1"

func add_new_scene(instantiated_scene_to_go):
	_scene_history.push_back(instantiated_scene_to_go.scene_file_path)
	_previous_instanced_scene = _get_previous_instance_scene()

func remove_last_scene():
	_scene_history.pop_back()
	_previous_instanced_scene = _get_previous_instance_scene() 

func update_themes(new_theme):
	for ii in _scene_history.size():
		_scene_history[ii] = _scene_history[ii].trim_suffix(_theme + ".tscn") + new_theme + ".tscn"
	_previous_instanced_scene = _get_previous_instance_scene() 
	_theme = new_theme

func _get_previous_instance_scene() -> Node:
	print(_scene_history)
	return load(_scene_history[-2]).instantiate() if _scene_history.size() > 1 else null

func _get_current_instantiated_scene() -> Node:
	return load(_scene_history[-1]).instantiate()
