extends Area2D

var _current_scene = null
const _startButton: String = "StartButton"
const _continueButton: String = "ContinueButton"
const _exitButton: String = "ExitButton"
const _returnButton: String = "ReturnButton"
const _gameOverLabel: String = "GameOverLabel"
const _scoreLabel: String = "ScoreLabel"
const _scoreNumberLabel: String = "ScoreNumberLabel"

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
