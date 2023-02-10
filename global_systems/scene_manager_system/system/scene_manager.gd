class_name SceneManager extends Node2D

var _async_loader = AsyncLoader.new()
var _container: Node2D

var _current_instanced_scene: Node
var _previous_instanced_scene : Node

var _scene_history : Array

var _theme = "theme_1"

func _change_scene(instanced_scene_to_go: Node):
	for child in _container.get_children():
		self.remove_child(child)
#		await get_tree().process_frame
#		child.call_deferred("free")
	_container.add_child(instanced_scene_to_go)

func goto_scene_without_history(instantiated_scene_to_go: Node):
	_validate_scene_to_go(instantiated_scene_to_go)
	
	_current_instanced_scene = instantiated_scene_to_go
	_change_scene(_current_instanced_scene)

func goto_scene(instantiated_scene_to_go: Node):
	_validate_scene_to_go(instantiated_scene_to_go)

	_scene_history.push_back(instantiated_scene_to_go.scene_file_path)
	if _current_instanced_scene: 
		_previous_instanced_scene = _current_instanced_scene

	_current_instanced_scene = instantiated_scene_to_go
	_change_scene(_current_instanced_scene)

func _validate_scene_to_go(instantiated_scene_to_go: Node) -> bool:
	if instantiated_scene_to_go == null: 
		push_error("Trying to goto_scene to a Null Scene")
		return true
	if instantiated_scene_to_go == _current_instanced_scene: 
		push_warning("Trying to goto_scene to A Scene same as Previous Scene")
		return true
	return false

func goto_previous_scene():
	if !_previous_instanced_scene : return
	_change_scene(_previous_instanced_scene)

	_current_instanced_scene = _previous_instanced_scene

	_scene_history.pop_back()

	if _scene_history.size() > 1:
		_previous_instanced_scene = load(_scene_history[-2]).instantiate()
	else:
		_previous_instanced_scene = null

func update_theme(new_theme: String):

	for ii in _scene_history.size():
		_scene_history[ii] = _scene_history[ii].trim_suffix(_theme + ".tscn") + new_theme + ".tscn"

	if _previous_instanced_scene:
		_previous_instanced_scene = load(_scene_history[-1]).instantiate()
	if _current_instanced_scene:
		_current_instanced_scene = load(_scene_history[-2]).instantiate()
	_theme = new_theme

	self._change_scene(_current_instanced_scene)


#FUNCTIONS FOR THREADED LOADING
func async_load(scene_urls: Array):
	await _async_loader.load_scenes(scene_urls)

func async_clear():
	await _async_loader.clear_scenes()
