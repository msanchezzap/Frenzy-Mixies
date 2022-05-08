class_name MenuFactory extends Node

func generateMainMenu():
	var menu: Menu
	menu = _baseMenu()
	_setStartButton(menu, true)
	_setExitButton(menu, true)
	#_setSettingsButton(menu)
	menu.setBackground(Menu.MAIN_BACKGROUND)
	return menu

func generatePauseMenu():
	var menu = _baseMenu()
	_setExitButton(menu, false)
	_setStartButton(menu,false)
	menu.setElementVisibility(Menu._returnButtonLevels, true)
	menu.setBackground(Menu.PAUSE_BACKGROUND)
	return menu

func generateGameOverMenu(score: int):
	var menu: Menu = _generateScoreMenu(score)
	menu.setBackground(Menu.DEFEAT_BACKGROUND)
	return menu 

func generateWinMenu(score: int):
	var menu = _generateScoreMenu(score)
	menu.setBackground(Menu.VICTORY_BACKGROUND)
	return menu
func generateSettingsMenu(menu):
	menu.setElementVisibility(Menu._startButton, false)
	menu.setElementVisibility(Menu._continueButton, false)
	menu.setElementVisibility(Menu._settingsButton, false)
	menu.setElementVisibility(Menu._boardLabel, true)
	menu.setElementVisibility(Menu._boardLabel2, true)
	menu.setElementVisibility(Menu._boardLabel3, true)
	menu.setElementVisibility(Menu._optionButton, true)
	menu.setElementVisibility(Menu._lineEdit, true)
	menu.setElementVisibility(Menu._lineEdit2, true)
	menu.get_node(Menu._optionButton).add_item("Small",0)
	menu.get_node(Menu._optionButton).add_item("Medium",1)
	menu.get_node(Menu._optionButton).add_item("Big",2)
	menu.get_node(Menu._optionButton).selected = Config.getConfigIndex()
	menu.get_node(Menu._lineEdit).text = str(Config.getTurns())
	menu.get_node(Menu._lineEdit2).text = str(Config.getScore())
	menu.setBackground(Menu.SETTINGS_BACKGROUND)
	menu.setExitButton(false)
	
func _generateScoreMenu(score: int):
	var menu = _baseMenu()
	menu.setElementVisibility(menu._returnButtonLevels, true)
	_setScore(menu, score)
	return menu

func _setScore(menu, score: int):
	menu.setElementVisibility(menu._scoreLabel, true)
	menu.setElementVisibility(menu._scoreNumberLabel, true)
	menu.setScore(score)

func _setStartButton(menu, showStart: bool):
	menu.setStartButton(showStart)

func _setExitButton(menu, showExit: bool):
	menu.setElementVisibility(menu._exitButton, showExit)
	menu.setElementVisibility(menu._returnButton, !showExit)

func _setSettingsButton(menu):
	menu.setElementVisibility(menu._settingsButton, true)

func _baseMenu():
	var men = load("res://Interface/Scenes/Components/Menu.tscn")
	var mainMenu = men.instance()
	return mainMenu
