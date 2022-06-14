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
	$ObjectivesValue.set_position(Vector2(get_viewport().size.x/ 8 - 50, 20 + 240))
	$TurnsLeftValue.set_position(Vector2(get_viewport().size.x/ 8 - 25, 20 + 460))
	$ScoreValue.set_position(Vector2(get_viewport().size.x/ 8 - 20, 20 + 660))
	$"0s".set_position(Vector2(get_viewport().size.x/ 8 - 8, 20 + 880))
	$"1s".set_position(Vector2(get_viewport().size.x/ 8 - 8, 20 + 880))
	$"2s".set_position(Vector2(get_viewport().size.x/ 8 - 8, 20 + 880))
	$"3s".set_position(Vector2(get_viewport().size.x/ 8 - 8, 20 + 880))
	
	$Black66.set_position(Vector2(get_viewport().size.x/ 8 - 65, 20 + 790))
	$Black67.set_position(Vector2(get_viewport().size.x/ 8 + 34, 20 + 790))
	$Black68.set_position(Vector2(get_viewport().size.x/ 8 + 34 + 97, 20 + 790))

	$socre1.set_position(Vector2(get_viewport().size.x/ 8 - 88, 20 + 880))
	$socre2.set_position(Vector2(get_viewport().size.x/ 8 - 8, 20 + 880))
	$socre3.set_position(Vector2(get_viewport().size.x/ 8 + 80, 20 + 880))

	get_tree().get_root().connect("size_changed", self, "resize")
	setElementPositionAndSize()
	
func setElementPositionAndSize():
	var positionX = OS.get_window_size().x
	var positionY = OS.get_window_size().y
	$AnimatedSprite.get_sprite_frames()
	var scoreBoardSize = $AnimatedSprite.get_sprite_frames().get_frame("default",0).get_size()
	if scoreBoardSize.y > positionY:
		var scale = OS.get_window_size().y/ scoreBoardSize.y
		$AnimatedSprite.scale.y = scale
		$AnimatedSprite.scale.x = scale
		scoreBoardSize = $AnimatedSprite.get_sprite_frames().get_frame("default",0).get_size()
	else:
		$AnimatedSprite.scale.y = 1
		$AnimatedSprite.scale.x = 1
		scoreBoardSize = $AnimatedSprite.get_sprite_frames().get_frame("default",0).get_size()

	var scoreBoardRealSizeX = scoreBoardSize.x * $AnimatedSprite.scale.x
	var scoreBoardRealSizeY = scoreBoardSize.y * $AnimatedSprite.scale.y
	$AnimatedSprite.set_position(Vector2(scoreBoardRealSizeX/2, scoreBoardRealSizeY/2))
	$ObjectivesValue.set_position(Vector2(scoreBoardRealSizeX/4, scoreBoardRealSizeY/4.5))
	$TurnsLeftValue.set_position(Vector2(scoreBoardRealSizeX/3, scoreBoardRealSizeY/2.25))
	$ScoreValue.set_position(Vector2(scoreBoardRealSizeX/2.5 , scoreBoardRealSizeY/1.5))

	if scoreBoardRealSizeX/5 < 20:
		$ObjectivesValue.get("custom_fonts/font").size = 10
		$TurnsLeftValue.get("custom_fonts/font").size = 20
		$ScoreValue.get("custom_fonts/font").size = 20
	elif scoreBoardRealSizeX/5 < 35:
		$ObjectivesValue.get("custom_fonts/font").size = 15
		$TurnsLeftValue.get("custom_fonts/font").size = 35
		$ScoreValue.get("custom_fonts/font").size = 35
	else:
		$ObjectivesValue.get("custom_fonts/font").size = 20
		$TurnsLeftValue.get("custom_fonts/font").size = 50
		$ScoreValue.get("custom_fonts/font").size = 50

	var starWidth = 63
	if $Black66 != null:
		starWidth = $Black66.get_texture().get_width()
		print("AA")
	$Black66.set_position(Vector2(scoreBoardRealSizeX/2 - starWidth, 20 + 790))
	$Black67.set_position(Vector2(scoreBoardRealSizeX/2 + 34, 20 + 790))
	$Black68.set_position(Vector2(scoreBoardRealSizeX/2 + 34 + 97, 20 + 790))
	
	if $socre1 != null:
		if scoreBoardRealSizeX/3 < $socre1.get_texture().get_size().x ||  scoreBoardRealSizeY/5 < $socre1.get_texture().get_size().y:
			var newScale = (scoreBoardRealSizeX/3)/$socre1.get_texture().get_size().x
			$socre1.scale.x = newScale
			$socre1.scale.y = newScale
			$socre2.scale.x = newScale
			$socre2.scale.y = newScale
			$socre3.scale.x = newScale
			$socre3.scale.y = newScale
		else:
			$socre1.scale.x = 1
			$socre1.scale.y = 1
	var starRealWidthX = $socre1.get_texture().get_size().x * (scoreBoardRealSizeX/3)/$socre1.get_texture().get_size().x
	var starRealWidthY = $socre1.get_texture().get_size().x * (scoreBoardRealSizeX/3)/$socre1.get_texture().get_size().x
	$socre1.set_position(Vector2(scoreBoardRealSizeX/2 - starRealWidthX, scoreBoardRealSizeY/ 1.10))
	$socre2.set_position(Vector2(scoreBoardRealSizeX/2 , scoreBoardRealSizeY/ 1.10))
	$socre3.set_position(Vector2(scoreBoardRealSizeX/2 + starRealWidthX, scoreBoardRealSizeY/ 1.10))

func resize():
	setElementPositionAndSize()

func _physics_process(delta):
	if destinyScore != currentScore:
		currentScore += 1
		$ScoreValue.text = str(currentScore) 

func changeStars(stars):
	while stars > 0:
		get_node("socre"+str(stars)).visible = true
		get_node("Black6" + str(5 + stars)).visible = true
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

const ICON_SIZE: int = 50
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
	b.set_position(Vector2(get_viewport().size.x/ 8 - 50 - ICON_SIZE, 200 + (iteration) * ICON_SIZE ))
	
