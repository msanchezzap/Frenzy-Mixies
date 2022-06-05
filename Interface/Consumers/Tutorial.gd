extends Node2D

var animation = 0
const maxAnimation = 3
const text = [
	"In frenzy mixies you need to match 3 or more pieces to get magic points!"
	,"If you match more than 3 pieces, something can happen! Try to make a 2x2 square to make a spell with your wand!"
	,"Thats all, Enjoy this new world!"
]
func _ready():
	var viewportWidth = get_viewport().size.x
	var viewportHeight = get_viewport().size.y
	$AnimatedSprite.set_position(Vector2(viewportWidth/ 1.2, viewportHeight/ 1.2))
	$RichTextLabel.set_margin(MARGIN_LEFT,viewportWidth/4)
	$RichTextLabel.set_margin(MARGIN_RIGHT,viewportWidth- viewportWidth /4)
	$RichTextLabel.set_position(Vector2(get_viewport().size.x/2 - (get_viewport().size.x - viewportWidth/4*2)/2, get_viewport().size.y/1.2))
	notify()

func notify():
	if animation <= maxAnimation:
		animation += 1
		$AnimatedSprite.set_animation(str(animation))
		$AnimatedSprite.play()
		if animation <= text.size():
			$RichTextLabel.text = text[animation -1]
