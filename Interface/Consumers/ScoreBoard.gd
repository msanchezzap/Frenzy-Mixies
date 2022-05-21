extends Area2D

var currentScore = 0
var destinyScore = 0
var turnsLeft = 0
func _ready():
	$Score.set_position(Vector2(get_viewport().size.x/1.3, get_viewport().size.y/7))
	$ScoreValue.set_position(Vector2(get_viewport().size.x/1.2, get_viewport().size.y/7))
	$TurnsLeft.set_position(Vector2(get_viewport().size.x/1.3, get_viewport().size.y/5.5))
	$TurnsLeftValue.set_position(Vector2(get_viewport().size.x/1.2, get_viewport().size.y/5.5))
	$Objectives.set_position(Vector2(get_viewport().size.x/1.3, get_viewport().size.y/4.5))
	$ObjectivesValue.set_position(Vector2(get_viewport().size.x/1.2, get_viewport().size.y/4.5))
	
func _physics_process(delta):
	if destinyScore != currentScore:
		currentScore += 1
		$ScoreValue.text = str(currentScore) 
	
func changeScore(newScore: int):
	destinyScore = newScore
	
func changeTurn(turn: int):
	turnsLeft = str(turn)
	$TurnsLeftValue.text = turnsLeft
	
func changeObjectives(objectives: Array):
	var result = "\n"
	var iteration = 1
	for o in objectives:
		if o[0].find("color") != -1:
			_createIcon("default", int(o[0].right(o[0].length()-1)) + 1, iteration)
		if o[0].find("locker") != -1:
			_createIcon("Locker", int(o[0].right(o[0].length()-1)) + 1, iteration)
		result += " " + o[0] + ": " + str(o[1]) + "/" + str(o[2]) + "\n"
		iteration += 1
	$ObjectivesValue.text = result

const ICON_SIZE: int = 15
func _createIcon(type: String, color: int, iteration: int):
	var root = get_tree().get_root()
	var _current_scene = root.get_child(root.get_child_count() - 1)
	var b = TextureButton.new()
	_current_scene.add_child(b)
	var image: Image  = Image.new()
	image.load("res://Interface/resources/Positions/"+ type +"/" + str(color) +".png")
	image.resize(ICON_SIZE,ICON_SIZE)
	var itex = ImageTexture.new()
	itex.create_from_image(image)
	b.texture_normal = itex
	b.set_name(str(iteration))
	b.set_position(Vector2(get_viewport().size.x/1.2 - ICON_SIZE, get_viewport().size.y/4.5 + iteration * ICON_SIZE + 2))
	
