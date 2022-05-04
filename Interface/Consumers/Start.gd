extends Node2D

var _current_scene = null
const path = "res://Interface/Scenes/Main.tscn"
func _ready():
	setBackgroundSize()
	var root = get_tree().get_root()
	_current_scene = root.get_child(root.get_child_count() - 1)

func setBackgroundSize():
	var viewportWidth = get_viewport().size.x
	var viewportHeight = get_viewport().size.y
	var scale = viewportWidth / $Area2D/Background.texture.get_size().x
	$Area2D/Background.set_position(Vector2(viewportWidth/2, viewportHeight/2))
	$Area2D/Background.set_scale(Vector2(scale, scale))
	
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		_current_scene.queue_free()
		var s = ResourceLoader.load(path)
		_current_scene = s.instance()
		get_tree().get_root().add_child(_current_scene)
		get_tree().set_current_scene(_current_scene)
		get_tree().change_scene(path)
