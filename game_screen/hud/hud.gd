extends Control

var correct_tries := 0
var total_tries := 0

func _ready():
	_update_labels()

func update_on_new_try(new_try: bool):
	total_tries += 1
	correct_tries += int(new_try)
	_update_labels()

func _update_labels():
	get_node("%CorrectTries").text = str(correct_tries) 
	get_node("%TotalTries").text = str(total_tries)
	
