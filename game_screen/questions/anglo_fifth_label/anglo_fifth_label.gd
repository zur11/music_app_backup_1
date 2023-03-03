extends Label

var current_question : Note 

func set_new_question(question: Note):
	var question_relative_pitch = question.relative_pitch
	var fifth_relative_pitch = (question_relative_pitch + 7) % 12
	current_question = Note.new(fifth_relative_pitch)
	self.text = current_question.get_writen_name(Note.naming_systems.ANGLO)
