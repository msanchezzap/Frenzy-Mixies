class_name MenuFactory extends Node

func generateMainMenu():
	var menu = _baseMenu()
	_setStartButton(menu, true)
	_setExitButton(menu, true)
	return menu

func generatePauseMenu():
	var menu = _baseMenu()
	_setExitButton(menu, false)
	_setStartButton(menu,false)
	return menu

func generateScoreMenu(score: int):
	var menu = _baseMenu()
	_setExitButton(menu, false)
	_setScore(menu, score)
	return menu

func _setScore(menu, score: int):
	menu.setElementVisibility(menu._gameOverLabel, true)
	menu.setElementVisibility(menu._scoreLabel, true)
	menu.setElementVisibility(menu._scoreNumberLabel, true)
	menu.setScore(score)

func _setStartButton(menu, showStart: bool):
	menu.setElementVisibility(menu._startButton, showStart)
	menu.setElementVisibility(menu._continueButton, !showStart)

func _setExitButton(menu, showExit: bool):
	menu.setElementVisibility(menu._exitButton, showExit)
	menu.setElementVisibility(menu._returnButton, !showExit)

func _baseMenu():
	var men = load("res://Interface/Scenes/Menu.tscn")
	var mainMenu = men.instance()
	return mainMenu
