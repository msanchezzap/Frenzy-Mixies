class_name CauldronTrigger extends Node

var square: SquareComponent

func _init(squareToApply):
	square = squareToApply
	
func trigger(destiny: Combination):
	randomize()
	var distanceX = rand_range(- Config.getConfigValue()/2, Config.getConfigValue()/2)
	var distanceY = rand_range(- Config.getConfigValue()/2, Config.getConfigValue()/2)
	_moveToAffectedSquare(distanceX,distanceY)

func _moveToAffectedSquare(distanceX: int, distanceY: int):
	var directionX = distanceX > 0 if Directions.UP else Directions.DOWN
	var currentSquare = square
	currentSquare = _moveToAffectedSquareLineal(currentSquare.getRelation(directionX), abs(distanceX), directionX)
	var directionY = distanceY > 0 if Directions.RIGHT else Directions.LEFT
	currentSquare = _moveToAffectedSquareLineal(currentSquare.getRelation(directionY), abs(distanceY), directionY)
	currentSquare.setColor(square.getColor())

func _moveToAffectedSquareLineal(currentSquare, distance, direction):
	if distance > 0 && currentSquare.getRelation(direction) != null:
		return _moveToAffectedSquareLineal(currentSquare.getRelation(direction), distance - 1, direction)
	else:
		return currentSquare
