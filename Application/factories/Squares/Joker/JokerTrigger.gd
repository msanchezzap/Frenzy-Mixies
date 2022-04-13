class_name JokerTrigger extends Node

var square: SquareComponent

func _init(squareToApply):
	square = squareToApply
	
func trigger(destiny: Combination):
	if square.getCombinations().size() == 0 && square.getHasOriginPotential():
		square.reset(randi() % 4)
