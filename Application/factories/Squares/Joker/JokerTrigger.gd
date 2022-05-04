class_name JokerTrigger extends Node

var square: SquareComponent

func _init(squareToApply):
	square = squareToApply
	
func trigger(destiny: Combination):
	pass#square.reset(randi() % 4)
