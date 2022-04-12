class_name MenuFactory extends Node

const WIN = "Win"

func generateMainMenu():
	var menu = _baseMenu()
	_setStartButton(menu, true)
	_setExitButton(menu, true)
	_setSettingsButton(menu)
	return menu

func generatePauseMenu():
	var menu = _baseMenu()
	_setExitButton(menu, false)
	_setStartButton(menu,false)
	return menu

func generateGameOverMenu(score: int):
	return _generateScoreMenu(score)

func generateWinMenu(score: int):
	var menu = _generateScoreMenu(score)
	menu.setTitle(WIN)
	return menu

func _generateScoreMenu(score: int):
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

func _setSettingsButton(menu):
	menu.setElementVisibility(menu._settingsButton, true)

func _baseMenu():
	var men = load("res://Interface/Scenes/Menu.tscn")
	var mainMenu = men.instance()
	return mainMenu
