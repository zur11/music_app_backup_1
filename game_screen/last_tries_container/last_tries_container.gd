extends MarginContainer

signal achievement_acquired(new_game_achivement:GameAchievements)

@export var tries_to_display:int

@export var new_try : Texture
@export var wrong_try : Texture
@export var correct_try : Texture

@onready var new_try_texture : TextureRect

@onready var _last_tries := [] 
@onready var _last_tries_nodes :=[] 


func _ready():
	for ii in tries_to_display:
		new_try_texture = TextureRect.new()
		new_try_texture.texture = new_try
		new_try_texture.size = Vector2(90,80)
		_last_tries_nodes.push_front(new_try_texture)
		$HBoxContainer.add_child(new_try_texture)

func last_tries_calc(last_try) -> void:

	_last_tries.push_front(int(last_try))
	
	if _last_tries.size() > tries_to_display:
		_last_tries.pop_back()

	for ii in _last_tries.size():
		if _last_tries[ii] == 1:
			_last_tries_nodes[ii].texture = correct_try
		elif _last_tries[ii] == 0:
			_last_tries_nodes[ii].texture = wrong_try
		
	var _correct_tries = float(_last_tries.count(1))

	if _correct_tries == 15:
		var new_game_achievement = GameAchievements.new()
		new_game_achievement.acquaired_achievement_degree = 1
		achievement_acquired.emit(new_game_achievement)
	if _correct_tries == 20:
		var new_game_achievement = GameAchievements.new()
		new_game_achievement.acquaired_achievement_degree = 2
		achievement_acquired.emit(new_game_achievement)
#	printt(_correct_tries)
