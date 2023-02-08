class_name GamesScreen extends Control

class Game:
	var question_scene: PackedScene
	var answers_scene: PackedScene

	func _init(question_scene_arg: PackedScene, answers_scene_arg: PackedScene):
		question_scene = question_scene_arg
		answers_scene = answers_scene_arg

var correct_answer: Note

var random_input_buttons:PackedScene = load("res://game_screen/answers/random_input_buttons/random_input_buttons.tscn")
var piano:PackedScene = load("res://game_screen/answers/piano/piano.tscn")
var question_output:PackedScene = load("res://game_screen/questions/question_output.tscn")

var current_game: Game = Game.new(question_output, random_input_buttons)

var answer_node : Node
var question_node : Node

func _ready():
	_set_game()

func _set_game():
	set_game_scenes()
	await get_tree().process_frame
	set_game_nodes()
	_connect_answer_emiters()
	_set_new_question()

func set_game_scenes():
	set_answers_scene(current_game.answers_scene)
	set_question_scene(current_game.question_scene)

func set_answers_scene(loaded_answer_scene: PackedScene):
	SceneManagerSystem.get_container("AnswerContainer").goto_scene_without_history(loaded_answer_scene)

func set_question_scene(loaded_question_scene: PackedScene):
	SceneManagerSystem.get_container("QuestionContainer").goto_scene_without_history(loaded_question_scene)

func set_game_nodes():
	answer_node = get_node("AnswerContainer").get_child(0)
	question_node = get_node("QuestionContainer").get_child(0)

func _connect_answer_emiters():
	for answer_emitter in get_tree().get_nodes_in_group("AnswerEmiters"):
		if (!answer_emitter.is_connected("answer_emmited", _on_recibed_answer)):
			answer_emitter.connect("answer_emmited", _on_recibed_answer)

func _on_recibed_answer(_recived_answer:Note):
	var _is_answer_correct:= _evaluate_answer(_recived_answer)
	$HUD.update_on_new_try(_is_answer_correct)
	_set_new_question()

func _evaluate_answer(_recived_answer: Note) -> bool:
	return _recived_answer.relative_pitch == correct_answer.relative_pitch

func _set_new_question():
	var correct_answer_relative_pitch = randi() % 12 
	correct_answer = Note.new(correct_answer_relative_pitch)
	$QuestionContainer/Questions.set_new_question(correct_answer)
	$AnswerContainer/Answers.set_new_question(correct_answer)

func _on_goto_piano_button_pressed():
	current_game = Game.new(question_output, piano)
	_set_game()

func _on_goto_random_button_pressed():
	current_game = Game.new(question_output, random_input_buttons)
	_set_game()
