class_name QuestionOutput extends Control

var current_question : Note 

func set_new_question(question: Note):
	current_question = question
	$Label.text = question.get_writen_name(Note.naming_systems.GREEK)