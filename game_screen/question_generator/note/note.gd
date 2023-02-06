class_name Note extends Resource

enum naming_systems {ANGLO, GREEK}

var accidentals_subfixes := {
	NONE = "",
	SHARP = "#",
	BEMOL = "b"
	}

const notes_names := {
	naming_systems.ANGLO: ["C",  "black", "D",  "black", "E",  "F",  "black", "G",   "black", "A",  "black", "B"],
	naming_systems.GREEK: ["Do", "black", "Re", "black", "Mi", "Fa", "black", "Sol", "black", "La", "black", "Si"]
}

@export var relative_pitch: int : set = _set_relative_pitch

func _init(relative_pitch_arg: int):
	_set_relative_pitch(relative_pitch_arg)

func _set_relative_pitch(new_value: int):
	assert(0 > new_value or 11 < notes_names[naming_systems.ANGLO].size(), "relative value must be between 0-11")
	relative_pitch = new_value

func get_writen_name(_naming_system:= naming_systems.ANGLO) -> String:
	var base_name := ""
	var accidental := "" 
	if notes_names[naming_systems.ANGLO][relative_pitch] != "black":
		base_name = notes_names[_naming_system][relative_pitch]
		accidental = accidentals_subfixes.NONE 
	#TODO find wich accidental should be use
	else: 
		base_name = notes_names[_naming_system][relative_pitch - 1]
		accidental = accidentals_subfixes.SHARP
	var returned_name := base_name + accidental
	return returned_name
