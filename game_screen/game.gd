class_name Game extends Resource

var question_scene: Node
var answers_scene: Node

func _init(question_scene_arg: Node, answers_scene_arg: Node):
	question_scene = question_scene_arg
	answers_scene = answers_scene_arg
