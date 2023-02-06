extends Node2D

func _ready():
	for ii in get_child_count():
		get_child(ii).answer_value = Note.new(ii)

func set_new_question(_arg):
	pass
