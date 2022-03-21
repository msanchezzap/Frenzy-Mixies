extends Area2D

var current_scene = null

func init():
	
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func _on_Button_pressed():
	_changeScene("res://Interface/Scenes/Main.tscn")
	
func _changeScene(path: String):
	current_scene.queue_free()
	# Load the new scene.
	var s = ResourceLoader.load(path)
	# Instance the new scene.
	current_scene = s.instance()
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
	get_tree().change_scene(path)

func _on_Button2_pressed():
	get_tree().quit()


func _on_ReturnButton_pressed():
	current_scene.queue_free()


func _on_ContinueButton_pressed():
	pass # Replace with function body.
