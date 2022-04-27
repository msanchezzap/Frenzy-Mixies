extends Node2D

var _current_scene = null
const _BUTTON_SIZE = 50
const _BUTTON_GAP = 10

func _init():
	for i in [1,2,3]:
		createbutton(i)

func createbutton(level: int):
	var b = Button.new()
	b.set_name(str(level))
	b.text = str(level)
	b.set_position(Vector2((_BUTTON_GAP + _BUTTON_SIZE) * level , 100))
	b.rect_size = Vector2(_BUTTON_SIZE,_BUTTON_SIZE)
	b.connect("pressed", self, "_button_pressed", [b])
	add_child(b)

func _input(event):
	if event is InputEventKey:
		if event.pressed && event.scancode == KEY_ESCAPE:
			_changeScene("res://Interface/Scenes/Main.tscn")

func _button_pressed(button):
	Config.setLevel(int(button.get_name()))
	_changeScene("res://Interface/Scenes/Game.tscn")
	
func _ready():
	var root = get_tree().get_root()
	_current_scene = root.get_child(root.get_child_count() - 1)
	
func _changeScene(path: String):
	_current_scene.queue_free()
	var s = ResourceLoader.load(path)
	_current_scene = s.instance()
	get_tree().get_root().add_child(_current_scene)
	get_tree().set_current_scene(_current_scene)
	get_tree().change_scene(path)
