extends Control

var last_try : bool
var correct_tries := 0
var total_tries := 0

func _ready():
	_update_labels()

func update_on_new_try(new_try: bool):
	last_try = new_try
	total_tries += 1
	correct_tries += int(last_try)
	_update_last_tries_container()
	_update_labels()

func _update_last_tries_container():
	$"LastTriesContainer".last_tries_calc(last_try)

func _update_labels():
	get_node("%CorrectTries").text = str(correct_tries) 
	get_node("%TotalTries").text = str(total_tries)
	
