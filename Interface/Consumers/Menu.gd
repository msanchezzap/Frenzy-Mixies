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

var _size = 1
var viewportWidth
var viewportHeight
func _ready():
	var root = get_tree().get_root()
	_current_scene = root.get_child(root.get_child_count() - 1)
	
	viewportWidth = get_viewport().size.x
	viewportHeight = get_viewport().size.y
	var scale = viewportWidth / $BackgroundBlack.texture.get_size().x
	$BackgroundBlack.set_position(Vector2(viewportWidth/2, viewportHeight/2))
	$BackgroundBlack.set_scale(Vector2(scale, scale))
	
	scale = viewportWidth / $White.texture.get_size().x
	$White.set_position(Vector2(viewportWidth/2, viewportHeight/2))
	$White.set_scale(Vector2(scale / 2, scale / 3))
	for b in [$BackgroundDefeat, $BackgroundSettings, $BackgroundVictory, $BackgroundMain]:
		var scaleX = viewportWidth / b.texture.get_size().x
		var scaleY = viewportHeight / b.texture.get_size().y
		b.set_position(Vector2(viewportWidth/2, viewportHeight/2))
		b.set_scale(Vector2(scaleX , scaleY ))
		
	get_node(_startButton).set_size(Vector2(viewportWidth/3, viewportHeight/6))
	get_node(_startButton).set_position(Vector2(viewportWidth/3, viewportHeight/4))
	get_node(_continueButton).set_size(Vector2(viewportWidth/3, viewportHeight/6))
	get_node(_continueButton).set_position(Vector2(viewportWidth/3, viewportHeight/4))
	
	configureLittleButton(_settingsButton, viewportWidth/3, viewportHeight/2.3)
	configureLittleButton(_returnButtonLevels, viewportWidth/3, viewportHeight/1.6)
	configureLittleButton(_exitButton, viewportWidth/3, viewportHeight/1.4)
	configureLittleButton(_returnButton, viewportWidth/3, viewportHeight/1.4)
	
func configureLittleButton(nodeName, width, height):
	get_node(nodeName).set_size(Vector2(viewportWidth/3, 40))
	get_node(nodeName).set_position(Vector2(width, height))

func setStartButton(showStart: bool):
	get_node(_startButton).visible = showStart
	get_node(_continueButton).visible = !showStart

func setExitButton(showExit: bool):
	get_node(_exitButton).visible = showExit
	get_node(_returnButton).visible = !showExit

func setElementVisibility(element: String, visible: bool):
	get_node(element).visible = visible

func setScore(score: int):
	get_node(_scoreNumberLabel).visible = true
	get_node(_scoreNumberLabel).text = str(score)

func setTitle(text: String):
	get_node(_gameOverLabel).text = text
	
const SETTINGS_BACKGROUND = 0
const VICTORY_BACKGROUND = 1
const DEFEAT_BACKGROUND = 2
const MAIN_BACKGROUND = 3
var currentBackground = null

func setBackground(menuStatus: int):
	if currentBackground != null:
		currentBackground.visible = false
	match menuStatus:
		SETTINGS_BACKGROUND:
			currentBackground = $BackgroundSettings
		VICTORY_BACKGROUND:
			currentBackground = $BackgroundVictory
		DEFEAT_BACKGROUND:
			currentBackground = $BackgroundDefeat
		MAIN_BACKGROUND:
			currentBackground = $BackgroundMain
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
