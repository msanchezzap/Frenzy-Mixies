extends Node2D

var animation = 0
const maxAnimation = 3
const text = [
	"In frenzy mixies you need to match 3 or more pieces to get magic points!"
	,"If you match more than 3 pieces, something can happen! Try to make a 2x2 square to make a spell with your wand!"
	,"Thats all, Enjoy this new world!"
]
func _ready():

	notify()
	get_tree().get_root().connect("size_changed", self, "resize")
	setElementPositionAndSize()
	
func setElementPositionAndSize():
	var viewportWidth = get_viewport().size.x
	var viewportHeight = get_viewport().size.y
	$AnimatedSprite.set_position(Vector2(viewportWidth/ 1.1, viewportHeight/ 1.1))
	if get_viewport().size.x < 1920 || get_viewport().size.y < 1080:
		var xx = get_viewport().size.x / 1920
		var yy = get_viewport().size.y / 1080
		var scale = xx
		if yy < xx:
			scale = yy
		var scaleVector = Vector2(scale,scale)
		for i in ["6","7","8"]:
			get_node(i).scale = scaleVector
		$AnimatedSprite.scale = scaleVector
	for i in ["6","7","8"]:
		get_node(i).set_position(Vector2(get_viewport().size.x - (get_node(i).texture.get_width() * get_node(i).scale.x)/2, (get_node(i).texture.get_height() * get_node(i).scale.y)/2 ))

	
func resize():
	setElementPositionAndSize()

func notify():
	if animation <= maxAnimation:
		animation += 1
		$AnimatedSprite.set_animation(str(animation))
		$AnimatedSprite.play()
		if animation <= text.size():
			get_node(str(animation+ 5)).visible = true
		else:
			for i in ["6","7","8"]:
				get_node(i).visible = false
