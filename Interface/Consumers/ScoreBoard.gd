extends Area2D

var currentScore = 0
var destinyScore = 0
var turnsLeft = 0
var baseX
var baseY
func _ready():
	baseX = get_viewport().size.x/1.3
	baseY = get_viewport().size.y/7
	if get_viewport().size.x < 999:
		baseX = get_viewport().size.x/2 - 30
		baseY = get_viewport().size.y/1.25

	$AnimatedSprite.set_frame(Config.getLevel() -1)
	$AnimatedSprite.set_position(Vector2(get_viewport().size.x/ 8, 977 /2 + 20))
	$ObjectivesValue.set_position(Vector2(get_viewport().size.x/ 8 - 50, 20 + 260))
	$TurnsLeftValue.set_position(Vector2(get_viewport().size.x/ 8 - 25, 20 + 460))
	$ScoreValue.set_position(Vector2(get_viewport().size.x/ 8 - 20, 20 + 660))
	$"0s".set_position(Vector2(get_viewport().size.x/ 8 - 8, 20 + 880))
	$"1s".set_position(Vector2(get_viewport().size.x/ 8 - 8, 20 + 880))
	$"2s".set_position(Vector2(get_viewport().size.x/ 8 - 8, 20 + 880))
	$"3s".set_position(Vector2(get_viewport().size.x/ 8 - 8, 20 + 880))
	
	$socre1.set_position(Vector2(get_viewport().size.x/ 8 - 88, 20 + 880))
	$socre2.set_position(Vector2(get_viewport().size.x/ 8 - 8, 20 + 880))
	$socre3.set_position(Vector2(get_viewport().size.x/ 8 + 80, 20 + 880))


func _physics_process(delta):
	if destinyScore != currentScore:
		currentScore += 1
		$ScoreValue.text = str(currentScore) 

func changeStars(stars):
	while stars > 0:
		get_node("socre"+str(stars)).visible = true
		stars -=1
	
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
	b.set_position(Vector2(get_viewport().size.x/ 8 - 50 - ICON_SIZE, 20 + 260 + (iteration + 2) * ICON_SIZE ))
	
