class_name ExplosiveTrigger extends Node

var square: SquareComponent

func _init(squareToApply):
	square = squareToApply
	
func trigger(destiny: Combination):
	for d in DirectionsService.getAllDirections():
		var tmp = _getNextNoCombinationSquare(destiny, destiny.origin, d)
		if tmp != null:
			destiny.members.append(tmp)

func _getNextNoCombinationSquare(combination: Combination, currentSquare: Square, direction: int):
	if currentSquare == null:
		return null
	if !(currentSquare in combination.getAllSquares()):
		return currentSquare
	return _getNextNoCombinationSquare(combination, currentSquare.getRelation(direction), direction)
