class_name AnswerButton extends Button

signal answer_emmited

var answer_value : Note

func _init():
	self.add_to_group("AnswerButtons")
	self.add_to_group("AnswerEmiters")

func _on_pressed():
	emit_signal("answer_emmited", answer_value)
