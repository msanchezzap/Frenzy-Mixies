class_name Menu extends Area2D

var _current_scene = null

const EMPTY = 0
const VICTORY = 1
const LOSE = 2
const SETTINGS = 3

const _backgroundImage: String = "BackgroundImage"
const _startButton: String = "StartButton"
const _continueButton: String = "ContinueButton"
const _exitButton: String = "ExitButton"
const _returnButton: String = "ReturnButton"
const _returnButtonLevels: String = "ReturnButtonLevels"
const _settingsButton: String = "SettingsButton"
const _gameOverLabel: String = "GameOverLabel"
const _scoreLabel: String = "ScoreLabel"
const _scoreNumberLabel: String = "ScoreNumberLabel"
const _boardLabel: String = "BoardLabel"
const _optionButton: String = "OptionButton"
const _boardLabel2: String = "BoardLabel2"
const _boardLabel3: String = "BoardLabel3"
const _lineEdit: String = "LineEdit"
const _lineEdit2: String = "LineEdit2"
const _0star: String = "1s"
const _1star: String = "1s"
const _2star: String = "2s"
const _3star: String = "3s"

var _size = 1
var viewportWidth
var viewportHeight
func _ready():
	var root = get_tree().get_root()
	_current_scene = root.get_child(root.get_child_count() - 1)
	$Area2D3/Bna.visible = false
	$Area2D3/Ba.visible = false
	$Area2D2/Bs.visible = false
	$Area2D2/Bns.visible = false
	get_tree().get_root().connect("size_changed", self, "resize")
	setElementPositionAndSize()

func setElementPositionAndSize():
	var current_size = OS.get_window_size()
	viewportWidth = current_size.x
	viewportHeight = current_size.y
	var scale = viewportWidth / $BackgroundBlack.texture.get_size().x
	$BackgroundBlack.set_position(Vector2(viewportWidth/2, viewportHeight/2))
	$BackgroundBlack.set_scale(Vector2(scale, scale))
	$White.set_position(Vector2(viewportWidth/2, viewportHeight/2.2))
	for b in [$BackgroundDefeat, $BackgroundVictory]:
		b.set_position(Vector2(viewportWidth/2, viewportHeight/2))

	for b in [ $BackgroundMain]:
		var scaleX = viewportWidth / b.texture.get_size().x
		var scaleY = viewportHeight / b.texture.get_size().y
		b.set_position(Vector2(viewportWidth/2, viewportHeight/2))
		b.set_scale(Vector2(scaleX , scaleY ))
		
	$StartButton.set_position(Vector2(viewportWidth/2, viewportHeight/4 ))
	$StartButton/Bp.set_position(Vector2( 0, 0))
	$StartButton/CollisionShape2D.set_position(Vector2( 0, 0))
	
	$ExitButton.set_position(Vector2(viewportWidth/2, viewportHeight/1.4 ))
	$ExitButton/Be.set_position(Vector2( 0, 0))
	$ExitButton/CollisionShape2D.set_position(Vector2( 0, 0))
	
	$ContinueButton.set_position(Vector2(viewportWidth/2, viewportHeight/4 ))
	$ContinueButton/Bre.set_position(Vector2( 0, 0))
	$ContinueButton/CollisionShape2D.set_position(Vector2( 0, 0))
	
	$Area2D3/Ba.set_position(Vector2(viewportWidth/2 + 80, viewportHeight/2 ))
	$Area2D3/Bna.set_position(Vector2(viewportWidth/2 + 80, viewportHeight/2 ))
	$Area2D3/CollisionShape2D.set_position(Vector2(viewportWidth/2 + 80, viewportHeight/2 ))
	$Area2D2/Bs.set_position(Vector2(viewportWidth/2 -80, viewportHeight/2 ))
	$Area2D2/Bns.set_position(Vector2(viewportWidth/2 -80, viewportHeight/2 ))
	$Area2D2/CollisionShape2D.set_position(Vector2(viewportWidth/2 -80, viewportHeight/2 ))
	if result:
		$ReturnButton.set_position(Vector2(viewportWidth/2, viewportHeight/1.4 ))
	else:
		$ReturnButton.set_position(Vector2(viewportWidth/2, viewportHeight/1.6 ))

	$ReturnButton/Br.set_position(Vector2( 0, 0))
	$ReturnButton/CollisionShape2D.set_position(Vector2( 0, 0))
	
	$SettingsButton.set_position(Vector2(viewportWidth/2, viewportHeight/2 ))
	$SettingsButton/Bs.set_position(Vector2( 0, 0))
	$SettingsButton/CollisionShape2D.set_position(Vector2( 0, 0))
	for result in ["1","2","3","4","5","6","7","8","9","10"]:
		get_node(result).set_position(Vector2(viewportWidth/2, viewportHeight/2))

	get_node(_scoreNumberLabel).set_position(Vector2(viewportWidth/2 - 40, viewportHeight/1.7))
	get_node(_0star).set_position(Vector2(viewportWidth/2, viewportHeight/2.4))
	get_node(_1star).set_position(Vector2(viewportWidth/2, viewportHeight/2.4))
	get_node(_2star).set_position(Vector2(viewportWidth/2, viewportHeight/2.4))
	get_node(_3star).set_position(Vector2(viewportWidth/2, viewportHeight/2.4))

func resize():
	setElementPositionAndSize()

func setStartButton(showStart: bool):
	get_node(_startButton).visible = showStart
	get_node(_continueButton).visible = !showStart

func setExitButton(showExit: bool):
	get_node(_exitButton).visible = showExit
	get_node(_returnButton).visible = !showExit
	
var result= false
func setExitResultButton():
	get_node(_returnButton).visible = true
	result = true
	
func setElementVisibility(element: String, visible: bool):
	get_node(element).visible = visible

func setBlack(visibility):
	$BackgroundBlack.visible = visibility
	
func setStars(stars: int):
	match stars:
		0:
			setElementVisibility(_0star, true)
		1:
			setElementVisibility(_1star, true)
		2:
			setElementVisibility(_2star, true)
		3:
			setElementVisibility(_3star, true)
			
func setScore(score: int):
	get_node(_scoreNumberLabel).visible = true
	get_node(_scoreNumberLabel).text = str(score)

func setTitle(text: String):
	get_node(_gameOverLabel).text = text
	
const SETTINGS_BACKGROUND = 0
const VICTORY_BACKGROUND = 1
const DEFEAT_BACKGROUND = 2
const MAIN_BACKGROUND = 3
const PAUSE_BACKGROUND = 4
var currentBackground = null

func setBackground(menuStatus: int):
	if currentBackground != null:
		currentBackground.visible = false
	match menuStatus:
		SETTINGS_BACKGROUND:
			currentBackground = $BackgroundMain
		VICTORY_BACKGROUND:
			currentBackground = $BackgroundVictory
		DEFEAT_BACKGROUND:
			currentBackground = $BackgroundDefeat
		MAIN_BACKGROUND:
			currentBackground = $BackgroundMain
		PAUSE_BACKGROUND:
			currentBackground = $White
	currentBackground.visible = true
	
func _changeScene(path: String):
	_current_scene.queue_free()
	var s = ResourceLoader.load(path)
	_current_scene = s.instance()
	get_tree().get_root().add_child(_current_scene)
	get_tree().set_current_scene(_current_scene)
	get_tree().change_scene(path)

func _on_Button_pressed():
	_changeScene("res://Interface/Scenes/Levels.tscn")
	
func _on_Button2_pressed():
	get_tree().quit()
func _on_ReturnButton_pressed():
	_changeScene("res://Interface/Scenes/Main.tscn")
func _on_ReturnButtonLevels_pressed():
	_changeScene("res://Interface/Scenes/Levels.tscn")
func _on_ContinueButton_pressed():
	self.queue_free()

func _on_SettingsButton_pressed():
	setElementVisibility(_startButton, false)
	setElementVisibility(_continueButton, false)
	setElementVisibility(_settingsButton, false)
	setElementVisibility(_boardLabel, true)
	setElementVisibility(_boardLabel2, true)
	setElementVisibility(_boardLabel3, true)
	setElementVisibility(_optionButton, true)
	setElementVisibility(_lineEdit, true)
	setElementVisibility(_lineEdit2, true)
	get_node(_optionButton).add_item("Small",0)
	get_node(_optionButton).add_item("Medium",1)
	get_node(_optionButton).add_item("Big",2)
	get_node(_optionButton).selected = Config.getConfigIndex()
	get_node(_lineEdit).text = str(Config.getTurns())
	get_node(_lineEdit2).text = str(Config.getScore())
	if MusicScrene.disableMusic:
		$Area2D3/Bna.visible = true
		$Area2D3/Ba.visible = false
	else:
		$Area2D3/Bna.visible = false
		$Area2D3/Ba.visible = true
	if MusicScrene.disableSound:
		$Area2D2/Bns.visible = true
		$Area2D2/Bs.visible = false
	else:
		$Area2D2/Bns.visible = false
		$Area2D2/Bs.visible = true
	setBackground(SETTINGS_BACKGROUND)
	setExitButton(false)

func _on_OptionButton_item_selected(index):
	Config.setConfigIndex(index)

var oldtext = ""
func _on_LineEdit_text_changed(new_text):
	if new_text.is_valid_integer():
		oldtext = new_text
		Config.setTurns(int(new_text))
	else:
		get_node(_lineEdit).text = oldtext
	get_node(_lineEdit).set_cursor_position(get_node(_lineEdit).text.length())

var oldtext2 = ""
func _on_LineEdit2_text_changed(new_text):
	if new_text.is_valid_integer():
		oldtext2 = new_text
		Config.setScore(int(new_text))
	else:
		get_node(_lineEdit2).text = oldtext2
	get_node(_lineEdit2).set_cursor_position(get_node(_lineEdit2).text.length())

func _on_StartButton_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		MusicScrene.playButton()
		_changeScene("res://Interface/Scenes/Levels.tscn")

func _on_ExitButton_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		MusicScrene.playButton()
		get_tree().quit()

func _on_ContinueButton_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		MusicScrene.playButton()
		self.queue_free()

var pressed = false
func _on_ReturnButton_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		MusicScrene.playButton()
		if settingsEnabled:
			settingsEnabled = false
			_changeScene("res://Interface/Scenes/Main.tscn")
		else:
			_changeScene("res://Interface/Scenes/Levels.tscn")
func activateResultBackground():
	if Config.getLevel() == 0:
			get_node("1").visible = true
	else:
		get_node(str(Config.getLevel())).visible = true
	
var settingsEnabled = false
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		MusicScrene.playButton()
		_on_SettingsButton_pressed()
		settingsEnabled = true
		pressed = true


func _on_Area2D3_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.is_pressed() == true:
		MusicScrene.setDisableMusic()
		if MusicScrene.disableMusic:
			$Area2D3/Bna.visible = true
			$Area2D3/Ba.visible = false
		else:
			$Area2D3/Bna.visible = false
			$Area2D3/Ba.visible = true

func _on_Area2D2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.is_pressed() == true:
		MusicScrene.setDisableSound()
		if MusicScrene.disableSound:
			$Area2D2/Bns.visible = true
			$Area2D2/Bs.visible = false
		else:
			$Area2D2/Bns.visible = false
			$Area2D2/Bs.visible = true

