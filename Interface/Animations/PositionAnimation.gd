extends Node

func Execute(position: Position, speed: int, delta):
	if (position.basePosition - position.position).x < speed/100 && (position.basePosition - position.position).x > -speed/100 && (position.basePosition - position.position).y < speed/100 && (position.basePosition - position.position).y > -speed/100:
		position.position = position.basePosition
	else:
		var direction = (position.basePosition - position.position).normalized()
		position.position += (direction * speed * delta)
