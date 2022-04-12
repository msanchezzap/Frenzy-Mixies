extends Area2D

var _current_scene = null
const _startButton: String = "StartButton"
const _continueButton: String = "ContinueButton"
const _exitButton: String = "ExitButton"
const _returnButton: String = "ReturnButton"
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

func _ready():
	var root = get_tree().get_root()
	_current_scene = root.get_child(root.get_child_count() - 1)

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

func _changeScene(path: String):
	_current_scene.queue_free()
	var s = ResourceLoader.load(path)
	_current_scene = s.instance()
	get_tree().get_root().add_child(_current_scene)
	get_tree().set_current_scene(_current_scene)
	get_tree().change_scene(path)

func _on_Button_pressed():
	_changeScene("res://Interface/Scenes/Game.tscn")
	_current_scene.start()
func _on_Button2_pressed():
	get_tree().quit()
func _on_ReturnButton_pressed():
	_changeScene("res://Interface/Scenes/Main.tscn")
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
