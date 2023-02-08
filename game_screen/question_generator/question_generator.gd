class_name QuestionGenerator extends Node

static func create_random_int_array(array_size: int, max_element_value: int) -> Array[int]:
	var returned_array : Array[int] = []
	for ii in array_size:
		var new_value := randi() % max_element_value 
		while (returned_array.has(new_value)):
			new_value = randi() % max_element_value
		returned_array.append(new_value)
	return returned_array

static func create_random_Notes_array(_array_size: int, correct_answer_index: int, correct_answer: Note) -> Array[Note]:
	var _notes_names_size = Note.notes_names[Note.naming_systems.ANGLO].size()
	var _note_array : Array[Note] = [Note.new(1),Note.new(1),Note.new(1),Note.new(1)]
	_note_array[correct_answer_index] = correct_answer
#	for ii in array_size:
#		var new_value := randi() % notes_names_size 
#		while (note_array.has(new_value)):
#			new_value = randi() % notes_names_size
#		note_array.append(new_value)
	#print(note_array)
	return _note_array

