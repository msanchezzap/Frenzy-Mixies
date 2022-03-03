extends Node

enum DIRECTIONS {UP=0,RIGHT=1,DOWN=2,LEFT=3}
var allDirections = [DIRECTIONS.UP,DIRECTIONS.RIGHT, DIRECTIONS.DOWN, DIRECTIONS.LEFT]
func GetVector(direction: int):
	match direction:
		DIRECTIONS.UP:
			return Vector2(0,-1)
		DIRECTIONS.RIGHT:
			return Vector2(1,0)
		DIRECTIONS.DOWN:
			return Vector2(0,1)
		DIRECTIONS.LEFT:
			return Vector2(-1,0)
func GetOppositeDirection(direction: int):
	match direction:
		DIRECTIONS.UP:
			return DIRECTIONS.DOWN
		DIRECTIONS.RIGHT:
			return DIRECTIONS.LEFT
		DIRECTIONS.DOWN:
			return DIRECTIONS.UP
		DIRECTIONS.LEFT:
			return DIRECTIONS.RIGHT

func GetDirection(direction: Vector2):
	if direction.x > 0:
		return DIRECTIONS.RIGHT
	elif direction.x < 0:
		return DIRECTIONS.LEFT
	if direction.y > 0:
		return DIRECTIONS.DOWN
	elif direction.y < 0:
		return DIRECTIONS.UP
	return null
