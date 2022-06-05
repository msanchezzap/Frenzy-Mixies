extends Node2D

var _current_scene = null
var introPhase = 0
var backgrounds: Array
func _ready():
	backgrounds = [$Background1, $Background2, $Background3, $Background4]
	var root = get_tree().get_root()
	_current_scene = root.get_child(root.get_child_count() - 1)
	for background in backgrounds:
		setBackgroundSize(background)
	var viewportWidth = get_viewport().size.x/4
	_center = Vector2(get_viewport().size.x/2,get_viewport().size.y/2)
	$text.set_margin(MARGIN_LEFT,viewportWidth)
	$text.set_margin(MARGIN_RIGHT,get_viewport().size.x - viewportWidth)
	$text.set_position(Vector2(get_viewport().size.x/2 - (get_viewport().size.x - viewportWidth*2)/2, get_viewport().size.y/1.2))
	
	for i in ["1","2","3","4","5","6","7","8"]:
		get_node(i).set_position(Vector2(get_viewport().size.x /2, get_viewport().size.y/1.2))
	
	$click.set_position(Vector2(get_viewport().size.x / 2.5 , get_viewport().size.y / 1.5))
	$clickmessage.set_position(Vector2(get_viewport().size.x / 2.5 , get_viewport().size.y / 1.8))
	
	$Door.set_position(Vector2(get_viewport().size.x / 2 , get_viewport().size.y / 1.5))
	$Door/CollisionShape2D.set_position(Vector2(0,0))
	
	$item1.set_position(Vector2(get_viewport().size.x / 5 , get_viewport().size.y / 5))
	$item1/CollisionShape2D.set_position(Vector2(0,0))
	$item1/Eb1.set_position(Vector2(0,0))
	$item1/click.set_position(Vector2(-100,0))
	$item1/clickmessage.set_position(Vector2(-100,-100))
	
	$item2.set_position(Vector2(get_viewport().size.x / 5 , get_viewport().size.y / 1.66))
	$item2/CollisionShape2D.set_position(Vector2(0,0))
	$item2/Eb1.set_position(Vector2(0,0))
	$item2/click.set_position(Vector2(-100,0))
	$item2/clickmessage.set_position(Vector2(-100,-100))
	
	$item3.set_position(Vector2(get_viewport().size.x / 1.25 , get_viewport().size.y / 5))
	$item3/CollisionShape2D.set_position(Vector2(0,0))
	$item3/Eb1.set_position(Vector2(0,0))
	$item3/click.set_position(Vector2(-100,0))
	$item3/clickmessage.set_position(Vector2(-100,-100))
	
	$item4.set_position(Vector2(get_viewport().size.x / 1.25 , get_viewport().size.y / 1.66))
	$item4/CollisionShape2D.set_position(Vector2(0,0))
	$item4/Eb1.set_position(Vector2(0,0))
	$item4/click.set_position(Vector2(-100,0))
	$item4/clickmessage.set_position(Vector2(-100,-100))
	
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
		if !IntroConstants.allCommands.has(currentPhase):
			get_node(currentPhase).visible = true
		else:
			match currentPhase:
				IntroConstants.pickStart:
					_enableItems()
				IntroConstants.tutorial:
					_startTutorial()
				IntroConstants.background2:
					_setBackground(2, 0)
				IntroConstants.background2:
					_setBackground(2, 1)
				IntroConstants.background3:
					_setBackground(3, 1)
				IntroConstants.background4:
					_setBackground(4, 1)
	else:
		$text.text = ""
		
const background_name = "Background"
func _setBackground(number, timer):
	var t = Timer.new()
	t.set_wait_time(timer)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
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
	if introPhase < IntroConstants.text.size() -1:
		introPhase += 1
		
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1 && !IntroConstants.allCommands.has(_getCurrentPhase()): 
		nextPhase()

func _getCurrentPhase():
	return IntroConstants.text[introPhase] 

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
		$click.visible = false
		$clickmessage.visible = false
		$Door.visible = false
		nextPhase()
		
func _on_item1_input_event(viewport, event, shape_idx):
	_itemClick($item1, $item1/click, $item1/clickmessage, event)

func _on_item2_input_event(viewport, event, shape_idx):
	_itemClick($item2, $item2/click, $item2/clickmessage, event)

func _on_item3_input_event(viewport, event, shape_idx):
	_itemClick($item3, $item3/click, $item3/clickmessage, event)
	
func _on_item4_input_event(viewport, event, shape_idx):
	_itemClick($item4, $item4/click, $item4/clickmessage, event)

func _itemClick(item, item1, item2, event):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && !itemMovement.has(item):
		nextPhase()
		itemMovement.append(item)
		item1.visible = false
		item2.visible = false
