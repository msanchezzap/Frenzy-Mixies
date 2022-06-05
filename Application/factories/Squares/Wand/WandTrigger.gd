class_name WandTrigger extends Node

var square: SquareComponent
var conditionService : ConditionsService

func _init(squareToApply, conditionService):
	square = squareToApply
	self.conditionService = conditionService
	
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
	currentSquare.setColor(_getImportantColor())

func _getImportantColor():
	var colorImportant = { color= -1, status= 99}
	for c in  conditionService._conditions:
		if c is ColorCondition:
			var colorStatus = c.check()
			if colorStatus < colorImportant.status:
				colorImportant.color = c._color
				colorImportant.status = c.check()
	if colorImportant.color != -1:
		return colorImportant.color
	return randi() % Config.getColorQuantity()

func _moveToAffectedSquareLineal(currentSquare, distance, direction):
	if distance > 0 && currentSquare.getRelation(direction) != null:
		return _moveToAffectedSquareLineal(currentSquare.getRelation(direction), distance - 1, direction)
	else:
		return currentSquare
