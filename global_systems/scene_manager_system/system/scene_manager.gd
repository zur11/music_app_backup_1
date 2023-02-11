class_name SceneManager extends Node2D

var _async_loader = AsyncLoader.new()
var _container: Node2D

var _history_manager:= HistoryManager.new()

#var _scene_history : Array = []
#var _previous_instanced_scene : Node
#
#var _theme = "theme_1"

func _change_scene(instanced_scene_to_go: Node):
	for child in _container.get_children():
		self.remove_child(child)
		await get_tree().process_frame
		child.free()
	_container.add_child(instanced_scene_to_go)

func goto_scene(instantiated_scene_to_go: Node):
	if _validate_scene_to_go(instantiated_scene_to_go): return

	_history_manager.add_new_scene(instantiated_scene_to_go)
#	_scene_history.push_back(instantiated_scene_to_go.scene_file_path)
#	_previous_instanced_scene = _get_previous_instance_scene() 

	_change_scene(instantiated_scene_to_go)

func _validate_scene_to_go(instantiated_scene_to_go: Node) -> bool:
	if instantiated_scene_to_go == null: 
		push_error("Trying to goto_scene to a Null Scene")
		return true
	if _history_manager._scene_history.size() > 0 and instantiated_scene_to_go.scene_file_path == _history_manager._scene_history.back(): 
		#push_warning("Trying to goto_scene to A Scene same as Previous Scene")
		return true
	return false

func goto_previous_scene():
	if !_history_manager._previous_instanced_scene : return
	var instantiated_scene_to_go = _history_manager._previous_instanced_scene

#	_scene_history.pop_back()
#	_previous_instanced_scene = _get_previous_instance_scene() 
	_history_manager.remove_last_scene()
	
	_change_scene(instantiated_scene_to_go)

func update_theme(new_theme: String):

#	for ii in _scene_history.size():
#		_scene_history[ii] = _scene_history[ii].trim_suffix(_theme + ".tscn") + new_theme + ".tscn"
#	_previous_instanced_scene = _get_previous_instance_scene() 
#	_theme = new_theme
	_history_manager.update_themes(new_theme)

	self._change_scene(_history_manager._get_current_instantiated_scene())

#func _get_previous_instance_scene() -> Node:
#	return load(_scene_history[-2]).instantiate() if _scene_history.size() > 1 else null
#
#func _get_current_instantiated_scene() -> Node:
#	return load(_scene_history[-1]).instantiate()










#------------------------------
#FUNCTIONS FOR THREADED LOADING
#------------------------------
func async_load(scene_urls: Array):
	await _async_loader.load_scenes(scene_urls)

func async_clear():
	await _async_loader.clear_scenes()
