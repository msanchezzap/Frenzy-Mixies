extends Node2D

func init():
	pass
func _ready():
	var men = load("res://Interface/Scenes/Menu.tscn")
	var mainMenu = men.instance()
	mainMenu.setStartButton(true)
	mainMenu.setExitButton(true)
	add_child(mainMenu)
