extends Node2D

const doorClick = "doorClick"
const standardClick = "standardClick"
const tutorial = "tutorial"
const pickStart = "pickStart"
const pick = "pick"
const background2 = "background2"
const allCommands = [doorClick, standardClick, tutorial, pickStart, pick, background2]

const text = [
	doorClick, background2
	, "Wait… What's happening here?"
	, "Mmm…It seems I need to pick up all of these things."
	, pickStart, pick, pick, pick
	, "Hi sweetie! Welcome to Frenzy Mixes, my name is Sparky and let me introduce you in this awesome place where you could make."
	, "So let’s start!"
	, tutorial
]

var _current_scene = null
var introPhase = 0
var backgrounds: Array
func _ready():
	backgrounds = [$Background1, $Background2]
	var root = get_tree().get_root()
	_current_scene = root.get_child(root.get_child_count() - 1)
	for background in backgrounds:
		setBackgroundSize(background)
	var viewportWidth = get_viewport().size.x/4
	_center = Vector2(get_viewport().size.x/2,get_viewport().size.y/2)
	$text.set_margin(MARGIN_LEFT,viewportWidth)
	$text.set_margin(MARGIN_RIGHT,get_viewport().size.x - viewportWidth)
	$text.set_position(Vector2(get_viewport().size.x/2 - (get_viewport().size.x - viewportWidth*2)/2, get_viewport().size.y/1.2))
	
	$Door.set_position(Vector2(get_viewport().size.x / 2 , get_viewport().size.y / 1.2))
	$Door/CollisionShape2D.set_position(Vector2(0,0))
	$Door/Eb1.set_position(Vector2(0,0))
	
	$item1.set_position(Vector2(get_viewport().size.x / 5 , get_viewport().size.y / 5))
	$item1/CollisionShape2D.set_position(Vector2(0,0))
	$item1/Eb1.set_position(Vector2(0,0))
	
	$item2.set_position(Vector2(get_viewport().size.x / 5 , get_viewport().size.y / 1.66))
	$item2/CollisionShape2D.set_position(Vector2(0,0))
	$item2/Eb1.set_position(Vector2(0,0))
	
	$item3.set_position(Vector2(get_viewport().size.x / 1.25 , get_viewport().size.y / 5))
	$item3/CollisionShape2D.set_position(Vector2(0,0))
	$item3/Eb1.set_position(Vector2(0,0))
	
	$item4.set_position(Vector2(get_viewport().size.x / 1.25 , get_viewport().size.y / 1.66))
	$item4/CollisionShape2D.set_position(Vector2(0,0))
	$item4/Eb1.set_position(Vector2(0,0))
	
var lastPhase = -1
var itemMovement: Array = []
func _physics_process(delta):
	if introPhase != lastPhase:
		lastPhase = introPhase
		triggerPhase()
	_moveItems()

func triggerPhase():
	var currentPhase = _getCurrentPhase()
	if currentPhase != null:
		if !allCommands.has(currentPhase):
			$text.text = currentPhase
		else:
			$text.text = ""
			match currentPhase:
				pickStart:
					_enableItems()
				tutorial:
					_startTutorial()
				background2:
					_setBackground(2)
	else:
		$text.text = ""
const background_name = "Background"
func _setBackground(number):
	for background in backgrounds:
		background.visible = false
	get_node(background_name + str(number)).visible = true
	nextPhase()
	
func _moveItems():
	for item in itemMovement:
		if !moveItem(item):
			itemMovement.erase(item)

func setBackgroundSize(background):
	var viewportWidth = get_viewport().size.x
	var viewportHeight = get_viewport().size.y
	var scale = viewportWidth / background.texture.get_size().x
	var scaley = viewportHeight / background.texture.get_size().y
	background.set_position(Vector2(viewportWidth/2, viewportHeight/2))
	background.set_scale(Vector2(scale, scaley))

var _center
const speed = 7
func moveItem(item):
	var gg = item.get_position()
	gg.x = _moveAxis(gg.x, _center.x)
	gg.y = _moveAxis(gg.y, _center.y)
	if gg.x == _center.x && gg.y == _center.y:
		item.visible = false
		return false
	item.set_position(gg)
	return true

func _moveAxis(gg, center):
	var tmp = gg
	if tmp < center:
		tmp += speed
	elif tmp > center:
		tmp -= speed
	if tmp > center && tmp - center <= speed || tmp < center && center + tmp <= speed:
		tmp = center
	return tmp

func nextPhase():
	if introPhase < text.size() -1:
		introPhase += 1
		
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1 && !allCommands.has(_getCurrentPhase()): 
		nextPhase()

func _getCurrentPhase():
	return text[introPhase] 

func _enableItems():
	$item1.visible = true
	$item2.visible = true
	$item3.visible = true
	$item4.visible = true

const pathMain = "res://Interface/Scenes/Main.tscn"
func _goToMainScene():
	_current_scene.queue_free()
	var s = ResourceLoader.load(pathMain)
	_current_scene = s.instance()
	get_tree().get_root().add_child(_current_scene)
	get_tree().set_current_scene(_current_scene)
	get_tree().change_scene(pathMain)

const pathGame = "res://Interface/Scenes/Game.tscn"
func _startTutorial():
	Config.setLevel(0)
	_current_scene.queue_free()
	var s = ResourceLoader.load(pathGame)
	_current_scene = s.instance()
	get_tree().get_root().add_child(_current_scene)
	get_tree().set_current_scene(_current_scene)
	get_tree().change_scene(pathGame)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		$Door.visible = false
		nextPhase()
		
func _on_item1_input_event(viewport, event, shape_idx):
	_itemClick($item1, event)

func _on_item2_input_event(viewport, event, shape_idx):
	_itemClick($item2, event)

func _on_item3_input_event(viewport, event, shape_idx):
	_itemClick($item3, event)

func _on_item4_input_event(viewport, event, shape_idx):
	_itemClick($item4, event)

func _itemClick(item, event):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && !itemMovement.has(item):
		nextPhase()
		itemMovement.append(item)
