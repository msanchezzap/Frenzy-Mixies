class_name LinealCleanerTrigger extends Node

var square: SquareComponent
var directions: Array

func _init(squareToApply, horizontal):
	square = squareToApply
	if horizontal == true:
		directions = [Directions.RIGHT, Directions.LEFT]
	elif horizontal == false:
		directions = [Directions.UP, Directions.DOWN]
	else:
		directions = [Directions.UP,Directions.RIGHT, Directions.DOWN, Directions.LEFT]
	
func trigger(destiny: Combination):
	for d in self.directions:
		var tmp = _getAllLineSquares(destiny, destiny.origin, d)
		if tmp != null:
			destiny.members += tmp

func _getAllLineSquares(combination: Combination, currentSquare: Square, direction: int):
	var combinations = []
	if currentSquare == null:
		return []
	if !(currentSquare in combination.getAllSquares()):
		combinations.append(currentSquare)
		return combinations + _getAllLineSquares(combination,currentSquare.getRelation(direction), direction)
	else:
		return _getAllLineSquares(combination,currentSquare.getRelation(direction), direction)
