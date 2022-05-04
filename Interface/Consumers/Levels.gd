extends Node2D

var _current_scene = null
const _BUTTON_SIZE = 150
const _BUTTON_GAP = 10

func _init():
	for i in [1,2,3,4,5,6,7,8,9]:
		createbutton(i)

func createbutton(level: int):
	var b = TextureButton.new()
	add_child(b)
	b.texture_normal = load("res://Interface/resources/UI/Levels/lvl"+str(level)+".png")
	if Config.getMaxLevel() >= level:
		b.connect("pressed", self, "_button_pressed", [b])
		createStarCounter(b, level)
	b.set_name(str(level))
	b.set_position(Vector2(_BUTTON_SIZE + (_BUTTON_GAP + _BUTTON_SIZE) * ((level - 1) % 3) , _BUTTON_SIZE + (_BUTTON_SIZE + _BUTTON_GAP) *((level -1) / 3)))
	b.rect_size = Vector2(_BUTTON_SIZE,_BUTTON_SIZE)


func createStarCounter(button: Button, level: int):
	var sc = TextureButton.new()
	sc.texture_normal = load("res://Interface/resources/UI/Stars/"+str(Config._stars[level-1])+"s.png")
	sc.set_name("sc" + str(level))
	sc.connect("pressed", self, "_button_pressed", [sc])
	sc.set_position(Vector2(_BUTTON_SIZE + (_BUTTON_GAP + _BUTTON_SIZE) * ((level - 1) % 3) , 1.5*_BUTTON_SIZE + (_BUTTON_SIZE + _BUTTON_GAP) *((level -1) / 3)))
	sc.rect_size = Vector2(0,0)
	add_child(sc)

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
