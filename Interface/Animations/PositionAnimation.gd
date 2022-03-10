extends Node

func Colorize(position: Position):
	var colorCalculated = ColorsService.GetColor(position.square.getColor())
	if(position.isHover):
		colorCalculated += ColorsService.LIGHT
	if(position.isActive || position.square.getHasPotential() ):
		colorCalculated = ColorsService.GetSaturatedColor(position.square.getColor())
	if(position.square.getHasOriginPotential()):
		colorCalculated = ColorsService.getOriginColor(position.square.getColor())
	position.modulate = colorCalculated

func Move(position: Position, speed: int, delta):
	if (position.basePosition - position.position).x < speed/100 && (position.basePosition - position.position).x > -speed/100 && (position.basePosition - position.position).y < speed/100 && (position.basePosition - position.position).y > -speed/100:
		position.position = position.basePosition
	else:
		var direction = (position.basePosition - position.position).normalized()
		position.position += (direction * speed * delta)

func Rotate(position: Position, speed: int):
	if position.rotation_degrees != position.currentRotation:
		if position.rotation_degrees - position.currentRotation < speed && position.rotation_degrees - position.currentRotation > - speed:
			position.rotation_degrees = position.currentRotation
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
