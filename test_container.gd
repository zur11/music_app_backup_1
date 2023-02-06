extends Node2D

func _ready():
	var scenes = [Test.new(), Test2.new()]
	var random_selecte_scene = scenes[randi() % scenes.size()]
	add_child(random_selecte_scene)
	random_selecte_scene.draw_new_sprite()

#------------------------------------------------------------------------
#------------------------------------------------------------------------
class ITest extends Node2D:
	@onready var scene : PackedScene = load("res://test.tscn")
	var _test_var : int
	var _my_second_sprite : Sprite2D
	var instantiated_scene : Node 

	func draw_new_sprite():
		pass
#------------------------------------------------------------------------
#------------------------------------------------------------------------
class Test extends ITest:

	func _ready():
		self.name = "TestClass"
		instantiated_scene = scene.instantiate()
		var button :Button = instantiated_scene.get_node("Button")
		button.connect("pressed", _my_func)
		add_child(instantiated_scene)

	func _my_func():
		print("hola")

	func draw_new_sprite():
		print("from draw funct", self)
		var new_sprite = Sprite2D.new()
		new_sprite.rotate(1)
		new_sprite.texture = load("res://icon.svg")
		new_sprite.scale = Vector2(2, 2)
		new_sprite.position = Vector2(350, 350)
		instantiated_scene.add_child(new_sprite)
#------------------------------------------------------------------------
#------------------------------------------------------------------------
class Test2 extends  ITest:

	func _ready():
		scene = load("res://test2.tscn")
		self.name = "TestClass"
		instantiated_scene = scene.instantiate()
		add_child(instantiated_scene)

	func draw_new_sprite():
		print("from draw funct", self)
		var new_sprite = Sprite2D.new()
		new_sprite.texture = load("res://icon.svg")
		new_sprite.rotate(1)
		new_sprite.position = Vector2(250, 250)
		instantiated_scene.add_child(new_sprite)
