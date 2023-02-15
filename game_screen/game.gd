class_name Game extends Resource

@export var question_packed_scene: PackedScene : set = _set_question_packed_scene
@export var answers_packed_scene: PackedScene : set = _set_answers_packed_scene

var question_scene: Node
var answers_scene: Node

func reset_scenes():
	_set_asnwer_scene()
	_set_question_scene()

func _set_question_packed_scene(new_value: PackedScene):
	question_packed_scene = new_value
	_set_question_scene()

func _set_question_scene():
	question_scene = question_packed_scene.instantiate()

func _set_answers_packed_scene(new_value: PackedScene):
	answers_packed_scene = new_value
	_set_asnwer_scene()

func _set_asnwer_scene():
	answers_scene = answers_packed_scene.instantiate()
	
