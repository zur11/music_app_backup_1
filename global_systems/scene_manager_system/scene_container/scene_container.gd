@tool class_name SceneContainer extends Node2D

@export var autoload_name = "SceneManagerSystem"
@export var is_historied: bool = false

var scene_manager: SceneManager

func _get_configuration_warnings():
	var warning_messages :PackedStringArray = []
	if !_validate_container_name().is_empty(): warning_messages.append(_validate_container_name())
	if !_validate_zero_children().is_empty(): warning_messages.append(_validate_zero_children())
	return warning_messages
	
func _validate_container_name() -> String:
	var validation_result := ""
	if self.name == "SceneContainer":
		validation_result += "SceneContainer is the generic name for this Scene. If you instantiated more than once make sure they don't have the same name. It would cause a crash when instantiated at runtime.\n   Consider changing the name of the node of instantiated scene."
	return validation_result

func _validate_zero_children() -> String:
	var validation_result := ""
	if self.get_child_count() > 0: 
		validation_result = "SceneContainer should not have children, they will be deleted when calling goto_scene() function of self SceneManager. Calling this function is the correct way to put scene children on it."
	return validation_result

func _ready():
	scene_manager = SceneManager.new(is_historied)
	scene_manager._container = self
	
	if !Engine.is_editor_hint():
		_register_in_system()

func _exit_tree():
	if !Engine.is_editor_hint():
		_unregister_in_system()

func _register_in_system():
	get_node("/root/"+autoload_name)._register_new_container(self)

func _unregister_in_system():
	get_node("/root/"+autoload_name)._unregister_container(self)
