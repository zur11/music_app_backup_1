class_name GamesScreen extends Control

var correct_answer: Note

var random_input_buttons:PackedScene = load("res://game_screen/answers/random_input_buttons/random_input_buttons.tscn")
var piano: PackedScene = load("res://game_screen/answers/piano/piano.tscn")
var question_output:PackedScene = load("res://game_screen/questions/question_output.tscn")

var anglo_greek_game := Game.new()
var anglo_piano_game := Game.new()

var games : Array[Game]= [anglo_greek_game, anglo_piano_game]

var current_game: Game = Game.new()

func _ready():
	anglo_greek_game.answers_packed_scene = random_input_buttons
	anglo_greek_game.question_packed_scene = question_output
	anglo_piano_game.answers_packed_scene = piano
	anglo_piano_game.question_packed_scene = question_output
	set_game_scenes()

func set_game_scenes():
	set_scenes()
	await get_tree().process_frame
	restart_game()

func set_scenes():
	SceneManagerSystem.get_container("AnswerContainer").goto_scene(current_game.answers_packed_scene.instantiate())
	SceneManagerSystem.get_container("QuestionContainer").goto_scene(current_game.question_packed_scene.instantiate())

func restart_game():
	_connect_answer_emiters()
	_set_new_question()

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

func _on_select_game_button_pressed():
	current_game = games[randi() % games.size()]
	set_game_scenes()

func _on_go_back_to_menu_button_pressed():
	SceneManagerSystem.get_container("ScreenContainer").goto_previous_scene()


