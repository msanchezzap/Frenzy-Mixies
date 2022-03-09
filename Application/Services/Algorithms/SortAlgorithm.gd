extends Node

func Execute(origin: Square, direction):
	if origin.getRelation(direction) != null:
		var nextPosition = origin.getRelation(direction)
		SquareService.ExchangeAll(origin, nextPosition)
		Execute(origin, direction)
