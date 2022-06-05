extends Node

const POSITION_SIZE = 150
const EXPLOSIVE_FRAME = 28
const ORIGIN_FRAME = 21
const POTENTIAL_FRAME = 14
const HOVE_FRAME = 7

const ANIMATED_SPRITE = "AnimatedSprite"
const EXPLOSION_ANIMATION = "Explosion"
const EXPLOSIVE_ANIMATION = "Explosive"
const BASIC_ANIMATION = "Basic"
const HOVER_ANIMATION = "Hover"
const ORIGIN_ANIMATION = "Origin"
const SELECTED_ANIMATION = "Selected"
const JOKER_ANIMATION = "Joker"
const LOCKER_ANIMATION = "Locker"
const LINE_HORIZONTAL = "LineHorizontal"
const LINE_VERTICAL = "LineVertical"
const LINE_DOUBLE = "LineDouble"

func Colorize(position: Position):
	var sprite = position.get_node(ANIMATED_SPRITE)
	if position.specialAnimation == "explosion":
		var explosionAnimation = EXPLOSION_ANIMATION + "_" + str(position.square.getColor())
		if sprite.get_animation() != explosionAnimation:
			sprite.play(explosionAnimation)
		if sprite.get_frame() == sprite.frames.get_frame_count(EXPLOSION_ANIMATION + "_" + str(position.square.getColor())) -1:
			position.specialAnimation = ""
		return
	if  position.square._type != null:
		match position.square._type:
			SquareComponent.LINE_HORIZONTAL:
				_setAnimation(sprite, LINE_HORIZONTAL, position.square.getColor())
			SquareComponent.LINE_VERTICAL:
				_setAnimation(sprite, LINE_VERTICAL, position.square.getColor())
			SquareComponent.LINE_DOUBLE:
				_setAnimation(sprite, LINE_DOUBLE, position.square.getColor())
			SquareComponent.TYPE_EXPLOSIVE:
				_setAnimation(sprite, EXPLOSIVE_ANIMATION, position.square.getColor())
			SquareComponent.TYPE_LOCKER:
				_setAnimation(sprite, LOCKER_ANIMATION, position.square.getColor())
	elif position.square.getColor() == Colors.JOKER:
		if sprite.get_animation() != JOKER_ANIMATION:
			sprite.play(JOKER_ANIMATION)
	elif position.square.getHasOriginPotential():
		_setAnimation(sprite, ORIGIN_ANIMATION, position.square.getColor())
	elif (position.isActive || position.square.getHasPotential()):
		_setAnimation(sprite, SELECTED_ANIMATION, position.square.getColor())
	elif position.isHover && !position.isBoardAnimationInProgress:
		_setAnimation(sprite,HOVER_ANIMATION, position.square.getColor())
	else:
		_setAnimation(sprite,BASIC_ANIMATION, position.square.getColor()) 
		
func _setAnimation(sprite: AnimatedSprite, animation, color):
	if !(sprite.get_animation() == animation && sprite.get_frame() == color):
		sprite.stop()
		sprite.set_animation(animation)
		sprite.set_frame(color)
	
func Move(position: Position, speed: int, delta):
	if position.square.getType() == SquareComponent.OLD_TYPE_LOCKER:
		position.position = position.basePosition
		position.square._type = null
	if ((position.basePosition - position.position).x < speed/POSITION_SIZE 
		&& (position.basePosition - position.position).x > -speed/POSITION_SIZE 
		&& (position.basePosition - position.position).y < speed/POSITION_SIZE 
		&& (position.basePosition - position.position).y > -speed/POSITION_SIZE
	):
		position.position = position.basePosition
	else:
		var gg = position.basePosition - position.position
		var direction = (position.basePosition - position.position).normalized()
		var a =  (direction * speed * delta)
		if gg.x > 0 && gg.x < a.x || gg.x < 0 && gg.x > -a.x || gg.y > 0 && gg.y < a.y || gg.y < 0 && gg.y > -a.y:
			position.position = position.basePosition
		position.position += (direction * speed * delta)

func Rotate(position: Position, speed: int):
	if position.rotation_degrees != position.currentRotation:
		if (position.rotation_degrees - position.currentRotation <= speed 
			&& position.rotation_degrees - position.currentRotation >= - speed
		):
			position.currentRotation = 0
			position.rotation_degrees = 0
		else:
			position.rotation_degrees += speed

func Scale(position: Position, defaultScale: Vector2, speed: Vector2):
	if position.currentScale == defaultScale:
		position.scale = position.currentScale
	if position.scale != position.currentScale:
		if position.scale - position.currentScale < speed:
			position.currentScale = position.scale
		else:
			position.scale -= speed
