extends Node

func getAllDirections():
	return [Directions.UP,Directions.RIGHT, Directions.DOWN, Directions.LEFT]

func GetVector(direction: int):
	match direction:
		Directions.UP:
			return Vector2(0,-1)
		Directions.RIGHT:
			return Vector2(1,0)
		Directions.DOWN:
			return Vector2(0,1)
		Directions.LEFT:
			return Vector2(-1,0)
func GetOppositeDirection(direction: int):
	match direction:
		Directions.UP:
			return Directions.DOWN
		Directions.RIGHT:
			return Directions.LEFT
		Directions.DOWN:
			return Directions.UP
		Directions.LEFT:
			return Directions.RIGHT

func GetDirection(direction: Vector2):
	if direction.x > 0:
		return Directions.RIGHT
	elif direction.x < 0:
		return Directions.LEFT
	if direction.y > 0:
		return Directions.DOWN
	elif direction.y < 0:
		return Directions.UP
	return null
