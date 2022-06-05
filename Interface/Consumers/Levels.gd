extends Node2D

var _current_scene = null
const _BUTTON_SIZE = 151
const _BUTTON_GAP = 10
var viewportWidth
var viewportHeight 
func _ready():
	viewportWidth = get_viewport().size.x
	viewportHeight = get_viewport().size.y
	for i in [1,2,3,4,5,6,7,8,9]:
		createbutton(i)
	var root = get_tree().get_root()
	_current_scene = root.get_child(root.get_child_count() - 1)
	setBackgroundSize()
func _physics_process(delta):
	$FPS.text = "FPS: " + str(Engine.get_frames_per_second()) 
	$RAM.text = "RAM: " + str(stepify(OS.get_static_memory_usage() / 1000000.0,0.01)) +"MB"
	
func setBackgroundSize():
	pass
	var viewportWidth = get_viewport().size.x
	var viewportHeight = get_viewport().size.y
	var scaleX = viewportWidth / $Background.texture.get_size().x
	var scaleY = viewportHeight / $Background.texture.get_size().y
	$Background.set_position(Vector2(viewportWidth/2, viewportHeight/2))
	$Background.set_scale(Vector2(scaleX, scaleY))

func createbutton(level: int):
	var b = TextureButton.new()
	add_child(b)
	if Config.getMaxLevel() >= level:
		b.texture_normal = load("res://Interface/resources/UI/Levels/lvl"+str(level)+".png")
		b.connect("pressed", self, "_button_pressed", [b])
		createStarCounter(b, level)
	else:
		b.texture_normal = load("res://Interface/resources/UI/Levels/lvlL.png")
	b.set_name(str(level))
	b.set_position(Vector2(viewportWidth/2 - _BUTTON_GAP - _BUTTON_SIZE*1.5 + (_BUTTON_GAP + _BUTTON_SIZE) * ((level - 1) % 3) ,viewportWidth/10 + (_BUTTON_SIZE + _BUTTON_GAP) *((level -1) / 3)))
	b.rect_size = Vector2(_BUTTON_SIZE,_BUTTON_SIZE)

func createStarCounter(button: Button, level: int):
	var sc = TextureButton.new()
	sc.texture_normal = load("res://Interface/resources/UI/LittleStaras/"+str(Config._stars[level-1])+"s.png")
	sc.set_name("sc" + str(level))
	sc.connect("pressed", self, "_button_pressed", [sc])
	sc.set_position(Vector2(viewportWidth/2 - _BUTTON_GAP - _BUTTON_SIZE*1.4 + (_BUTTON_GAP + _BUTTON_SIZE) * ((level - 1) % 3) + 10, (viewportWidth/10) - (_BUTTON_SIZE/8) + (_BUTTON_SIZE + _BUTTON_GAP) *((level -1) / 3)))
	sc.rect_size = Vector2(0,0)
	add_child(sc)

func _input(event):
	if event is InputEventKey:
		if event.pressed && event.scancode == KEY_ESCAPE:
			_changeScene("res://Interface/Scenes/Main.tscn")

func _button_pressed(button):
	MusicScrene.playButton()
	Config.setLevel(int(button.get_name()))
	_changeScene("res://Interface/Scenes/Game.tscn")

func _changeScene(path: String):
	_current_scene.queue_free()
	var s = ResourceLoader.load(path)
	_current_scene = s.instance()
	get_tree().get_root().add_child(_current_scene)
	get_tree().set_current_scene(_current_scene)
	get_tree().change_scene(path)
