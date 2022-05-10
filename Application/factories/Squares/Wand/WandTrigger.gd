class_name WandTrigger extends Node

var square: SquareComponent

func _init(squareToApply):
	square = squareToApply
	
func trigger(destiny: Combination):
	var distanceX = (randi() % (Config.getConfigValue()*2)) - Config.getConfigValue() 
	var distanceY = (randi() % (Config.getConfigValue()*2)) - Config.getConfigValue()  
	_moveToAffectedSquare(distanceX,distanceY)
	square._triggerFunction = null

func _moveToAffectedSquare(distanceX: int, distanceY: int):
	var directionX = distanceX > 0 if Directions.UP else Directions.DOWN
	var currentSquare = square
	currentSquare = _moveToAffectedSquareLineal(currentSquare, abs(distanceX), directionX)
	var directionY = distanceY > 0 if Directions.RIGHT else Directions.LEFT
	currentSquare = _moveToAffectedSquareLineal(currentSquare, abs(distanceY), directionY)
	currentSquare.setColor(5)

func _moveToAffectedSquareLineal(currentSquare, distance, direction):
	if distance > 0 && currentSquare.getRelation(direction) != null:
		return _moveToAffectedSquareLineal(currentSquare.getRelation(direction), distance - 1, direction)
	else:
		return currentSquare
