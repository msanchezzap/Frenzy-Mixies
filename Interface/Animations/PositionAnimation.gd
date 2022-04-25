extends Node

func Colorize(position: Position):
	#var colorCalculated = ColorsService.GetColor(position.square.getColor())
	#if position.isHover && !position.isBoardAnimationInProgress:
	#	colorCalculated += ColorsService.LIGHT
	#if position.isActive || position.square.getHasPotential():
	#	colorCalculated = ColorsService.GetSaturatedColor(position.square.getColor())
	#if position.square.getHasOriginPotential():
	#	colorCalculated = ColorsService.getOriginColor(position.square.getColor())
	#if position.isBoardAnimationInProgress && !position.square.getHasPotential() && !position.square.getHasOriginPotential():
	#	colorCalculated -= colorCalculated * 0.3
	#if position.isConflictPending && position.square.getHasOriginPotential():
	#	colorCalculated = position.modulate
	#	colorCalculated -= ColorsService.getOriginColor(position.square.getColor()) * 0.01
	#	if colorCalculated.r < (ColorsService.getOriginColor(position.square.getColor()) * 0.66).r:
	#		colorCalculated = ColorsService.getOriginColor(position.square.getColor())
	#position.modulate = colorCalculated
	if position.square._type == "explosive":
		position.get_node("AnimatedSprite").set_frame(15)
	elif position.isConflictPending && position.square.getHasOriginPotential():
		var a = position.get_node("AnimatedSprite").get_frame()
	elif position.isActive || position.square.getHasPotential():
		position.get_node("AnimatedSprite").set_frame(position.square.getColor() + 10)
	elif position.isHover && !position.isBoardAnimationInProgress:
		position.get_node("AnimatedSprite").set_frame(position.square.getColor() + 5)

	#	colorCalculated = position.modulate
	#	colorCalculated -= ColorsService.getOriginColor(position.square.getColor()) * 0.01
	#	if colorCalculated.r < (ColorsService.getOriginColor(position.square.getColor()) * 0.66).r:
	#		colorCalculated = ColorsService.getOriginColor(position.square.getColor())
	else: 
		position.get_node("AnimatedSprite").set_frame(position.square.getColor())

func Move(position: Position, speed: int, delta):
	if (position.basePosition - position.position).x < speed/100 && (position.basePosition - position.position).x > -speed/100 && (position.basePosition - position.position).y < speed/100 && (position.basePosition - position.position).y > -speed/100:
		position.position = position.basePosition
	else:
		var direction = (position.basePosition - position.position).normalized()
		position.position += (direction * speed * delta)

func Rotate(position: Position, speed: int):
	if position.rotation_degrees != position.currentRotation:
		if position.rotation_degrees - position.currentRotation <= speed && position.rotation_degrees - position.currentRotation >= - speed:
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
