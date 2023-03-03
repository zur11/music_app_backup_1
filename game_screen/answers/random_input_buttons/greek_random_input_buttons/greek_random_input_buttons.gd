class_name GreekRndInpButtons extends Node2D

var _answer_options: Array[Note]

var _answer_buttons: Array[AnswerButton]

func _ready():
	get_answer_buttons()

func get_answer_buttons() -> void:
	for button in get_tree().get_nodes_in_group("AnswerButtons"):
		if button.owner == self:
			_answer_buttons.append(button)

func set_new_question(correct_answer_arg: Note):
	_answer_options = generate_answer_options(correct_answer_arg)
	_set_up_buttons()

func generate_answer_options(correct_answer_arg: Note) -> Array[Note]:
	var number_of_options = _answer_buttons.size()
	var correct_answer_index =  randi() % number_of_options
	return QuestionGenerator.create_random_Notes_array(number_of_options, correct_answer_index, correct_answer_arg)

func _set_up_buttons():
	for ii in _answer_buttons.size():
		_answer_buttons[ii].answer_value = _answer_options[ii]
		_answer_buttons[ii].text = _answer_buttons[ii].answer_value.get_writen_name(Note.naming_systems.GREEK)


