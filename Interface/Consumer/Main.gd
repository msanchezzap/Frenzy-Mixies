extends Node2D

func init():
	pass
func _ready():
	var mainMenu = MenuFactory.new().generateMainMenu()
	add_child(mainMenu)
