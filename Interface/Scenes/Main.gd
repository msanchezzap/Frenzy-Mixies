extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func init():
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	var men = load("res://Interface/Scenes/Menu.tscn")
	var mainMenu = men.instance()
	mainMenu.setStartButton(true)
	mainMenu.setExitButton(true)
	add_child(mainMenu)
