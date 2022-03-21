extends Area2D

var _current_scene = null
var _startButton: String = "StartButton"
var _continueButton: String = "ContinueButton"
var _exitButton: String = "ExitButton"
var _returnButton: String = "ReturnButton"

func _ready():
	var root = get_tree().get_root()
	_current_scene = root.get_child(root.get_child_count() - 1)

func setStartButton(showStart: bool):
	get_node(_startButton).visible = showStart
	get_node(_continueButton).visible = !showStart

func setExitButton(showExit: bool):
	get_node(_exitButton).visible = showExit
	get_node(_returnButton).visible = !showExit

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
